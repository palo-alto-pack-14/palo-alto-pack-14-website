require "net/http"
require "uri"
require "icalendar"
require "tzinfo"

module Jekyll
  # A Jekyll::Page built entirely from in-memory data (no source file on disk).
  class ScoutbookEventPage < Page
    def initialize(site, dir, name, data)
      @site = site
      @base = site.source
      @dir = dir
      @name = name
      @data = data
      @content = ""
      process(name)
    end
  end

  # Fetches the pack's Scoutbook Plus .ics calendar feed(s) at build time and
  # generates one event page per VEVENT, matching the page.event shape that
  # _layouts/event-public.html, event-private.html, and events.json expect.
  class ScoutbookCalendarGenerator < Generator
    safe true
    priority :normal

    def generate(site)
      calendars = site.config["scoutbook_calendars"]
      return if calendars.nil? || calendars.empty?

      tz = TZInfo::Timezone.get(site.config["timezone"] || "Etc/UTC")

      calendars.each do |cal_config|
        ics_text = fetch_ics(cal_config["url"])
        next unless ics_text

        events = Icalendar::Calendar.parse(ics_text).flat_map(&:events)
        events.each do |vevent|
          page = build_event_page(site, cal_config, vevent, tz)
          site.pages << page if page
        end
      rescue StandardError => e
        Jekyll.logger.warn "ScoutbookCalendar:", "Could not parse #{cal_config['url']}: #{e.message}"
      end
    end

    private

    def fetch_ics(url)
      response = Net::HTTP.get_response(URI.parse(url))
      unless response.is_a?(Net::HTTPSuccess)
        Jekyll.logger.warn "ScoutbookCalendar:", "Failed to fetch #{url} (HTTP #{response.code})"
        return nil
      end
      response.body.dup.force_encoding("UTF-8")
    rescue StandardError => e
      Jekyll.logger.warn "ScoutbookCalendar:", "Error fetching #{url}: #{e.message}"
      nil
    end

    def build_event_page(site, cal_config, vevent, tz)
      uid = text_value(vevent.uid)
      return nil if uid.empty?

      start_field = event_time_field(vevent.dtstart, tz)
      end_field = event_time_field(vevent.dtend, tz)
      return nil if start_field.empty?

      summary = text_value(vevent.summary).strip
      date_prefix = (start_field["date"] || start_field["dateTime"])[0, 10]
      uid_short = uid.split("@").first
      slug = "#{date_prefix}-#{Jekyll::Utils.slugify(summary)}-#{uid_short}"
      directory = cal_config["directory"] || "events"

      data = {
        "layout" => cal_config["layout"] || "event-public",
        "title" => summary,
        "hideTitle" => true,
        "event" => {
          "id" => uid,
          "iCalUID" => uid,
          "summary" => summary,
          "location" => text_value(vevent.location).strip,
          "description" => format_description(text_value(vevent.description)),
          "start" => start_field,
          "end" => end_field,
        },
      }

      ScoutbookEventPage.new(site, File.join(directory, slug), "index.html", data)
    end

    # Returns {"date" => "YYYY-MM-DD"} for all-day events or
    # {"dateTime" => ISO8601} converted into the configured timezone.
    def event_time_field(value, tz)
      return {} if value.nil?

      if value.is_a?(Icalendar::Values::DateTime)
        utc_time = value.to_time.utc
        offset = tz.period_for_utc(utc_time).utc_total_offset
        { "dateTime" => utc_time.getlocal(offset).iso8601 }
      else
        { "date" => value.to_date.strftime("%Y-%m-%d") }
      end
    end

    # The icalendar gem mis-parses a TEXT property into an
    # Icalendar::Values::Helpers::Array (a SimpleDelegator, not a real
    # Array) whenever the source contains an unescaped ";" — which
    # Scoutbook's feed does inside HTML entities like "&amp;". Rejoining
    # with ";" reconstructs the original text since that's the character
    # the erroneous split consumed.
    def text_value(value)
      return "" if value.nil?
      return value.join(";") if value.respond_to?(:join)

      value.to_s
    end

    def format_description(text)
      text = text.strip
      return "" if text.empty?

      text.split(/\n{2,}/).map { |para| "<p>#{para.strip.gsub("\n", "<br>")}</p>" }.join("\n")
    end
  end
end

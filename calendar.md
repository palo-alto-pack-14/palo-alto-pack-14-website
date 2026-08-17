---
layout: default
title: Pack 14 Calendar
permalink: /calendar/
navbarText: Palo Alto, CA
---

<section class="pt-4 pb-8">
  {% include calendar-widget.html %}

  <div class="mt-8">
    <h3 class="text-lg font-bold tracking-wide uppercase text-slate-700">Subscribe</h3>
    <p class="mt-2 text-sm text-slate-600">Get Pack 14 events automatically added to your calendar.</p>

    <div class="mt-4 flex flex-wrap gap-2">
      {% for cal in site.scoutbook_calendars %}
        {% if cal.name and cal.layout == 'event-public' %}
        <a href="https://calendar.google.com/calendar/render?cid={{ cal.url | replace: 'https://', 'webcal://' | url_encode }}"
           target="_blank" rel="noopener noreferrer"
           class="inline-flex items-center rounded-lg px-4 py-2 bg-yellow-400 text-cub-blue font-semibold hover:bg-yellow-300 transition">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
          </svg>
          Subscribe to Pack 14 Calendar
        </a>
        {% endif %}
      {% endfor %}
    </div>
  </div>
</section>

---
layout: default
title: Pack 14 Calendar
permalink: /calendar/
navbarText: Palo Alto, CA
---

<section class="pt-4 pb-8">
  {% include calendar-widget.html %}

  <div class="mt-8">
    <h3 class="text-lg font-bold tracking-wide uppercase text-slate-700">Subscribe in Google Calendar</h3>
    <p class="mt-2 text-sm text-slate-600">Subscribe to get Pack 14 events on your phone.</p>

    <div class="mt-4 flex flex-wrap gap-2">
      {% for cal in site.gcalendar.calendars %}
        {% if cal.name and cal.layout == 'event-public' %}
        <a href="https://calendar.google.com/calendar/render?cid={{ cal.id | url_encode }}"
           target="_blank" rel="noopener noreferrer"
           class="inline-flex items-center rounded-lg px-3 py-2 text-sm font-medium ring-1 ring-slate-300 bg-white hover:bg-slate-50">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
          </svg>
          {{ cal.name }}
        </a>
        {% endif %}
      {% endfor %}
    </div>
  </div>
</section>

---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
navbarText: Palo Alto, CA
fullBleed: true
---

<!-- HERO -->
<section class="relative">
  <div class="absolute inset-0">
    <!-- Replace with your hero image -->
    <img src="/assets/images/hero.png" alt="Cub Scouts adventure" class="object-cover w-full h-full" fetchpriority="high" decoding="async" />
    <div class="absolute inset-0 bg-black/45"></div>
  </div>
  <div class="relative max-w-6xl px-6 py-24 mx-auto text-center text-white sm:py-32">
    <h1 class="text-4xl font-extrabold tracking-wide uppercase sm:text-5xl md:text-6xl text-cub-gold">
      An Adventure of Fun and Friendship.
    </h1>
    <p class="max-w-2xl mx-auto mt-4 text-lg sm:text-xl">
      Join <span class="font-semibold">Pack 14</span> - where Palo Alto kids explore, build, and grow.
    </p>
    <div class="flex flex-wrap justify-center gap-4 mt-8">
      <a href="/join" class="inline-flex items-center px-6 py-3 font-bold transition bg-yellow-400 rounded-xl text-cub-blue hover:bg-yellow-300">
        Join Now
      </a>
      <a href="/calendar" class="inline-flex items-center px-6 py-3 font-semibold text-black transition rounded-xl bg-white/90 ring-1 ring-white/40 hover:bg-white/100">
        Upcoming Events
      </a>
    </div>
  </div>
</section>


<!-- ICE CREAM SOCIAL PROMO -->
<section class="px-6 py-8 sm:px-8 lg:px-10 bg-slate-50">
  <div class="max-w-6xl mx-auto overflow-hidden rounded-3xl bg-[#e8e4d9]">
    <div class="grid items-center gap-6 px-6 py-6 sm:px-10 sm:py-10 lg:grid-cols-2 lg:gap-0 lg:p-0">
      <div class="flex justify-center p-4 lg:p-10">
        <a href="/assets/docs/event-ice-cream-social-2026.pdf" target="_blank" rel="noopener" class="block group" aria-label="View Ice Cream Social flyer">
          <img src="/assets/images/event-ice-cream-social-2026-preview.png" alt="Ice Cream Social event flyer" class="w-auto max-h-64 sm:max-h-80 lg:max-h-none lg:w-full h-auto rounded-xl shadow-md transition-opacity group-hover:opacity-95" loading="eager" decoding="async">
        </a>
      </div>
      <div class="px-2 pb-6 text-center lg:text-left lg:px-10 lg:py-10">
        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Featured Event</p>
        <h2 class="mt-2 text-3xl font-extrabold tracking-wide uppercase sm:text-4xl" style="color:#2d7a2d;">Ice Cream Social</h2>
        <p class="mt-3 text-lg text-slate-700">Celebrate the start of a new school year with a popsicle on us! Join Pack 14, meet the Scouts, and find out what Cub Scouting is all about. All families welcome.</p>
        <a href="/assets/docs/event-ice-cream-social-2026.pdf" target="_blank" rel="noopener"
           class="inline-flex items-center gap-2 mt-6 px-6 py-3 font-bold rounded-xl text-white transition"
           style="background-color:#2d7a2d;">
          View Flyer
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </a>
      </div>
    </div>
  </div>
</section>

<!-- EVENTS / CALENDAR PREVIEW -->
{%- assign now_epoch = site.time | date: "%s" -%}
{%- assign shown = 0 -%}
{%- assign remaining_events = 0 -%}
{%- assign additional_events = '' -%}

<!-- Collect and sort events -->
{%- assign upcoming = '' | split: '' -%}
{%- for p in site.pages -%}
  {%- if p.url and p.url contains '/events/' and p.event -%}
    {%- assign ev_iso = p.event.start.dateTime | default: p.event.start.date -%}
    {%- if ev_iso -%}
      {%- assign ev_epoch = ev_iso | date: "%s" -%}
      {%- if ev_epoch >= now_epoch -%}
        {%- assign upcoming = upcoming | push: p -%}
      {%- endif -%}
    {%- endif -%}
  {%- endif -%}
{%- endfor -%}
{%- assign upcoming = upcoming | sort: 'event.sort_key' -%}

<section class="pt-16 pb-8 bg-slate-50">
  <div class="max-w-6xl px-6 mx-auto">
    <h2 class="text-2xl font-extrabold tracking-wide text-center uppercase sm:text-4xl text-cub-blue leading-1">Coming Up</h2>
    <div class="grid items-stretch gap-6 mt-10 md:grid-cols-3">
      {%- for p in upcoming -%}
        {%- if shown < 2 -%}
          {%- assign ev_iso = p.event.start.dateTime | default: p.event.start.date -%}
          {%- assign end_iso = p.event.end.dateTime | default: p.event.end.date -%}
          {%- assign ev_day  = ev_iso  | date: "%Y-%m-%d" -%}
          {%- assign end_day = end_iso | date: "%Y-%m-%d" -%}
          <article class="flex flex-col h-full bg-white shadow-sm rounded-2xl ring-1 ring-slate-200 overflow-hidden">
            <div class="h-2 bg-cub-blue"></div>
            <div class="flex flex-col flex-1 p-6">
              <p class="text-xs font-semibold uppercase tracking-widest text-cub-gold">
                {{ ev_iso | date: "%a, %b %-d" }}
                {%- if end_iso and end_day != ev_day -%}
                  &nbsp;– {{ end_iso | date: "%a, %b %-d" }}
                {%- endif -%}
                {%- if p.event.start.dateTime and end_iso and end_day == ev_day -%}
                  &nbsp;· {{ p.event.start.dateTime | date: "%-I:%M %p" }}
                {%- endif -%}
              </p>
              <h3 class="mt-2 text-lg font-bold text-slate-900 leading-snug">
                <a href="{{ p.url | relative_url }}" class="hover:underline">{{ p.title | default: "Pack Event" }}</a>
              </h3>
              {%- assign loc = p.event.location | default: p.location | default: p.venue -%}
              {%- if loc and p.layout contains "public" -%}
                {%- assign parts = loc | split: ',' -%}
                {%- if parts.size >= 3 -%}
                  {%- assign city = parts[1] | strip -%}
                {%- elsif parts.size == 2 -%}
                  {%- assign city = parts[0] | strip -%}
                {%- else -%}
                  {%- assign city = loc -%}
                {%- endif -%}
                <p class="mt-1 text-sm text-slate-500 flex items-center gap-1">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5 shrink-0" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd" />
                  </svg>
                  {{ city }}
                </p>
              {%- endif -%}
              <div class="mt-auto pt-4">
                <a href="{{ p.url | relative_url }}" class="inline-flex items-center gap-1 text-sm font-semibold text-cub-blue hover:underline">
                  Details
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                  </svg>
                </a>
              </div>
            </div>
          </article>
          {%- assign shown = shown | plus: 1 -%}
        {%- else -%}
          {%- if remaining_events < 3 -%}
            {%- assign remaining_events = remaining_events | plus: 1 -%}
            {%- assign current_ev_iso = p.event.start.dateTime | default: p.event.start.date -%}
            {%- capture event_item -%}
              <li class="pb-3 mb-3 border-b border-slate-100 last:border-0 last:mb-0 last:pb-0">
                <p class="text-sm text-slate-500">{{ current_ev_iso | date: "%b %-d" }}</p>
                <a href="{{ p.url | relative_url }}" class="font-medium hover:underline">{{ p.title | default: "Pack Event" }}</a>
              </li>
            {%- endcapture -%}
            {%- assign additional_events = additional_events | append: event_item -%}
          {%- endif -%}
        {%- endif -%}
      {%- endfor -%}
      
      <!-- Third card with list of more events -->
      {%- if remaining_events > 0 -%}
        <article class="flex flex-col h-full bg-white shadow-sm rounded-2xl ring-1 ring-slate-200 overflow-hidden">
          <div class="h-2 bg-cub-gold"></div>
          <div class="flex flex-col flex-1 p-6">
            <p class="text-xs font-semibold uppercase tracking-widest text-cub-gold">Also Coming Up</p>
            <ul class="mt-3 flex-1 text-sm divide-y divide-slate-100">
              {{ additional_events }}
            </ul>
            <div class="mt-auto pt-4">
              <a href="/events/" class="inline-flex items-center gap-1 text-sm font-semibold text-cub-blue hover:underline">
                See All Events
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                </svg>
              </a>
            </div>
          </div>
        </article>
      {%- endif -%}
    </div>

    {%- if upcoming.size == 0 -%}
      <p class="mt-6 text-center text-slate-600">No upcoming events found.</p>
    {%- endif -%}

    <div class="mt-8 text-center">
      <a href="/calendar/" class="inline-flex items-center px-5 py-3 font-semibold text-white transition rounded-lg bg-slate-900 hover:bg-slate-800">
        Full Calendar
      </a>
    </div>
  </div>
</section>

<!-- WHY CUB SCOUTING -->
<section class="max-w-6xl px-6 py-16 mx-auto">
  <div class="grid items-center gap-10 md:grid-cols-2">
    <div>
      <h2 class="text-3xl font-extrabold tracking-wide uppercase sm:text-4xl text-cub-blue">Why Cub Scouting?</h2>
      <p class="mt-4 text-lg leading-7">
        Cub Scouting is a year-round program uniquely designed to meet the needs of young boys and girls
        (kindergarten through fifth grade) and their families. The program offers fun and challenging activities
        that promote character development and physical fitness.
      </p>
      <p class="mt-4 text-lg leading-7">
        Family involvement is an essential part of the program, and parents are encouraged to play an active role.
        Cub Scouting helps parents make the most of the time they have to impact the lives of their children.
      </p>
      <div class="mt-6">
        <a href="/about" class="inline-flex items-center px-5 py-3 font-semibold text-white transition rounded-lg bg-slate-900 hover:bg-slate-800">
          Learn About Pack 14
        </a>
      </div>
    </div>
    <div class="grid grid-cols-2 gap-4">
      <!-- Swap in your own images -->
      <img src="/assets/images/why-scouting-1.png" alt="Cub Scouts adventure" class="object-cover w-full h-48 rounded-xl" loading="lazy" decoding="async">
      <img src="/assets/images/why-scouting-2.png" alt="Cub Scouts adventure" class="object-cover w-full h-48 rounded-xl" loading="lazy" decoding="async">
      <img src="/assets/images/why-scouting-3.png" alt="Cub Scouts adventure" class="object-cover w-full h-48 rounded-xl" loading="lazy" decoding="async">
      <img src="/assets/images/why-scouting-4.png" alt="Cub Scouts adventure" class="object-cover w-full h-48 rounded-xl" loading="lazy" decoding="async">
    </div>
  </div>
</section>

<!-- WHAT WE DO -->
<section class="bg-slate-50">
  <div class="max-w-6xl px-6 py-16 mx-auto">
    <h2 class="text-3xl font-extrabold tracking-wide text-center uppercase sm:text-4xl text-cub-blue">What We Do</h2>
    <p class="max-w-2xl mx-auto mt-3 text-center">
      A quick look at our favorite pack and den activities.
    </p>
    <div class="grid gap-6 mt-10 sm:grid-cols-2 lg:grid-cols-4">
      <!-- Card -->
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/camping-outdoor-adventures.png" alt="Scouts on a camping adventure" class="object-cover w-full h-40" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold">Camping & Outdoor Adventures</h3>
          <p class="mt-1 text-sm text-slate-600">Two annual camping trips, local hikes, Angel Island bike rides, and overnighters aboard the USS Hornet.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/stem-creativity.png" alt="STEM project" class="object-cover w-full h-40" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold">STEM & Creativity</h3>
          <p class="mt-1 text-sm text-slate-600">Pinewood Derby, Raingutter Regatta, hands-on projects — Scouts design, build, and discover new skills.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/community-service.png" alt="Community service" class="object-cover w-full h-40" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold">Community Service</h3>
          <p class="mt-1 text-sm text-slate-600">Scouting for Food, Memorial Day grave decorating, and service projects that make a difference.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/friendship-and-fun.png" alt="Games and fun" class="object-cover w-full h-40" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold">Fun & Friendship</h3>
          <p class="mt-1 text-sm text-slate-600">Campfire skits, team games, scavenger hunts, and group celebrations that bring our pack families together.</p>
        </div>
      </article>
    </div>
  </div>
</section>

<!-- SCOUT JOURNEY -->
<section class="bg-slate-50">
  <div class="max-w-6xl px-6 py-16 mx-auto">
    <h2 class="text-3xl font-extrabold tracking-wide text-center uppercase sm:text-4xl text-cub-blue">One Pack. Six Years of Adventure.</h2>
    <p class="max-w-2xl mx-auto mt-3 text-center text-slate-600">Follow Rhapsody's journey from kindergarten through fifth grade — every year brings new challenges, friendships, and growth.</p>
    <div class="grid gap-6 mt-10 sm:grid-cols-2 lg:grid-cols-3">
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/rhapsody/rhapsody-lions.png" alt="Rhapsody as a Lion Scout" class="object-cover w-full h-72" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold text-cub-blue">Lions (K)</h3>
          <p class="mt-1 text-sm text-slate-600">First steps into Scouting, learning through play alongside family.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/rhapsody/rhapsody-tigers.png" alt="Rhapsody as a Tiger Scout" class="object-cover w-full h-72" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold text-cub-blue">Tigers (1st)</h3>
          <p class="mt-1 text-sm text-slate-600">Exploring the world with curiosity and a growing sense of adventure.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/rhapsody/rhapsody-wolves.png" alt="Rhapsody as a Wolf Scout" class="object-cover w-full h-72" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold text-cub-blue">Wolves (2nd)</h3>
          <p class="mt-1 text-sm text-slate-600">Building skills and teamwork while doing more on their own.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/rhapsody/rhapsody-bears.png" alt="Rhapsody as a Bear Scout" class="object-cover w-full h-72" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold text-cub-blue">Bears (3rd)</h3>
          <p class="mt-1 text-sm text-slate-600">Taking on bigger challenges and discovering new interests.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/rhapsody/rhapsody-webelos.png" alt="Rhapsody as a Webelos Scout" class="object-cover w-full h-72" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold text-cub-blue">Webelos (4th)</h3>
          <p class="mt-1 text-sm text-slate-600">Preparing for the trail ahead with more independence and responsibility.</p>
        </div>
      </article>
      <article class="overflow-hidden bg-white shadow-sm rounded-2xl ring-1 ring-slate-200">
        <img src="/assets/images/rhapsody/rhapsody-arrow-of-light.png" alt="Rhapsody as an Arrow of Light Scout" class="object-cover w-full h-72" loading="lazy" decoding="async">
        <div class="p-4">
          <h3 class="font-bold text-cub-blue">Arrow of Light (5th)</h3>
          <p class="mt-1 text-sm text-slate-600">The highest Cub Scout rank, ready to cross over to Scouts BSA.</p>
        </div>
      </article>
    </div>
  </div>
</section>

<!-- BE PART OF THE PACK (Leaders + Dens) -->
<section class="max-w-6xl px-6 py-16 mx-auto">
  <div class="grid gap-12 lg:grid-cols-2">
    <!-- Leaders -->
    <div markdown="1">
      {% include leaders.md %}
</div>
    <!-- Den Finder / Schedule -->
    <div>
      <h2 class="text-3xl font-extrabold tracking-wide uppercase sm:text-4xl text-cub-blue">Find Your Den</h2>
      <p class="mt-3">We welcome all local families! We proudly serve students from Barron Park, Escondido, Fairmeadow, Hoover, Juana Briones, Nixon, Ohlone, Woodland, and many more surrounding schools.</p>
      <div class="grid gap-4 mt-6">
        <div class="flex items-center gap-4 p-4 rounded-xl ring-1 ring-slate-200">
          <img src="/assets/images/dens/Lions.png" alt="Lions den badge" class="object-contain w-12 h-12 rounded-lg ring-2 ring-yellow-400" loading="lazy" decoding="async">
          <div>
            <p class="font-semibold">Lions (K)</p>
            <p class="text-sm text-slate-600">Den meets 1 time per month</p>
          </div>
        </div>
        <div class="flex items-center gap-4 p-4 rounded-xl ring-1 ring-slate-200">
          <img src="/assets/images/dens/Tigers.png" alt="Tigers den badge" class="object-contain w-12 h-12 rounded-lg ring-2 ring-yellow-400" loading="lazy" decoding="async">
          <div>
            <p class="font-semibold">Tigers (1st)</p>
            <p class="text-sm text-slate-600">Den meets 1 time per month</p>
          </div>
        </div>
        <div class="flex items-center gap-4 p-4 rounded-xl ring-1 ring-slate-200">
          <img src="/assets/images/dens/Wolves.png" alt="Wolves den badge" class="object-contain w-12 h-12 rounded-lg ring-2 ring-yellow-400" loading="lazy" decoding="async">
          <div>
            <p class="font-semibold">Wolves (2nd)</p>
            <p class="text-sm text-slate-600">Den meets 1-2 times per month</p>
          </div>
        </div>
        <div class="flex items-center gap-4 p-4 rounded-xl ring-1 ring-slate-200">
          <img src="/assets/images/dens/Bears.png" alt="Bears den badge" class="object-contain w-12 h-12 rounded-lg ring-2 ring-yellow-400" loading="lazy" decoding="async">
          <div>
            <p class="font-semibold">Bears (3rd)</p>
            <p class="text-sm text-slate-600">Den meets 1-2 times per month</p>
          </div>
        </div>
        <div class="flex items-center gap-4 p-4 rounded-xl ring-1 ring-slate-200">
          <img src="/assets/images/dens/Webelos.png" alt="Webelos den badge" class="object-contain w-12 h-12 rounded-lg ring-2 ring-yellow-400" loading="lazy" decoding="async">
          <div>
            <p class="font-semibold">Webelos (4th)</p>
            <p class="text-sm text-slate-600">Den meets 1-2 times per month</p>
          </div>
        </div>
        <div class="flex items-center gap-4 p-4 rounded-xl ring-1 ring-slate-200">
          <img src="/assets/images/dens/Arrow of Light.png" alt="Arrow of Light den badge" class="object-contain w-12 h-12 rounded-lg ring-2 ring-yellow-400" loading="lazy" decoding="async">
          <div>
            <p class="font-semibold">Arrow of Light (5th)</p>
            <p class="text-sm text-slate-600">Den meets 1-2 times per month</p>
          </div>
        </div>
      </div>
      <p class="mt-4 text-sm text-slate-500">We meet as a Pack on the 1st Monday of each month.</p>
      <div class="mt-6">
        <a href="https://docs.google.com/forms/d/e/1FAIpQLSeZbDPpaONQh3L9yGVodE8sJ8rbmPXoBywZnY17GUBEnvHO-Q/viewform?usp=dialog" target="_blank" rel="noopener"
           class="inline-flex items-center px-5 py-3 font-semibold text-white transition rounded-lg bg-slate-900 hover:bg-slate-800">
          Ask a Question
        </a>
        <p class="mt-3 text-sm text-slate-500">
          Or email <a href="mailto:info@paloaltopack14.org" class="text-cub-blue underline decoration-cub-blue/30 underline-offset-2 hover:decoration-cub-blue">info@paloaltopack14.org</a>
        </p>
      </div>
    </div>
  </div>
</section>


<!-- TESTIMONIALS -->
<section class="max-w-6xl px-6 py-16 mx-auto">
  <h2 class="text-3xl font-extrabold tracking-wide text-center uppercase sm:text-4xl text-cub-blue">Families Love It</h2>
  <div class="grid gap-4 mt-10 md:grid-cols-2">
    <div class="flex gap-4 p-6 bg-white rounded-2xl ring-1 ring-slate-200">
      <img src="/assets/images/testimonies/rachel.png" alt="Rachel, Parent" class="object-cover w-16 h-16 rounded-full ring-2 ring-yellow-400 shrink-0" loading="lazy" decoding="async">
      <div>
        <p class="text-lg">&ldquo;Being part of Pack 14 has been an amazing experience for our family. The community is welcoming, kind, and always ready to help. The activities are fun, engaging, and thoughtfully organized. Through adventures and teamwork, kids naturally learn independence, responsibility, confidence, and how to celebrate and support their friends.&rdquo;</p>
        <p class="mt-2 text-sm text-slate-600">&mdash; Rachel, Parent</p>
      </div>
    </div>
    <div class="flex gap-4 p-6 bg-white rounded-2xl ring-1 ring-slate-200">
      <img src="/assets/images/testimonies/myles.png" alt="Myles, Scout" class="object-cover w-16 h-16 rounded-full ring-2 ring-yellow-400 shrink-0" loading="lazy" decoding="async">
      <div>
        <p class="text-lg">&ldquo;I like Pack 14 because the activities are so fun, like Pinewood Derby.&rdquo;</p>
        <p class="mt-2 text-sm text-slate-600">&mdash; Myles, Scout</p>
      </div>
    </div>
  </div>
</section>

<!-- FINAL CTA -->
<section class="max-w-6xl px-6 py-16 mx-auto text-center bg-slate-50">
  <h2 class="text-3xl font-extrabold tracking-wide uppercase sm:text-4xl text-cub-blue">Ready to Explore?</h2>
  <p class="mt-3">New to Scouting? We’ll help you get started. Everyone’s welcome.</p>
  <div class="mt-6">
    <a href="/join" class="inline-flex items-center px-6 py-3 font-bold transition bg-yellow-400 rounded-xl text-cub-blue hover:bg-yellow-300">
      Join Pack 14
    </a>
  </div>
</section>

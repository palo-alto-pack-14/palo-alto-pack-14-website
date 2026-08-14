{% comment %}
Leaders partial - a reusable component for displaying pack leaders
Parameters:
- none: uses default styling and layout
{% endcomment %}

<h2 class="text-3xl font-extrabold tracking-wide uppercase sm:text-4xl text-cub-blue">Meet the Leaders</h2>

Pack 14 is run by parents just like you. We rely on family volunteers to keep our program running. Everything we do is powered by parents chipping in to create great experiences for our Scouts!

<div class="grid gap-4 mt-6 sm:grid-cols-2" markdown="0">

{% for leader in site.data.leaders %}
  {% include leader-card.html leader=leader %}
{% endfor %}

</div>

---
layout: global
title: Dynamic
---

# Dynamic
This is a dynamic page whose contents can be defined by other files.

{% capture exists %}{% file_exists files/snippets/dynamic-snippet1.md %}{% endcapture %}
{% if exists == "true" %}
# Snippet 1
{% include_relative snippets/dynamic-snippet1.md %}
{% endif %}

{% capture exists %}{% file_exists files/snippets/dynamic-snippet2.md %}{% endcapture %}
{% if exists == "true" %}
# Snippet 2
{% include_relative snippets/dynamic-snippet2.md %}
{% endif %}

{% capture exists %}{% file_exists files/snippets/dynamic-snippet3.md %}{% endcapture %}
{% if exists == "true" %}
# Snippet 3
{% include_relative snippets/dynamic-snippet3.md %}
{% endif %}

#!jinja|yaml

include:
  - bluez.config

{% from "blueman/map.jinja" import datamap with context %}

blueman_install:
  pkg.installed:
    - pkgs: {{ datamap.lookup.pkgs }}

{% if salt['grains.get']('os_family') == 'Debian' %}
blueman_ppa_repo:
  pkgrepo:
    {%- if datamap.use_repo %}
    - managed
    {%- else %}
    - absent
    {%- endif %}
    - ppa: {{ datamap.lookup.repo }}
    - require_in:
      - pkg: blueman_install
    - watch_in:
      - pkg: blueman_install
{% endif %}

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import sysconfig with context %}

{% for label, cfg in sysconfig.network_scripts.items() %}
sysconfig_netcfg_{{ label | to_snake_case }}_file:
  file.managed:
    - name: /etc/sysconfig/network-scripts/{{ label }}
    - user: root
    - group: root
    - mode: 0644

sysconfig_netcfg_{{ label | to_snake_case }}_content:
  ini.options_present:
    - sections: {{ cfg }}
    - require:
      - file: sysconfig_netcfg_{{ label | to_snake_case }}_file
{% endfor %}

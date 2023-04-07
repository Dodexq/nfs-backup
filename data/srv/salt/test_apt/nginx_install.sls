nginx:
  pkg.installed:
    - name: nginx

nginx.service:
  service.running:
    - enable: True
    - watch:
      - pkg: nginx
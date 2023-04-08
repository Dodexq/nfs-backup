salt_exporter_tar:
  archive.extracted:
    - name: /tmp/python3.10_venv_for_salt_exporter
    - source: salt://salt_exporter/data/python3.10_venv_for_salt_exporter.tar
    - user: root
    - group: root
    - archive_format: tar
    - tar_options: '-xzf'
    - keep: False
    - skip_verify: True

folder_venv_for_salt_exporter:
  file.directory:
    - name: /opt/venv_for_salt_exporter

files_venv_for_salt_exporter:
  file.copy:
    - name: /opt/venv_for_salt_exporter/
    - source: /tmp/python3.10_venv_for_salt_exporter/
    - recursive: True

salt_exporter_service_copy:
  file.managed:
    - name: /etc/systemd/system/salt_exporter.service 
    - source: salt://salt_exporter/data/salt_exporter.service
    - user: root
    - group: root
    - mode: '0744'

salt_exporter_enable:
  service.running:
    - name: salt_exporter.service
    - enable: True
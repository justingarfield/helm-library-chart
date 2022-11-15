{{/*
The volume (referencing VPN scripts) to be inserted into additionalVolumes.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.scriptsVolumeSpec" -}}
{{- if or .Values.sidecars.vpn.scripts.up .Values.sidecars.vpn.scripts.down -}}
configMap:
  name: {{ include "helmLibraryChart.names.fullName" . }}-vpn
  items:
    {{- if .Values.sidecars.vpn.scripts.up }}
    - key: up.sh
      path: up.sh
      mode: 0777
    {{- end }}
    {{- if .Values.sidecars.vpn.scripts.down }}
    - key: down.sh
      path: down.sh
      mode: 0777
    {{- end }}
{{- end -}}
{{- end -}}

{{/*
The volume (referencing VPN config) to be inserted into additionalVolumes.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.configVolumeSpec" -}}
{{- if or .Values.sidecars.vpn.configFile .Values.sidecars.vpn.configFileSecret -}}
secret:
  {{- if .Values.sidecars.vpn.configFileSecret }}
  secretName: {{ .Values.sidecars.vpn.configFileSecret }}
  {{- else }}
  secretName: {{ include "helmLibraryChart.names.fullName" . }}-vpnconfig
  {{- end }}
  items:
    - key: vpnConfigfile
      path: vpnConfigfile
{{- end -}}
{{- end -}}

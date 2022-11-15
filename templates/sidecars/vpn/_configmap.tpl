{{/*
The VPN config and scripts to be included.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.configmap" -}}
{{- if or .Values.sidecars.vpn.scripts.up .Values.sidecars.vpn.scripts.down }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "helmLibraryChart.names.fullName" . }}-vpn
  labels: {{- include "helmLibraryChart.labels.default" $ | nindent 4 }}
  annotations: {{- include "helmLibraryChart.annotations" $ | nindent 4 }}
data:
{{- with .Values.sidecarsvpn.scripts.up }}
  up.sh: |-
    {{- . | nindent 4}}
{{- end }}
{{- with .Values.sidecarsvpn.scripts.down }}
  down.sh: |-
    {{- . | nindent 4}}
{{- end }}
{{- end -}}
{{- end -}}

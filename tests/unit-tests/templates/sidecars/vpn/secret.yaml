{{/*
The OpenVPN config secret to be included.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.secret" -}}
{{- if and .Values.sidecars.vpn.configFile (not .Values.sidecars.vpn.configFileSecret) }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "helmLibraryChart.names.fullName" . }}-vpnconfig
  labels: {{- include "helmLibraryChart.labels.default" $ | nindent 4 }}
  annotations: {{- include "helmLibraryChart.annotations" $ | nindent 4 }}
stringData:
  {{- with .Values.sidecars.vpn.configFile }}
  vpnConfigfile: |-
    {{- . | nindent 4}}
  {{- end }}
{{- end -}}
{{- end -}}

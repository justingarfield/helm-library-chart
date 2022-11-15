{{/*
The Secret object to be created.
*/}}
{{- define "helmLibraryChart.secret" }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "helmLibraryChart.names.fullName" . }}
  labels: {{- include "helmLibraryChart.labels.default" $ | nindent 4 }}
  annotations: {{- include "helmLibraryChart.annotations" $ | nindent 4 }}
type: Opaque
{{- with .Values.secret }}
stringData:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

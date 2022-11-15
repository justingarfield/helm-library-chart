{{/*
The ServiceAccount object to be created.
*/}}
{{- define "helmLibraryChart.serviceAccount" }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "helmLibraryChart.names.serviceAccountName" . }}
  labels: {{- include "helmLibraryChart.labels.default" $ | nindent 4 }}
  {{- with (merge (.Values.serviceAccount.annotations | default dict) (include "helmLibraryChart.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

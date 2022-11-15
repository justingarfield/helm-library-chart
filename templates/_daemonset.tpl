{{/*
This template serves as the blueprint for the DaemonSet objects that are created
within the common library.
*/}}
{{- define "helmLibraryChart.daemonSet" }}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: {{ include "helmLibraryChart.names.fullName" . }}
  {{- with (merge (.Values.controller.labels | default dict) (include "helmLibraryChart.labels.default" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.controller.annotations | default dict) (include "helmLibraryChart.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  selector:
    matchLabels:
      {{- include "helmLibraryChart.labels.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with include ("helmLibraryChart.podAnnotations") . }}
      annotations:
        {{- . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "helmLibraryChart.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "helmLibraryChart.controller.pod" . | nindent 6 }}
{{- end }}

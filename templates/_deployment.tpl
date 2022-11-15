{{/*
This template serves as the blueprint for the Deployment objects that are created
within the common library.
*/}}
{{- define "helmLibraryChart.deployment" }}
---
apiVersion: apps/v1
kind: Deployment
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
  replicas: {{ .Values.controller.replicas }}
  {{- $strategy := default "Recreate" .Values.controller.strategy }}
  {{- if and (ne $strategy "Recreate") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for Deployment (%s)" $strategy) }}
  {{- end }}
  strategy:
    type: {{ $strategy }}
    {{- with .Values.controller.rollingUpdate }}
      {{- if and (eq $strategy "RollingUpdate") (or .surge .unavailable) }}
    rollingUpdate:
        {{- with .unavailable }}
      maxUnavailable: {{ . }}
        {{- end }}
        {{- with .surge }}
      maxSurge: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}
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

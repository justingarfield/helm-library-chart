{{/*
This template serves as the blueprint for the StatefulSet objects that are created
within the common library.
*/}}
{{- define "helmLibraryChart.statefulSet" }}
---
apiVersion: apps/v1
kind: StatefulSet
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
  podManagementPolicy: {{ default "OrderedReady" .Values.controller.podManagementPolicy }}
  {{- $strategy := default "RollingUpdate" .Values.controller.strategy }}
  {{- if and (ne $strategy "OnDelete") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for StatefulSet (%s)" $strategy) }}
  {{- end }}
  updateStrategy:
    type: {{ $strategy }}
    {{- if and (eq $strategy "RollingUpdate") .Values.controller.rollingUpdate.partition }}
    rollingUpdate:
      partition: {{ .Values.controller.rollingUpdate.partition }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "helmLibraryChart.labels.selectorLabels" . | nindent 6 }}
  serviceName: {{ include "helmLibraryChart.names.fullName" . }}
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
  volumeClaimTemplates:
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
    - metadata:
        name: {{ $vct.name }}
      spec:
        accessModes:
          - {{ required (printf "accessMode is required for vCT %v" $vct.name) $vct.accessMode  | quote }}
        resources:
          requests:
            storage: {{ required (printf "size is required for PVC %v" $vct.name) $vct.size | quote }}
        {{- if $vct.storageClass }}
        storageClassName: {{ if (eq "-" $vct.storageClass) }}""{{- else }}{{ $vct.storageClass | quote }}{{- end }}
        {{- end }}
    {{- end }}
{{- end }}

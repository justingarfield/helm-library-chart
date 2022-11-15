{{/* Common labels shared across objects */}}
{{- define "helmLibraryChart.labels.default" -}}
helm.sh/chart: {{ include "helmLibraryChart.names.chart" . }}
{{ include "helmLibraryChart.labels.selectorLabels" . }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
  {{- with .Values.global.labels }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := tpl $v $ }}
{{ $name }}: {{ quote $value }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{- define "helmLibraryChart.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helmLibraryChart.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

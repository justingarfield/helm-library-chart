{{/* Common annotations shared across objects */}}
{{- define "helmLibraryChart.annotations" -}}
  {{- with .Values.global.annotations }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := tpl $v $ }}
{{ $name }}: {{ quote $value }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/* Determine the Pod annotations used in the controller */}}
{{- define "helmLibraryChart.podAnnotations" -}}
  {{- if .Values.podAnnotations -}}
    {{- tpl (toYaml .Values.podAnnotations) . | nindent 0 -}}
  {{- end -}}

  {{- $configMapsFound := false -}}
  {{- range $name, $configmap := .Values.configMaps -}}
    {{- if $configmap.enabled -}}
      {{- $configMapsFound = true -}}
    {{- end -}}
  {{- end -}}
  {{- if $configMapsFound -}}
    {{- printf "checksum/config: %v" (include ("helmLibraryChart.configMaps") . | sha256sum) | nindent 0 -}}
  {{- end -}}
{{- end -}}

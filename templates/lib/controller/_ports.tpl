{{/*
Ports included by the controller.
*/}}
{{- define "helmLibraryChart.controller.ports" -}}
  {{- $ports := list -}}
  {{- range .Values.service -}}
    {{- if .enabled -}}
      {{- range $name, $port := .ports -}}
        {{- if .enabled -}}
          {{- $_ := set $port "name" $name -}}
          {{- $ports = mustAppend $ports $port -}}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}

{{/* export/render the list of ports */}}
{{- if $ports -}}
{{- range $_ := $ports }}
- name: {{ .name }}
  {{- if and .targetPort (kindIs "string" .targetPort) }}
  {{- fail (printf "These charts do not support named ports for targetPort. (port name %s, targetPort %s)" .name .targetPort) }}
  {{- end }}
  containerPort: {{ .targetPort | default .port }}
  {{- if .protocol }}
  {{- if or ( eq .protocol "HTTP" ) ( eq .protocol "HTTPS" ) ( eq .protocol "TCP" ) }}
  protocol: TCP
  {{- else }}
  protocol: {{ .protocol }}
  {{- end }}
  {{- else }}
  protocol: TCP
  {{- end }}
{{- end -}}
{{- end -}}
{{- end -}}

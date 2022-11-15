{{/*
Template to render netshoot addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "helmLibraryChart.sidecar.netshoot" -}}
{{- if .Values.sidecars.netshoot.enabled -}}
  {{/* Append the netshoot container to the additionalContainers */}}
  {{- $container := include "helmLibraryChart.sidecar.netshoot.container" . | fromYaml -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-netshoot" $container -}}
  {{- end -}}
{{- end -}}
{{- end -}}

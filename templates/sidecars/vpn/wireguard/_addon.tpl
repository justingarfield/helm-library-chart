{{/*
Template to render Wireguard addon. It will add the container to the list of additionalContainers.
*/}}
*/}}
{{- define "helmLibraryChart.sidecar.vpn.wireguard" -}}
  {{/* Append the Wireguard container to the additionalContainers */}}
  {{- $container := fromYaml (include "helmLibraryChart.sidecar.vpn.wireguard.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-wireguard" $container -}}
  {{- end -}}
{{- end -}}

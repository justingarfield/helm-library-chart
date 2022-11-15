{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "helmLibraryChart.sidecar.vpn" -}}
{{- if .Values.sidecars.vpn.enabled -}}
  {{- if eq "wireguard" .Values.sidecars.vpn.type -}}
    {{- include "helmLibraryChart.sidecar.wireguard" . }}
  {{- end -}}

  {{- if eq "gluetun" .Values.sidecars.vpn.type -}}
    {{- include "helmLibraryChart.sidecar.gluetun" . }}
  {{- end -}}

  {{/* Include the configmap if not empty */}}
  {{- $configmap := include "helmLibraryChart.sidecar.vpn.configmap" . -}}
  {{- if $configmap -}}
    {{- $configmap | nindent 0 -}}
  {{- end -}}

  {{/* Include the secret if not empty */}}
  {{- $secret := include "helmLibraryChart.sidecar.vpn.secret" . -}}
  {{- if $secret -}}
    {{- $secret | nindent 0 -}}
  {{- end -}}

  {{/* Append the vpn scripts volume to the volumes */}}
  {{- $scriptVolume := include "helmLibraryChart.sidecar.vpn.scriptsVolumeSpec" . | fromYaml -}}
  {{- if $scriptVolume -}}
    {{- $_ := set .Values.persistence "vpnscript" (dict "enabled" "true" "mountPath" "-" "type" "custom" "volumeSpec" $scriptVolume) -}}
  {{- end -}}

  {{/* Append the vpn config volume to the volumes */}}
  {{- $configVolume := include "helmLibraryChart.sidecar.vpn.configVolumeSpec" . | fromYaml }}
  {{ if $configVolume -}}
    {{- $_ := set .Values.persistence "vpnconfig" (dict "enabled" "true" "mountPath" "-" "type" "custom" "volumeSpec" $configVolume) -}}
  {{- end -}}

  {{/* Include the networkpolicy if not empty */}}
  {{- $networkpolicy := include "helmLibraryChart.sidecar.vpn.networkpolicy" . -}}
  {{- if $networkpolicy -}}
    {{- $networkpolicy | nindent 0 -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Main entrypoint for the helm-library-chart library chart. It will render all underlying templates based on the provided values to generate a final Kubernetes manifest.
*/}}
{{- define "helmLibraryChart.kubernetesManifest" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "helmLibraryChart.values.setup" . }}

  {{- /* Enable VPN add-on if required */ -}}
  {{- if .Values.sidecars.vpn.enabled }}
    {{- include "helmLibraryChart.sidecar.vpn" . }}
  {{- end -}}

  {{- /* Enable netshoot add-on if required */ -}}
  {{- if .Values.sidecars.netshoot.enabled }}
    {{- include "helmLibraryChart.sidecar.netshoot" . }}
  {{- end -}}

  {{ include "helmLibraryChart.configMaps" . | nindent 0 }}

  {{- /* Build the templates */ -}}
  {{- include "helmLibraryChart.persistentVolumeClaims" . }}

  {{- if .Values.serviceAccount.create -}}
    {{- include "helmLibraryChart.serviceAccount" . }}
  {{- end -}}

  {{- if .Values.controller.enabled }}
    {{- if eq .Values.controller.type "deployment" }}
      {{- include "helmLibraryChart.deployment" . | nindent 0 }}
    {{ else if eq .Values.controller.type "daemonset" }}
      {{- include "helmLibraryChart.daemonset" . | nindent 0 }}
    {{ else if eq .Values.controller.type "statefulset"  }}
      {{- include "helmLibraryChart.statefulset" . | nindent 0 }}
    {{ else }}
      {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) }}
    {{- end -}}
  {{- end -}}

  {{ include "helmLibraryChart.services" . | nindent 0 }}

  {{ include "helmLibraryChart.ingresses" .  | nindent 0 }}

  {{- if .Values.secret -}}
    {{ include "helmLibraryChart.secret" .  | nindent 0 }}
  {{- end -}}

{{- end -}}

{{/*
Blueprint for the NetworkPolicy object that can be included in the addon.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.networkpolicy" -}}
{{- if .Values.sidecars.vpn.networkPolicy.enabled }}
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: {{ include "helmLibraryChart.names.fullName" . }}
  {{- with (merge (.Values.sidecars.vpn.networkPolicy.labels | default dict) (include "helmLibraryChart.labels.default" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.sidecars.vpn.networkPolicy.annotations | default dict) (include "helmLibraryChart.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  podSelector:
    {{- with (merge .Values.sidecars.vpn.networkPolicy.podSelectorLabels (include "helmLibraryChart.labels.selectorLabels" . | fromYaml)) }}
    matchLabels: {{- toYaml . | nindent 6 }}
    {{- end }}
  policyTypes:
    - Egress
  egress:
    {{- with .Values.sidecars.vpn.networkPolicy.egress }}
      {{- . | toYaml | nindent 4 }}
    {{- end -}}
{{- end -}}
{{- end -}}

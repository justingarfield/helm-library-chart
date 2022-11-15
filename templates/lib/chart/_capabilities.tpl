{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "helmLibraryChart.capabilities.ingress.apiVersion" -}}
  {{- print "networking.k8s.io/v1" -}}
  {{- if semverCompare "<1.19" (default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride) -}}
    {{- print "beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "helmLibraryChart.capabilities.ingress.isStable" -}}
  {{- if eq (include "helmLibraryChart.capabilities.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
    {{- true -}}
  {{- else -}}
    {{- false -}}
  {{- end -}}
{{- end -}}

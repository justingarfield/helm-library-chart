{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "helmLibraryChart.ingress" -}}
  {{- $fullName := include "helmLibraryChart.names.fullName" . -}}
  {{- $ingressName := $fullName -}}
  {{- $values := .Values.ingress -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.ingress -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $ingressName = printf "%v-%v" $ingressName $values.nameOverride -}}
  {{- end -}}

  {{- $primaryService := get .Values.service (include "helmLibraryChart.services.primary" .) -}}
  {{- $defaultServiceName := $fullName -}}
  {{- if and (hasKey $primaryService "nameOverride") $primaryService.nameOverride -}}
    {{- $defaultServiceName = printf "%v-%v" $defaultServiceName $primaryService.nameOverride -}}
  {{- end -}}
  {{- $defaultServicePort := get $primaryService.ports (include "helmLibraryChart.service.ports.primary" (dict "values" $primaryService)) -}}
  {{- $isStable := include "helmLibraryChart.capabilities.ingress.isStable" . }}
---
apiVersion: {{ include "helmLibraryChart.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  {{- with (merge ($values.labels | default dict) (include "helmLibraryChart.labels.default" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "helmLibraryChart.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if and $isStable $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  {{- if $values.tls }}
  tls:
    {{- range $values.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ tpl . $ | quote }}
        {{- end }}
      {{- if .secretName }}
      secretName: {{ tpl .secretName $ | quote}}
      {{- end }}
    {{- end }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ tpl .host $ | quote }}
      http:
        paths:
          {{- range .paths }}
          {{- $service := $defaultServiceName -}}
          {{- $port := $defaultServicePort.port -}}
          {{- if .service -}}
            {{- $service = default $service .service.name -}}
            {{- $port = default $port .service.port -}}
          {{- end }}
          - path: {{ tpl .path $ | quote }}
            {{- if $isStable }}
            pathType: {{ default "Prefix" .pathType }}
            {{- end }}
            backend:
              {{- if $isStable }}
              service:
                name: {{ $service }}
                port:
                  number: {{ $port }}
              {{- else }}
              serviceName: {{ $service }}
              servicePort: {{ $port }}
              {{- end }}
          {{- end }}
  {{- end }}
{{- end }}

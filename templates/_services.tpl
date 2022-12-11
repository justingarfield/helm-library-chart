{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "helmLibraryChart.services" -}}
  {{- /* Generate named services as required */ -}}
  {{- range $name, $service := .Values.service }}
    {{- if $service.enabled -}}
      {{- $serviceValues := $service -}}

      {{/* set the default nameOverride to the service name */}}
      {{- if and (not $serviceValues.nameOverride) (ne $name (include "helmLibraryChart.services.primary" $)) -}}
        {{- $_ := set $serviceValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
      {{- include "helmLibraryChart.service" $ }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Return the primary service object
*/}}
{{- define "helmLibraryChart.services.primary" -}}
  {{- $enabledServices := dict -}}
  {{- range $serviceName := (keys .Values.service | sortAlpha) -}}
    {{- $service := (get $.Values.service $serviceName) -}}
    {{- if $service.enabled -}}
      {{- $_ := set $enabledServices $serviceName $service -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $service := $enabledServices -}}
    {{- if and (hasKey $service "primary") $service.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledServices | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}

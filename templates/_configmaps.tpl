{{/*
Renders the configMap objects required by the chart.
*/}}
{{- define "helmLibraryChart.configMaps" -}}
  {{- /* Generate named configMaps as required */ -}}
  {{- range $name, $configMap := .Values.configMaps }}
    {{- if $configMap.enabled -}}
      {{- $configMapValues := $configMap -}}

      {{/* set the default nameOverride to the configMap name */}}
      {{- if not $configMapValues.nameOverride -}}
        {{- $_ := set $configMapValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "configMap" $configMapValues) -}}
      {{- include "helmLibraryChart.configMap" $ }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
This template serves as a blueprint for all configMap objects that are created
within the common library.
*/}}
{{- define "helmLibraryChart.configMap" -}}
  {{- $fullName := include "helmLibraryChart.names.fullName" . -}}
  {{- $configMapName := $fullName -}}
  {{- $configMapValues := .Values.configMap -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.configMap -}}
      {{- $configMapValues = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $configMapValues "nameOverride") $configMapValues.nameOverride -}}
    {{- $configMapName = printf "%v-%v" $configMapName $configMapValues.nameOverride -}}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configMapName }}
  {{- with (merge ($configMapValues.labels | default dict) (include "helmLibraryChart.labels.default" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($configMapValues.annotations | default dict) (include "helmLibraryChart.annotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
data:
{{- with $configMapValues.data }}
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- end }}

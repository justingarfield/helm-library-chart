{{/* Merge the local chart values and the helmLibraryChart chart defaults */}}
{{- define "helmLibraryChart.values.setup" -}}
  {{- if .Values.helmLibraryChart -}}
    {{- $defaultValues := deepCopy .Values.helmLibraryChart -}}
    {{- $userValues := deepCopy (omit .Values "helmLibraryChart") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end -}}
{{- end -}}

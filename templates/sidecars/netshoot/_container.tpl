{{/*
The netshoot sidecar container to be inserted.
*/}}
{{- define "helmLibraryChart.sidecar.netshoot.container" -}}
name: netshoot
image: "{{ .Values.sidecars.netshoot.image.repository }}:{{ .Values.sidecars.netshoot.image.tag }}"
imagePullPolicy: {{ .Values.sidecars.netshoot.image.pullPolicy }}
{{- with .Values.sidecars.netshoot.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.sidecars.netshoot.env }}
env:
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
{{- end }}
command:
  - /bin/sh
  - -c
  - sleep infinity
{{- with .Values.sidecars.netshoot.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}

{{/*
The gluetun sidecar container to be inserted.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.gluetun.container" -}}
name: gluetun
image: "{{ .Values.sidecars.vpn.gluetun.image.repository }}:{{ .Values.sidecars.vpn.gluetun.image.tag }}"
imagePullPolicy: {{ .Values.sidecars.vpn.gluetun.pullPolicy }}
{{- with .Values.sidecars.vpn.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.sidecars.vpn.env }}
env:
  {{- . | toYaml | nindent 2 }}
{{- end }}
{{- with .Values.sidecars.vpn.envFrom }}
envFrom:
  {{- . | toYaml | nindent 2 }}
{{- end }}
{{- with .Values.sidecars.vpn.args }}
args:
  {{- . | toYaml | nindent 2 }}
{{- end }}
{{- if or .Values.sidecars.vpn.configFile .Values.sidecars.vpn.configFileSecret .Values.sidecars.vpn.scripts.up .Values.sidecars.vpn.scripts.down .Values.sidecars.vpn.additionalVolumeMounts .Values.persistence.shared.enabled }}
volumeMounts:
{{- if or .Values.sidecars.vpn.configFile .Values.sidecars.vpn.configFileSecret }}
  - name: vpnconfig
    mountPath: /gluetun/config.conf
    subPath: vpnConfigfile
{{- end }}
{{- if .Values.sidecars.vpn.scripts.up }}
  - name: vpnscript
    mountPath: /gluetun/scripts/up.sh
    subPath: up.sh
{{- end }}
{{- if .Values.sidecars.vpn.scripts.down }}
  - name: vpnscript
    mountPath: /gluetun/scripts/down.sh
    subPath: down.sh
{{- end }}
{{- if .Values.persistence.shared.enabled }}
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
{{- end }}
{{- with .Values.sidecars.vpn.additionalVolumeMounts }}
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- with .Values.sidecars.vpn.livenessProbe }}
livenessProbe:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- with .Values.sidecars.vpn.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}

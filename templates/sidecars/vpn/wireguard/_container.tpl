{{/*
The Wireguard sidecar container to be inserted.
*/}}
{{- define "helmLibraryChart.sidecar.vpn.wireguard.container" -}}
name: wireguard
image: "{{ .Values.sidecars.vpn.wireguard.image.repository }}:{{ .Values.sidecars.vpn.wireguard.image.tag }}"
imagePullPolicy: {{ .Values.sidecars.vpn.wireguard.pullPolicy }}
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
    mountPath: /etc/wireguard/wg0.conf
    subPath: vpnConfigfile
{{- end }}
{{- if .Values.sidecars.vpn.scripts.up }}
  - name: vpnscript
    mountPath: /config/up.sh
    subPath: up.sh
{{- end }}
{{- if .Values.sidecars.vpn.scripts.down }}
  - name: vpnscript
    mountPath: /config/down.sh
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

{{/*
Generate Async-related application properties
*/}}
{{- define "async-application-properties" -}}

# Async mocking support.
async-api.enabled={{ .Values.async.enabled }}
async-api.default-binding={{ .Values.async.defaultBinding }}
async-api.default-frequency={{ .Values.async.defaultFrequency }}
{{- end -}}
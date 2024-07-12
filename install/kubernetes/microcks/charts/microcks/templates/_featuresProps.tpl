{{/*
Generate the features-properties content
*/}}
{{- define "features-properties" -}}
features.feature.microcks-hub.enabled={{ .Values.features.microcksHub.enabled }}
features.feature.microcks-hub.endpoint=https://hub.microcks.io/api
features.feature.microcks-hub.allowed-roles={{ .Values.features.microcksHub.allowedRoles }}

features.feature.repository-filter.enabled={{ .Values.features.repositoryFilter.enabled }}
features.feature.repository-filter.label-key={{ .Values.features.repositoryFilter.labelKey }}
features.feature.repository-filter.label-label={{ .Values.features.repositoryFilter.labelLabel }}
features.feature.repository-filter.label-list={{ .Values.features.repositoryFilter.labelList }}

features.feature.repository-tenancy.enabled={{ .Values.features.repositoryTenancy.enabled }}
features.feature.repository-tenancy.artifact-import-allowed-roles={{ .Values.features.repositoryTenancy.artifactImportAllowedRoles }}

features.feature.async-api.enabled={{ .Values.features.async.enabled }}
features.feature.async-api.default-binding={{ .Values.features.async.defaultBinding }}
features.feature.async-api.endpoint-WS={{ ( include "microcks-ws.url" . ) }}
features.feature.async-api.endpoint-KAFKA={{- include microcks.kafka.fullUrl }}
{{- if .Values.features.async.mqtt.url }}
features.feature.async-api.endpoint-MQTT={{ .Values.features.async.mqtt.url }}
{{- end }}
{{- if .Values.features.async.amqp.url }}
features.feature.async-api.endpoint-AMQP={{ .Values.features.async.amqp.url }}
{{- end }}
{{- if .Values.features.async.nats.url }}
features.feature.async-api.endpoint-NATS={{ .Values.features.async.nats.url }}
{{- end }}
{{- if .Values.features.async.googlepubsub.project }}
features.feature.async-api.endpoint-GOOGLEPUBSUB={{ .Values.features.async.googlepubsub.project }}
{{- end }}
{{- if .Values.features.async.sqs.region }}
features.feature.async-api.endpoint-SQS={{ .Values.features.async.sqs.region }}{{ if .Values.features.async.sqs.endpointOverride }} at {{ .Values.features.async.sqs.endpointOverride }}{{ end }}
{{- end }}
{{- if .Values.features.async.sns.region }}
features.feature.async-api.endpoint-SNS={{ .Values.features.async.sns.region }}{{ if .Values.features.async.sns.endpointOverride }} at {{ .Values.features.async.sns.endpointOverride }}{{ end }}
{{- end }}

features.feature.ai-copilot.enabled={{ .Values.features.aiCopilot.enabled }}

{{- end }}
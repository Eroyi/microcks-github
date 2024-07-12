{{/*
Detect and return the kafka's url
*/}}
{{- define "microcks.kafka.url" -}}
  {{- $url := ternary .Values.externalDependencies.kafka.url "kafka" .Values.externalDependencies.kafka.enabled -}}
  {{- $url -}}
{{- end -}}

{{/*
Detect and return the kafka's port
*/}}
{{- define "microcks.kafka.port" -}}
  {{- $port := "" -}}
  {{- if .Values.externalDependencies.kafka.enabled -}}
    {{- $port = .Values.externalDependencies.kafka.port -}}
  {{- else if .Values.kafka.install -}}
    {{- $port = ternary (default "9094" .Values.kafka.externalAccess.controller.service.ports.external) (default "9092" .Values.kafka.listeners.controller.containerPort) .Values.kafka.externalAccess.enabled -}}
  {{- end -}}
  {{- $port -}}
{{- end -}}

{{/*
Detect and return the kafka's protocol
*/}}
{{- define "microcks.kafka.protocol" -}}
  {{- $defaultProtocol := "PLAINTEXT" -}}
  {{- $protocol := "" -}}
  {{- if .Values.externalDependencies.kafka.enabled -}}
    {{- $protocol = default $defaultProtocol .Values.externalDependencies.kafka.protocol -}}
  {{- else if .Values.kafka.install -}}
    {{- $protocol = default $defaultProtocol .Values.kafka.listeners.controller -}}
  {{- end -}}
  {{- $protocol -}}
{{- end -}}

{{/*
Assemble Kafka's connection URL
*/}}
{{- define "microcks.kafka.fullUrl" -}}
  {{- $protocol := include "microcks.kafka.protocol" . -}}
  {{- $url := include "microcks.kafka.url" . -}}
  {{- $port := include "microcks.kafka.port" . -}}
  {{- $fullUrl := printf "%s://%s:%s" $protocol $url $port -}}
  {{- $fullUrl -}}
{{- end -}}


{{/*
Detect and return the schema registry's url
*/}}
{{- define "microcks.schemaRegistry.url" -}}
  {{- $url := ternary .Values.externalDependencies.schema-registry.url "schema-registry" .Values.externalDependencies.schema-registry.enabled -}}
  {{- $url -}}
{{- end -}}

{{/*
Detect and return the schema registry's port
*/}}
{{- define "microcks.schemaRegistry.port" -}}
  {{- $port := ternary .Values.externalDependencies.schema-registry.port "8081" .Values.externalDependencies.schema-registry.enabled -}}
  {{- $port -}}
{{- end -}}
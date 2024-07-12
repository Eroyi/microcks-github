{{/*
Detect and return the Microcks's url
*/}}
{{- define "microcks.microcks.url" -}}
  {{- $url := .Values.microcks.config.url -}}
  {{- $url -}}
{{- end -}}

{{/*
Detect and return the Microcks's protocol
*/}}
{{- define "microcks.microcks.protocol" -}}
  {{- $protocol := ternary "https" "http" .Values.microcks.config.ssl }}
  {{- $protocol -}}
{{- end -}}

{{/*
Detect and return the Microcks's connect port
*/}}
{{- define "microcks.microcks.port" -}}
  {{- $port := default 8080 .Values.microcks.service.targetPort -}}
  {{- $port -}}
{{- end -}}

{{/*
Assemble Microcks's connection URL
*/}}
{{- define "microcks.microcks.fullUrl" -}}
  {{- $protocol := include "microcks.microcks.protocol" . -}}
  {{- $url := include "microcks.microcks.url" . -}}
  {{- $port := include "microcks.microcks.port" . -}}
  {{- $fullUrl := printf "%s://%s:%s" $protocol $url $port -}}
  {{- $fullUrl -}}
{{- end -}}

{{/*
Realm labels
*/}}
{{- define "microcks-realm-labels" -}}
  {{- range $name, $value := .Values.microcks.realm.labels }}
    {{ $name }}: {{ $value | quote }}
  {{- end -}}
{{- end -}}

{{/*
Realm annotations
*/}}
{{- define "microcks-realm-annotations" -}}
  {{- range $name, $value := .Values.microcks.realm.annotations }}
    {{ $name }}: {{ $value | quote }}
  {{- end -}}
{{- end -}}

{{/*
Generate Microcks-related application properties
*/}}
{{- define "microcks-application-properties" -}}
# Microcks application properties
validation.resourceUrl={{ include "microcks.microcks.fullUrl" . }}/api/resources/
services.update.interval=${SERVICES_UPDATE_INTERVAL:0 0 0/2 * * *}
mocks.rest.enable-cors-policy=${ENABLE_CORS_POLICY:true}
{{- if eq .Values.microcks.config.mockInvocationStats false }}
mocks.enable-invocation-stats=false
{{- end }}

# Grpc server properties
{{- if .Values.microcks.config.grpcEnableTLS }}
grpc.server.certChainFilePath=/deployments/config/grpc/tls.crt
grpc.server.privateKeyFilePath=/deployments/config/grpc/tls.key
{{- end }}

# AI Copilot configuration properties
ai-copilot.enabled={{ .Values.microcks.features.aiCopilot.enabled }}
ai-copilot.implementation={{ .Values.microcks.features.aiCopilot.implementation }}
{{- if eq .Values.microcks.features.aiCopilot.implementation "openai" }}
ai-copilot.openai.api-key={{ .Values.microcks.features.aiCopilot.openai.apiKey }}
  {{- if .Values.microcks.features.aiCopilot.openai.timeout }}
ai-copilot.openai.timeout={{ .Values.microcks.features.aiCopilot.openai.timeout }}
  {{- end }}
  {{- if .Values.microcks.features.aiCopilot.openai.model }}
ai-copilot.openai.model={{ .Values.microcks.features.aiCopilot.openai.model }}
  {{- end }}
  {{- if .Values.microcks.features.aiCopilot.openai.maxTokens }}
ai-copilot.openai.maxTokens={{ .Values.microcks.features.aiCopilot.openai.maxTokens }}
  {{- end }}
{{- end }}
{{- end -}}
{{/*
Print the image
*/}}
{{- define "microcks.image" -}}
{{- $image := printf "%s:%s" .repository .tag }}
{{- if .registry }}
{{- $image = printf "%s/%s" .registry $image }}
{{- end }}
{{- $image -}}
{{- end }}

{{/*
Microcks labels
*/}}
{{- define "microcks-pod-labels" -}}
{{- range $name, $value := .Values.microcks.labels }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
Microcks annotations
*/}}
{{- define "microcks-pod-annotations" -}}
{{- range $name, $value := .Values.microcks.annotations }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}


{{/*
Microcks Service labels
*/}}
{{- define "microcks-service-labels" -}}
{{- range $name, $value := .Values.microcks.service.labels }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
Microcks Service annotations
*/}}
{{- define "microcks-service-annotations" -}}
{{- range $name, $value := .Values.microcks.service.annotations }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}


{{/*
Microcks Ingress labels
*/}}
{{- define "microcks-ingress-labels" -}}
{{- range $name, $value := .Values.microcks.ingresses.labels }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
Microcks Ingress annotations
*/}}
{{- define "microcks-ingress-annotations" -}}
{{- range $name, $value := .Values.microcks.ingresses.annotations }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
Microcks Configmap labels
*/}}
{{- define "microcks-ingress-labels" -}}
{{- range $name, $value := .Values.microcks.configmap.labels }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
Microcks Ingress annotations
*/}}
{{- define "microcks-ingress-annotations" -}}
{{- range $name, $value := .Values.microcks.configmap.annotations }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}



{{/*
GRPC Service labels
*/}}
{{- define "grpc-service-labels" -}}
{{- range $name, $value := .Values.grpc.service.labels }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
GRPC Service annotations
*/}}
{{- define "grpc-service-annotations" -}}
{{- range $name, $value := .Values.grpc.service.annotations }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
GRPC Ingress labels
*/}}
{{- define "grpc-ingresses-labels" -}}
{{- range $name, $value := .Values.grpc.ingresses.labels }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
GRPC Ingress annotations
*/}}
{{- define "grpc-ingresses-annotations" -}}
{{- range $name, $value := .Values.grpc.ingresses.annotations }}
{{ $name }}: {{ $value | quote }}
{{- end -}}
{{- end -}}



{{/*
Generate certificates for microcks ingress
*/}}
{{- define "microcks-ingress.gen-certs" -}}
{{- $cert := genSelfSignedCert .Values.microcks.config.url nil nil 365 -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end -}}


{{/*
Produce GRPC Ingress URL
*/}}
{{- define "microcks-grpc.url" -}}
"{{ regexReplaceAll "^([^.-]+)(.*)" .Values.microcks.config.url "${1}-grpc${2}" }}"
{{- end -}}


{{/*
Generate certificates for microcks GRPC service
*/}}
{{- define "microcks-grpc.gen-certs" -}}
{{- $grpcUrl := regexReplaceAll "^([^.-]+)(.*)" .Values.microcks.config.url "${1}-grpc${2}" -}}
{{- $grpcSvc := print .Values.appName "-grpc." .Release.Namespace ".svc.cluster.local" -}}
{{- $cert := genSelfSignedCert .Values.microcks.config.url nil (list $grpcUrl $grpcSvc "localhost") 3650 -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end -}}

{{/*
Produce WS Ingress URL
*/}}
{{- define "microcks-ws.url" -}}
{{ regexReplaceAll "^([^.-]+)(.*)" .Values.microcks.config.url "${1}-ws${2}" }}
{{- end -}}

{{/*
Generate certificates for microcks WS ingress
*/}}
{{- define "microcks-ws-ingress.gen-certs" -}}
{{- $wsUrl := regexReplaceAll "^([^.-]+)(.*)" .Values.microcks.config.url "${1}-ws${2}" -}}
{{- $cert := genSelfSignedCert $wsUrl nil (list $wsUrl "localhost") 3650 -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end -}}
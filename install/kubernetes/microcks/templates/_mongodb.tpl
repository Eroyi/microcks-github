{{/*
Detect and return the MongoDB's url
*/}}
{{- define "microcks.mongodb.url" -}}
  {{- $url := "" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $url = .Values.externalDependencies.mongodb.url -}}
  {{- else if .Values.mongodb.install -}}
    {{- $url = "mongodb" -}}
  {{- end -}}
  {{- $url -}}
{{- end -}}

{{/*
Detect and return the MongoDB's Port
*/}}
{{- define "microcks.mongodb.port" -}}
  {{- $port := 27017 -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $port = .Values.externalDependencies.mongodb.port -}}
  {{- else if .Values.mongodb.install -}}
    {{- $port = .Values.mongodb.containerPorts.mongodb -}}
  {{- end -}}
  {{- $port -}}
{{- end -}}


{{/*
Detect and return the MongoDB's database
*/}}
{{- define "microcks.mongodb.database" -}}
  {{- $database := "microcks" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $database = .Values.externalDependencies.mongodb.database | default "microcks" -}}
  {{- end -}}
  {{- $database -}}
{{- end -}}

{{/*
Detect and return the MongoDB's username in plaintext
*/}}
{{- define "microcks.mongodb.username" -}}
  {{- $username := "" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $username = .Values.externalDependencies.mongodb.auth.username -}}
  {{- else if .Values.mongodb.install -}}
    {{- $username = .Values.mongodb.rootUser -}}
  {{- end -}}
  {{- $username -}}
{{- end -}}

{{/*
Detect and return the MongoDB's password in plaintext
*/}}
{{- define "microcks.mongodb.password" -}}
  {{- $password := "" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $password = .Values.externalDependencies.mongodb.auth.password -}}
  {{- else if .Values.mongodb.install -}}
    {{- $password = .Values.mongodb.rootPassword -}}
  {{- end -}}
  {{- $password -}}
{{- end -}}

{{/*
Detect and return the MongoDB's authenticates in secret
*/}}
{{- define "microcks.mongodb.secretRef.secret" -}}
  {{- $secret := "" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $secret = .Values.externalDependencies.mongodb.auth.secretRef.secret -}}
  {{- else if .Values.mongodb.install -}}
    {{- if .Values.mongodb.auth.existingSecret | default "" -}}
      {{- $secret = .Values.mongodb.auth.existingSecret -}}
    {{- else -}}
      {{- $secret = printf "%s-mongodb-connection" .Values.appName -}}
    {{- end -}}
  {{- end -}}
  {{- $secret -}}
{{- end -}}

{{/*
Detect and return the MongoDB's username key in secret
*/}}
{{- define "microcks.mongodb.secretRef.usernameKey" -}}
  {{- $usernameKey := "" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $usernameKey = .Values.externalDependencies.mongodb.auth.secretRef.usernameKey -}}
  {{- else if .Values.mongodb.install -}}
    {{- if .Values.mongodb.auth.existingSecret | default "" -}}
      {{- $usernameKey = "" -}}
    {{- else -}}
      {{- $usernameKey = "username" -}}
    {{- end -}}
  {{- end -}}
  {{- $usernameKey -}}
{{- end -}}

{{/*
Detect and return the MongoDB's password key in secret
*/}}
{{- define "microcks.mongodb.secretRef.passwordKey" -}}
  {{- $passwordKey := "" -}}
  {{- if .Values.externalDependencies.mongodb.enabled -}}
    {{- $passwordKey = .Values.externalDependencies.mongodb.auth.secretRef.passwordKey -}}
  {{- else if .Values.mongodb.install -}}
    {{- if .Values.mongodb.auth.existingSecret | default "" -}}
      {{- $passwordKey = "mongodb-root-password" -}}
    {{- else -}}
      {{- $passwordKey = "password" -}}
    {{- end -}}
  {{- end -}}
  {{- $passwordKey -}}
{{- end -}}
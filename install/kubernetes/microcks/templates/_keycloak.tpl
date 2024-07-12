{{/*
Detect and return the Keycloak's url
*/}}
{{- define "microcks.keycloak.url" -}}
  {{- $url := ternary .Values.externalDependencies.keycloak.url "keycloak" .Values.externalDependencies.keycloak.enabled -}}
  {{- $url -}}
{{- end -}}

{{/*
Detect and return the Keycloak's Port
*/}}
{{- define "microcks.keycloak.port" -}}
  {{- $port := ternary .Values.externalDependencies.keycloak.port "80" .Values.externalDependencies.keycloak.enabled -}}
  {{- $port -}}
{{- end -}}

{{/*
Detect and return the Keycloak's username in plaintext
*/}}
{{- define "microcks.keycloak.username" -}}
  {{- $username := ternary .Values.externalDependencies.keycloak.auth.adminUsername .Values.keycloak.auth.adminUser .Values.externalDependencies.keycloak.enabled -}}
  {{- $username -}}
{{- end -}}


{{/*
Detect and return the Keycloak's password in plaintext
*/}}
{{- define "microcks.keycloak.password" -}}
  {{- $password := ternary .Values.externalDependencies.keycloak.auth.adminPassword (.Values.keycloak.auth.adminPassword | default "") .Values.externalDependencies.keycloak.enabled -}}
  {{- $password -}}
{{- end -}}


{{/*
Detect and return the Keycloak's authenticates in secret
*/}}
{{- define "microcks.keycloak.secretRef.secret" -}}
  {{- $secret := "" -}}
  {{- if .Values.externalDependencies.keycloak.enabled -}}
    {{- $secret = .Values.externalDependencies.keycloak.auth.secretRef.secret -}}
  {{- else if .Values.keycloak.install -}}
    {{- if .Values.keycloak.auth.existingSecret | default "" -}}
      {{- $secret = .Values.keycloak.auth.existingSecret -}}
    {{- else -}}
      {{- $secret = printf "%s-keycloak-admin" .Values.appName -}}
    {{- end -}}
  {{- end -}}
  {{- $secret -}}
{{- end -}}

{{/*
Detect and return the Keycloak's username key in secret
*/}}
{{- define "microcks.keycloak.secretRef.usernameKey" -}}
  {{- $usernameKey := "" -}}
  {{- if .Values.externalDependencies.keycloak.enabled -}}
    {{- $usernameKey = .Values.externalDependencies.keycloak.auth.secretRef.usernameKey -}}
  {{- else if .Values.keycloak.install -}}
    {{- if .Values.keycloak.auth.existingSecret | default "" -}}
      {{- $usernameKey = "" -}}
    {{- else -}}
      {{- $usernameKey = "username" -}}
    {{- end -}}
  {{- end -}}
  {{- $usernameKey -}}
{{- end -}}

{{/*
Detect and return the Keycloak's password key in secret
*/}}
{{- define "microcks.keycloak.secretRef.passwordKey" -}}
  {{- $passwordKey := "" -}}
  {{- if .Values.externalDependencies.keycloak.enabled -}}
    {{- $passwordKey = .Values.externalDependencies.keycloak.auth.secretRef.passwordKey -}}
  {{- else if .Values.keycloak.install -}}
    {{- if .Values.keycloak.auth.existingSecret | default "" -}}
      {{- $passwordKey = "admin-password" -}}
    {{- else -}}
      {{- $passwordKey = "password" -}}
    {{- end -}}
  {{- end -}}
  {{- $passwordKey -}}
{{- end -}}

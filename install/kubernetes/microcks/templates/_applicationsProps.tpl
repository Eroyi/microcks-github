{{/*
Generate the application-properties content
*/}}
{{- define "applicatoin-properties" -}}
# Application configuration properties
tests-callback.url=${TEST_CALLBACK_URL}
postman-runner.url=${POSTMAN_RUNNER_URL}
async-minion.url=${ASYNC_MINION_URL|http://localhost:8081}

network.username=
network.password=

# Logging configuration properties
logging.config=/deployments/config/logback.xml

# Spring Security adapter configuration properties
spring.security.oauth2.client.registration.keycloak.client-id=microcks-app
spring.security.oauth2.client.registration.keycloak.authorization-grant-type=authorization_code
spring.security.oauth2.client.registration.keycloak.scope=openid,profile
spring.security.oauth2.client.provider.keycloak.issuer-uri=${KEYCLOAK_URL}/realms/${keycloak.realm}
spring.security.oauth2.client.provider.keycloak.user-name-attribute=preferred_username
spring.security.oauth2.resourceserver.jwt.issuer-uri=${sso.public-url}/realms/${keycloak.realm}
{{- if and .Values.externalDependencies.keycloak.enabled (ne (include "microcks.keycloak.secretRef.secret" .) "") }}
spring.security.oauth2.resourceserver.jwt.jwk-set-uri=${KEYCLOAK_URL}/realms/${keycloak.realm}/protocol/openid-connect/certs
{{- end }}

# Keycloak configuration properties
keycloak.auth-server-url=${KEYCLOAK_URL}
keycloak.realm={{- include microcks.realm.name -}}
keycloak.resource=microcks-app
keycloak.use-resource-role-mappings=true
keycloak.bearer-only=true
keycloak.ssl-required=external
keycloak.disable-trust-manager=true

# Keycloak access configuration properties
sso.public-url=${KEYCLOAK_PUBLIC_URL:${keycloak.auth-server-url}}

# Async mocking support.
{{ include "async-application-properties" . }}

# Kafka configuration properties
spring.kafka.producer.bootstrap-servers=${KAFKA_BOOTSTRAP_SERVER:localhost:9092}
  {{- if and (eq .Values.kafka.install false) (.Values.externalDependencies.kafka.enabled) }}
  {{- if eq .Values.externalDependencies.kafka.auth.type "SSL" }}
spring.kafka.producer.properties.security.protocol=SSL
  {{- if .Values.externalDependencies.kafka.auth.truststoreSecretRef }}
spring.kafka.producer.properties.ssl.truststore.location=/deployments/config/kafka/truststore/{{ .Values.externalDependencies.kafka.auth.truststoreSecretRef.storeKey }}
spring.kafka.producer.properties.ssl.truststore.password=${KAFKA_TRUSTSTORE_PASSWORD}
spring.kafka.producer.properties.ssl.truststore.type={{ .Values.externalDependencies.kafka.auth.truststoreType }}
  {{- end }}
spring.kafka.producer.properties.ssl.keystore.location=/deployments/config/kafka/keystore/{{ .Values.externalDependencies.kafka.auth.keystoreSecretRef.storeKey }}
spring.kafka.producer.properties.ssl.keystore.password=${KAFKA_KEYSTORE_PASSWORD}
spring.kafka.producer.properties.ssl.keystore.type={{ .Values.externalDependencies.kafka.auth.keystoreType }}
  {{- else if eq .Values.externalDependencies.kafka.auth.type "SASL_SSL" }}
spring.kafka.producer.properties.security.protocol=SASL_SSL
  {{- if .Values.externalDependencies.kafka.auth.truststoreSecretRef }}
spring.kafka.producer.properties.ssl.truststore.location=/deployments/config/kafka/truststore/{{ .Values.externalDependencies.kafka.auth.truststoreSecretRef.storeKey }}
spring.kafka.producer.properties.ssl.truststore.password=${KAFKA_TRUSTSTORE_PASSWORD}
spring.kafka.producer.properties.ssl.truststore.type={{ .Values.externalDependencies.kafka.auth.truststoreType }}
  {{- end }}
spring.kafka.producer.properties.sasl.mechanism={{ .Values.externalDependencies.kafka.auth.saslMechanism }}
spring.kafka.producer.properties.sasl.jaas.config={{ .Values.externalDependencies.kafka.auth.saslJaasConfig }}
    {{- if .Values.externalDependencies.kafka.auth.saslLoginCallbackHandlerClass }}
spring.kafka.producer.properties.sasl.login.callback.handler.class={{ .Values.externalDependencies.kafka.auth.saslLoginCallbackHandlerClass }}
    {{- end }}
  {{- end }}
{{- end }}

{{ include "microcks-application-properties" . }}
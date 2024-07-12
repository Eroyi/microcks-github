{{/*
Define the realm name
*/}}
{{- define "microcks.realm.name" -}}
  {{- $name := .Values.microcks.realms.realmName -}}
{{- end -}}



{{/*
Generate the microcks-realm.json content
*/}}
{{- define "microcks-realm-json" -}}
{
  "id": "microcks",
  "realm": "{{- include microcks.realm.name }}",
  "displayName": "Microcks",
  "notBefore": 0,
  "revokeRefreshToken": false,
  "refreshTokenMaxReuse": 0,
  "accessTokenLifespan": 300,
  "accessTokenLifespanForImplicitFlow": 900,
  "ssoSessionIdleTimeout": 1800,
  "ssoSessionMaxLifespan": 36000,
  "offlineSessionIdleTimeout": 2592000,
  "accessCodeLifespan": 60,
  "accessCodeLifespanUserAction": 300,
  "accessCodeLifespanLogin": 1800,
  "actionTokenGeneratedByAdminLifespan": 43200,
  "actionTokenGeneratedByUserLifespan": 300,
  "enabled": true,
  "sslRequired": "external",
  "registrationAllowed": false,
  "registrationEmailAsUsername": false,
  "rememberMe": false,
  "verifyEmail": false,
  "loginWithEmailAllowed": true,
  "duplicateEmailsAllowed": false,
  "resetPasswordAllowed": false,
  "editUsernameAllowed": false,
  "bruteForceProtected": false,
  "permanentLockout": false,
  "maxFailureWaitSeconds": 900,
  "minimumQuickLoginWaitSeconds": 60,
  "waitIncrementSeconds": 60,
  "quickLoginCheckMilliSeconds": 1000,
  "maxDeltaTimeSeconds": 43200,
  "failureFactor": 30,
  "users": [
    {{- range $index, $user := .Values.microcks.realm.users }}
    {
      "username": "{{ $user.username | default (printf "user%d" (add1 $index)) }}",
      "enabled": true,
      "credentials": [
        {
          "type": "password",
          "value": "{{ $user.password | default "microcks123" }}"
        }
      ],
      "realmRoles": [],
      "applicationRoles": {
        "microcks-app": [{{- range $i, $role := $user.roles }}{{ if $i }}, {{ end }}"{{ $role }}"{{- end }}]
      }
    }{{- if lt $index (sub (len .Values.microcks.realm.users) 1) }},{{ end }}
    {{- end }}
  ],
  "roles": {
    "realm": [],
    "client": {
      "microcks-app": [
        {{- range $index, $user := .Values.microcks.realm.users }}
        {{- range $role := $user.roles }}
        {
          "name": "{{ $role }}",
          "composite": false,
          "clientRole": true,
          "containerId": "microcks"
        }{{- if or (lt (add $index 1) (len $user.roles)) (lt $index (sub (len .Values.microcks.realm.users) 1)) }},{{ end }}
        {{- end }}
        {{- end }}
      ]
    }
  },
  "groups": [
    {
      "name": "microcks",
      "path": "/microcks",
      "attributes": {},
      "realmRoles": [],
      "clientRoles": {},
      "subGroups": [
        {
          "name": "manager",
          "path": "/microcks/manager",
          "attributes": {},
          "realmRoles": [],
          "clientRoles": {},
          "subGroups": []
        }
      ]
    }
  ],
  "defaultRoles": [ ],
  "requiredCredentials": [ "password" ],
  "scopeMappings": [],
  "clientScopeMappings": {
    "microcks-app": [
      {
        "client": "microcks-app-js",
        "roles": [
          {{- range $index, $user := .Values.microcks.realm.users }}
          {{- range $i, $role := $user.roles }}
          "{{ $role }}"{{- if or (lt $i (sub (len $user.roles) 1)) (lt $index (sub (len .Values.microcks.realm.users) 1)) }},{{ end }}
          {{- end }}
          {{- end }}
        ]
      }
    ],
    "realm-management": [
      {
        "client": "microcks-app-js",
        "roles": [
          "manage-users",
          "manage-clients"
        ]
      }
    ]
  },
  "clients": [
    {
      "clientId": "microcks-app-js",
      "enabled": true,
      "publicClient": true,
      "redirectUris": [
        "{{- include microcks.microcks.fullUrl -}}/*"
      ],
      "webOrigins": [
        "+"
      ],
      "fullScopeAllowed": false,
      "protocolMappers": [
        {
          "name": "microcks-group-mapper",
          "protocol": "openid-connect",
          "protocolMapper": "oidc-group-membership-mapper",
          "consentRequired": false,
          "config": {
            "full.path": "true",
            "id.token.claim": "true",
            "access.token.claim": "true",
            "claim.name": "microcks-groups",
            "userinfo.token.claim": "true"
          }
        }
      ]
    }
  ],
  "applications": [
    {
      "name": "microcks-app",
      "enabled": true,
      "bearerOnly": true,
      "defaultRoles": [
        {{- with index .Values.microcks.realm.users 0 }}
        {{- range $i, $role := .roles }}
        "{{ $role }}"{{- if lt $i (sub (len .roles) 1) }},{{ end }}
        {{- end }}
        {{- end }}
      ]
    }
  ],
  "identityProviders": [
  ],
  "keycloakVersion": "10.0.1"
}
{{- end -}}
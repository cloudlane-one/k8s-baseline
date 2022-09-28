{{/*
Generate hostname from domain and subdomain.

Params:
  - service - String - Required - Name of the service to generate a hostname for.
  - context - Context - Required - Parent context.

Usage:
{{ include "get_hostname" (dict "service" "my-service" "context" $) }}

*/}}
{{- define "get_hostname" -}}
  {{ $subdomain := .service }}
  {{- if hasKey .context.Values.subdomains .service }}
    {{- $subdomain = index .context.Values.subdomains .service -}}
  {{- end -}}
  {{ printf "%s.%s" $subdomain .context.Values.domain }}
{{- end -}}

{{/*
Generate annotations for autheticating an nginx ingress via oauth2-proxy, 
making it available only to admins.

Usage:
{{ include "admin_auth_annotations" . }}

*/}}
{{- define "admin_auth_annotations" -}}
nginx.ingress.kubernetes.io/auth-response-headers: Authorization
nginx.ingress.kubernetes.io/auth-signin: {{ printf "https://%s/oauth2/start?rd=$scheme%3A%2F%2F$host$escaped_request_uri" (include "get_hostname" (dict "service" "oauth2_proxy" "context" $)) }}
nginx.ingress.kubernetes.io/auth-url: {{ printf "https://%s/oauth2/auth" (include "get_hostname" (dict "service" "oauth2_proxy" "context" $)) }}
{{- end -}}

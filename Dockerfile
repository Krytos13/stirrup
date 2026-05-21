FROM nginxinc/nginx-unprivileged:1.31-alpine
COPY k8s/static/ /usr/share/nginx/html/
# Explicit USER satisfies Trivy DS-0002; base image already runs non-root.
USER nginx

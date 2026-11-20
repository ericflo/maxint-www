# syntax=docker/dockerfile:1@sha256:87999aa3d42bdc6bea60565083ee17e86d1f3339802f543c0d03998580f9cb89

FROM docker.io/library/nginx:1.30.7-alpine@sha256:caf4e1e032a20f9c3c5e28fc7f25ffd768ad8677b4975c54193075997b3a97e3
# The fixed official image is available before nginx-unprivileged. Preserve
# UID 101 and its writable /tmp paths; application listeners stay on 8080.
RUN sed -i '/^user /d; s@^pid .*;@pid /tmp/nginx.pid;@' /etc/nginx/nginx.conf && \
    sed -i '/^http {/a\    client_body_temp_path /tmp/client_temp;\n    proxy_temp_path /tmp/proxy_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;' /etc/nginx/nginx.conf


# Apply stable Alpine security fixes released after the pinned base was built.
USER root
RUN apk upgrade --no-cache && apk add --no-cache 'libxml2>=2.13.9-r3'
USER 101

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY site/index.html /usr/share/nginx/html/index.html

EXPOSE 8080

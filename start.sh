#!/bin/bash
set -e
echo ">> Configuration de x-ui (port=${XUI_PORT}, user=${XUI_USERNAME})"
/usr/local/x-ui/x-ui setting -username "${XUI_USERNAME:-admin}" -password "${XUI_PASSWORD:-changeme}" -port "${XUI_PORT:-54321}" || true
echo ">> Démarrage de supervisord (x-ui en foreground)"
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

#!/bin/bash
set -e

# Remover servidor caso ainda esteja rodando
rm -f /app/tmp/pids/server.pid

# Executar comando passado para o container
exec "$@" 
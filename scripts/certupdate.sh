#!/usr/bin/env bash

DOMAIN="jhardydnd.quest"
LOGFILE="/var/log/letsencrypt/renew-$DOMAIN.log"

echo "=== Renewing SSL certificate for $DOMAIN ==="
date

certbot certonly --standalone \
  --cert-name "$DOMAIN" \
  -d "$DOMAIN" \
  --agree-tos \
  -m hardythedrummer@gmail.com \
  --quiet >> "$LOGFILE" 2>&1

# Reload your web server
pm2 restart all

echo "=== Renewal attempt complete ==="
date
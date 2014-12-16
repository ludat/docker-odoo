#!/bin/bash


# YOUR_ODOO_FOLDER=""
# YOUR_ODOO_CONFIG_FILE=""
# YOUR_ODOO_ADDITIONAL_ADDONS=""
VOLUMES=""

if [ -n "$YOUR_ODOO_FOLDER" ]; then
    VOLUMES="$VOLUMES -v $YOUR_ODOO_FOLDER:/opt/odoo ";
fi

if [ -n "$YOUR_ODOO_CONFIG_FILE" ]; then
    VOLUMES="$VOLUMES -v $YOUR_ODOO_CONFIG_FILE:/etc/odoo.conf ";
fi

if [ -n "$YOUR_ODOO_ADDITIONAL_ADDONS" ]; then
    VOLUMES="$VOLUMES -v $YOUR_ODOO_ADDITIONAL_ADDONS:/additional_addons ";
fi

# this is what starts your ERP server with odoo version 8.0
docker run --rm -p 80:8069 --name odoo --link pg:db \
    $VOLUMES \
    ludat/odoo start

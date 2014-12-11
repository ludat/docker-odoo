#!/bin/bash

# this is what starts your ERP server with odoo version 8.0
docker run -p 8069:8069 --name odoo --link pg:db -v YOUR_ODOO_FOLDER_PATH:/opt/odoo -v YOUR_ODOO_CONFIG_FILE:/etc/odoo.conf -v YOUR_ODOO_ADDITIONAL_ADDONS:/additional_addons odoo start

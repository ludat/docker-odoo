#!/bin/bash

# Start the postgresql container and ser the password and the user for odoo
docker run --name pg -e POSTGRES_PASSWORD=password -e POSTGRES_USER=odoo postgres:9

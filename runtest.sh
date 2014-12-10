#!/bin/bash

# this is what starts an interactive shell within your container
docker run -ti --rm --link pg:db odoo /bin/bash

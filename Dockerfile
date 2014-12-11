FROM ludat/odoo-base:8.0
MAINTAINER lucas6246@gmail.com

# changing user is required by openerp which won't start with root
# makes the container more unlikely to be unwillingly changed in interactive mode
USER odoo

# Execution environment
WORKDIR /opt/odoo
VOLUME ["/opt/odoo", "/etc/odoo.conf", "/additionnal_addons"]
# Set the default entrypoint (non overridable) to run when starting the container
USER 0
ENTRYPOINT ["/bin/boot.sh"]
CMD ["help"]
# Expose the odoo ports (for linked containers)
EXPOSE 8069
ADD bin/boot.sh bin/help.txt /bin/

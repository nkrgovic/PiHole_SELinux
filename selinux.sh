#!/bin/bash
# Written for PiHole by Nikola Krgovic (nkrgovic at gmail dot com )
# Release under EUPL

# Set SE Linux Booleans required for PiHole 

setsebool -P nis_enabled on
setsebool -P domain_can_mmap_files on

# More, http specific, booleans

setsebool -P httpd_run_stickshift on
setsebool -P httpd_setrlimit on
setsebool -P httpd_mod_auth_pam on
setsebool -P httpd_can_network_connect on

# Build a custom policy module and install it.

checkmodule -M -m -o /tmp/pihole.mod pihole.te
semodule_package -o /tmp/pihole.pp -m /tmp/pihole.mod

semodule -i /tmp/pihole.pp

# Clean up, remove the files. 

rm /tmp/pihole.mod /tmp/pihole.pp 

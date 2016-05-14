## Environment
import_env LIGHTTPD_CONFIG
export_env LIGHTTPD_DOMAINS /host/etc/lighttpd

## Configuration
echo "include_shell \"cat $LIGHTTPD_DOMAINS/*.conf\"" >> $LIGHTTPD_CONFIG
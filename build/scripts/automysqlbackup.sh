## Environment
export_env AUTOMYSQLBACKUP_VERSION_MAJOR 3.0
export_env AUTOMYSQLBACKUP_VERSION_MINOR rc6
export_env AUTOMYSQLBACKUP_VERSION v${AUTOMYSQLBACKUP_VERSION_MAJOR}_${AUTOMYSQLBACKUP_VERSION_MINOR}
export_env AUTOMYSQLBACKUP_CONFIG /etc/automysqlbackup/automysqlbackup.conf
export_env AUTOMYSQLBACKUP_DATA /host/var/backup/db

## AutoMySQLBackup
apt_install_permanent mysql-client
cd /opt
wget "http://downloads.sourceforge.net/project/automysqlbackup/AutoMySQLBackup/AutoMySQLBackup VER $AUTOMYSQLBACKUP_VERSION_MAJOR/automysqlbackup-$AUTOMYSQLBACKUP_VERSION.tar.gz"
mkdir automysqlbackup
tar xzf automysqlbackup-$AUTOMYSQLBACKUP_VERSION.tar.gz -C automysqlbackup
mkdir -p `dirname $AUTOMYSQLBACKUP_CONFIG`
cp /opt/automysqlbackup/automysqlbackup.conf $AUTOMYSQLBACKUP_CONFIG

## Configuration
sed -i "s,^#\(CONFIG_mysql_dump_username=\).*$,\1'backup'," $AUTOMYSQLBACKUP_CONFIG
sed -i "s,^#\(CONFIG_mysql_dump_host=\).*$,\1'mysql'," $AUTOMYSQLBACKUP_CONFIG
sed -i "s,^#\(CONFIG_backup_dir=\).*$,\1'/host/var/backup/db'," $AUTOMYSQLBACKUP_CONFIG
sed -i "s,^#\(CONFIG_db_exclude=\).*$,\1( 'mysql' 'information_schema' 'performance_schema' )," $AUTOMYSQLBACKUP_CONFIG
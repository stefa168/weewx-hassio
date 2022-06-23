#!/usr/bin/with-contenv bashio

CONF_DIR="/config/weewx"
CONF_FILE="${CONF_DIR}/weewx.conf"

if [ ! -f "${CONF_FILE}" ]; then
  echo "Configuration file missing; creating one!"
  mkdir -p $CONF_DIR
  cp /home/weewx/weewx.conf ${CONF_FILE}
  echo "Default configuration copied into ${CONF_FILE}. Weewx will not be started this time."
  exit 1
fi

#cat /var/log/messages

#echo "#########################################"
echo "Starting weewx"

syslogd && /home/weewx/bin/weewxd /config/weewx/weewx.conf
#tail -f /var/log/messages && /home/weewx/bin/weewxd /config/weewx/weewx.conf
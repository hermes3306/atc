#!/bin/bash

source /root/.bash_profile

#exec server start

ADMIN="${ALTIBASE_HOME}/bin/isql -u sys -p MANAGER -sysdba -noprompt"

${ADMIN} << EOF
startup
EOF

tail -f /dev/null
…


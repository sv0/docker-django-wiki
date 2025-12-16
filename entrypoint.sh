#!/bin/sh

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable

# https://github.com/dylanaraps/pure-bash-bible

set -e

cd /app
# python3 create_admin_user.py \
#     --username "$ADMIN_USER" \
#     --password "$ADMIN_PASSWORD" \
#     --email "$ADMIN_EMAIL"

echo "params:" $*
# if [ -z ${DEBUG+0} ];
# then
#     DEBUG="0"
# fi

# if [ "${DEBUG}" == "0" ] || [ "${DEBUG}" == "no" ] || [ "${DEBUG}" == "false" ];
# then
gunicorn \
    --workers 4 \
    --log-level debug \
    --bind 0.0.0.0:8000 \
    --reload \
    --enable-stdio-inheritance wsgi
# else
#     python3 manage.py runserver 0.0.0.0:8000
# fi;

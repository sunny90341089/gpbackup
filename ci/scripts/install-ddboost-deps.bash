#!/bin/bash

set -ex

ccp_src/scripts/setup_ssh_to_cluster.sh
scp -r gpbackup_ddboost_plugin mdw:/home/gpadmin/gpbackup_ddboost_plugin
ssh -t centos@mdw "sudo yum install -y autoconf automake libtool"

if test -f pgcrypto43/pgcrypto*; then
  scp -r pgcrypto43/pgcrypto-ossv1.1_pv1.3_gpdb4.3orca-rhel5-x86_64.gppkg mdw:.
  ssh -t gpadmin@mdw "source env.sh; gppkg -i pgcrypto-ossv1.1_pv1.3_gpdb4.3orca-rhel5-x86_64.gppkg"
  ssh -t gpadmin@mdw "source env.sh; psql -d postgres -f \$GPHOME/share/postgresql/contrib/pgcrypto.sql"
else
  ssh -t gpadmin@mdw "source env.sh; psql -d postgres -c 'CREATE EXTENSION pgcrypto;'"
fi

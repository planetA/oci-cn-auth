ITERATION=$1
VERSION=0.2.2
PRODUCT_NAME=cn-auth
RPM_NAME=oci-${PRODUCT_NAME}
VENDOR=Oracle
URL="http://oracle.com"
LICENSE="UPL-1.0"
DESCRIPTION="This software provides auto configuration of wpa supplicant for Oracle cloud cluster network."

fpm -s dir \
  -f -n oci-cn-auth \
  -t rpm \
  --version "$VERSION" \
  --iteration "$ITERATION" \
  --category Tools \
  -a noarch \
  --license "$LICENSE" \
  --description "$DESCRIPTION" \
  --vendor "$VENDOR" \
  -d "python3-requests" -d "python3-pyOpenSSL" -d "python3-jinja2" -d "python3-psutil" -d "python3-cryptography" -d "wpa_supplicant" \
  --after-install scripts/after-install.sh \
  --after-remove scripts/after-remove.sh \
  --after-upgrade scripts/after-upgrade.sh \
  --before-install scripts/before-install.sh \
  --before-remove scripts/before-remove.sh \
  --before-upgrade scripts/before-upgrade.sh \
  --prefix / \
  --config-files /etc/rdma/oracle_rdma.conf \
  src/var/lib/=/var/lib/ \
  src/bin/oci-cn-auth=/usr/bin/oci-cn-auth \
  src/etc/rdma/oracle_rdma.conf=/etc/rdma/oracle_rdma.conf \
  src/var/lib/oci-cn-auth/share/oci-cn-auth.service=/lib/systemd/system/oci-cn-auth.service \
  src/var/lib/oci-cn-auth/share/oci-cn-auth.timer=/lib/systemd/system/oci-cn-auth.timer \
  src/var/lib/oci-cn-auth/bin/ifup-rdma=/sbin/ifup-local

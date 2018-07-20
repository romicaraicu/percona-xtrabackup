FROM percona:5.6

ENV SCRIPTS_DEPS=" \
    https://raw.githubusercontent.com/do-community/ubuntu-1604-mysql-backup/master/object_storage.py \
    https://raw.githubusercontent.com/do-community/ubuntu-1604-mysql-backup/master/backup-mysql.sh \
    https://raw.githubusercontent.com/do-community/ubuntu-1604-mysql-backup/master/extract-mysql.sh \
    https://raw.githubusercontent.com/do-community/ubuntu-1604-mysql-backup/master/prepare-mysql.sh"

RUN echo 'deb-src https://repo.percona.com/apt jessie main' >> /etc/apt/sources.list
RUN apt-get update && yes N | apt-get install -y \
  --no-install-suggests percona-xtrabackup-24 qpress curl wget \
  && rm -rf /var/lib/apt/lists/*
RUN wget ${SCRIPTS_DEPS} -P /usr/local/bin/ \
    && chmod +x /usr/local/bin/*-mysql.sh
RUN mkdir -p /data/backups/

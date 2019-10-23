FROM		ubuntu
MAINTAINER	jason.park@altibase.com
RUN 		apt-get -y update
RUN 		apt-get install vim -y
COPY 		AB71	/opt/AB71
WORKDIR		/opt/AB71

EXPOSE		20300
RUN		/opt/AB71/install/post_install.sh dbcreate
#CMD		/opt/AB71/bin/startdb.sh
CMD		/bin/bash

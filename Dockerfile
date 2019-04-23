#
#  Author: Matias Andres Perez
#  Date: 2019-04-01
#
#  Desc: Creacion de una imagen base de hadoop (sin instalar ni configurar  nada).
#        Con Java 1.8 
#        Hadoop 3.2
#        Librerias Ubuntu necesarias
#
#        matt68/hadoop-base
#
FROM  ubuntu:16.04
LABEL MAINTAINER="Matias Andres (https://www.linkedin.com/in/matias-andres-formador-db2-jcl-datastage-52a46b31/)"
LABEL DESCRIPTION="Imagen base para formar un cluster hadoop en docker"

ARG HADOOP_VERSION=3.2.0

USER root

# Java
RUN apt-get update && apt-get install -y openjdk-8-jdk wget

# Hadoop
# Lo dejamos en /usr/local/hadoop
RUN wget http://apache.cs.utah.edu/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
RUN tar zxf hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local/                 && \
    rm -f hadoop-${HADOOP_VERSION}.tar.gz                                  && \
	  cd /usr/local && ln -s ./hadoop-${HADOOP_VERSION} hadoop
	
# Descargamos algunas librerias 
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils        \ 
    build-essential  \ 
    curl             \ 
	  iproute2         \ 
	  iputils-ping     \
    libfreetype6-dev \
    libpng12-dev     \
    libzmq3-dev      \
    netbase          \
	  openssh-client   \
	  openssh-server   \
    pkg-config       \
    rsync            \ 
	  rsyslog          \
    software-properties-common \
	  snappy           \
	  sudo             \
	  ssh              \
    unzip            \
  	vim              \ 
    &&               \
    apt-get clean &&     \
    rm -rf /var/lib/apt/lists/*

# Hasta aqui la imagen base. 
# El resto de configuraciones las hacemos en imagenes que parten de esta	
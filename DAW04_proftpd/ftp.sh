#!/bin/sh
# Actualizar repositorios
apt-get update
# Actualizar sistema operativo
apt-get upgrade
# Buscar paquete proftpd
apt-cache search proftpd
# Instalar paquete proftpd-basic
apt-get install proftpd-basic
## apt-get install proftpd-core
##apt-get install proftpd-mod-crypto
## dpkg -L proftpd-core | less 
## nano /etc/hosts
## IP ftp.empresa-tarea-daw04.local
## comprueba con un ping ip
## car /etc/passwd

## nano /etc/shells añadir /bin/false

apt-get install filezilla
# Ruta de configuración de ProFTPD: /etc/proftpd
ls -l /etc/proftpd
# Servicio proftpd: Posibilidades
/etc/init.d/proftpd start
# Servicio proftpd: Posibilidades

##Copia de seguridad
cp /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.bak1

cp /etc/proftpd/modules.conf /etc/proftpd/modules.conf.bak1

cp /etc/proftpd/tls.conf /etc/proftpd/tls.conf.bak1

cp /etc/proftpd/virtuals.conf /etc/proftpd/virtuals.conf.bak1

## En /etc/proftpd/proftpd.conf con DefaultRoot lo encarcelas y RequiredValidShell off (lo hacemos en el virtual)

#service proftpd
mkdir /var/ftp/
mkdir /var/ftp/todo-empresa-tarea-daw04
chown ftp /var/ftp/todo-empresa-tarea-daw04

id ftp
ftpasswd --passwd --name direccion --file /etc/passwd.usuarios.virtuales --uid 131 --home /var/ftp/todo-empresa-tarea-daw04 --shell /bin/false


# Con esta configuración cualquier usuario del sistema puede acceder por ftp

# Modificar /etc/proftpd/proftpd.conf y descomentar la línea: Include /etc/proftpd/tls.conf
TEMPORAL=`mktemp`
cat /etc/proftpd/proftpd.conf | sed "s/\#Include \/etc\/proftpd\/tls.conf/Include \/etc\/proftpd\/tls.conf/g" > $TEMPORAL
mv $TEMPORAL /etc/proftpd/proftpd.conf

# Modificar /etc/proftpd/proftpd.conf y descomentar la línea: Include /etc/proftpd/virtuals.conf

cat /etc/proftpd/proftpd.conf | sed "s/\#Include \/etc\/proftpd\/virtuals.conf/Include \/etc\/proftpd\/virtuals.conf/g" > $TEMPORAL
mv $TEMPORAL /etc/proftpd/proftpd.conf

# Modificar /etc/proftpd/modules.conf y descomentar la línea: #LoadModule mod_tls.c

cat /etc/proftpd/modules.conf | sed "s/\#LoadModule mod_tls.c/LoadModule mod_tls.c/g" > $TEMPORAL
mv $TEMPORAL /etc/proftpd/modules.conf

# Modificar /etc/proftpd/tls.conf para que tenga el siguiente contenido:
cat > /etc/proftpd/tls.conf << EOF
##########################################Fichero /etc/proftpd/tls.conf###############################################
#
# Proftpd sample configuration for FTPS connections.
#
# Note that FTPS impose some limitations in NAT traversing.
# See http://www.castaglia.org/proftpd/doc/...
# for more information.
#

<IfModule mod_tls.c>
<global>
TLSEngine                               on
TLSLog                                  /var/log/proftpd/tls.log
</global>


TLSProtocol                             SSLv23

<global>
TLSRSACertificateFile                   /etc/ssl/certs/proftpd.crt
TLSRSACertificateKeyFile                /etc/ssl/private/proftpd.key
TLSOptions                              NoCertRequest
TLSVerifyClient                         off
TLSRequired                             on
TLSRenegotiate                          required off
</global>
</IfModule>

###########################################Fin /etc/proftpd/tls.conf###############################################

EOF

#saber la ip
ifconfig

# Modificar /etc/proftpd/virtuals.conf para que tenga el siguiente contenido:
cat > /etc/proftpd/virtuals.conf << EOF
##########################################Fichero /etc/proftpd/virtuals.conf###############################################
#
# Proftpd sample configuration for FTPS connections.
#
# Note that FTPS impose some limitations in NAT traversing.
# See http://www.castaglia.org/proftpd/doc/...
# for more information.
#

<VirtualHost 192.168.226.129>
    ServerName "empresa-tarea-daw04"
    AuthUserFile /etc/passwd.usuarios.virtuales
    DefaultRoot /var/ftp/todo-empresa-tarea-daw04
    RequireValidShell off
</VirtualHost>

###########################################Fin /etc/proftpd/virtuals.conf###############################################

EOF

# Generar el certificado el mismo commun name que el nombre del servidor
proftpd-gencert

# Puedes recargar la nueva configuración con:
/etc/init.d/proftpd reload
## ó
## service proftpd reload

# Puedes reiniciar el servicio mediante:
/etc/init.d/proftpd restart
## ó
## service proftpd restart

# Con esta nueva configuración puedes acceder mediante FTPES
# Para ello crearemos una Plantilla en FileZilla:
## 1) Ver script FileZilla_Perfiles.sh en el vídeo:  
##    FileZilla. Crear sitios (perfiles) -->   

 #• FileZilla. Crear ...  
## 2) Arrancar FileZilla como usuario del sistema alumno.
  #    su -c filezilla alumno

# Para desinstalar proftpd
# apt-get remove proftpd

## Archivos de registro en /var/log/proftpd
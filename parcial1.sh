#!/bin/bash
clear
cd
dir_inicial=$(pwd)
cd /var/www/html/so/
if [ -d "/var/www/html/so/$USER" ]; 
then
	echo "El Diretorio que quiere crear ya existe, se pasará directamente al siguiente paso"
else
	mkdir $USER
	"Se creó el directorio /var/www/html/so/$USER"
fi
cd $USER
wget -N https://raw.githubusercontent.com/marcosricciardi12/so2021morsa/master/index.html #Descargo index.html de mi propio repo de git

#punto 4
#4.1 Mostrar Fecha y hora de ejecucion del script
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html
echo "<h3 style=\"color: #229954; font-weight: 900;\">FECHA Y HORA DE EJECUCIÓN DEL SCRIPT:</h3><p><img src=https://us.123rf.com/450wm/ahasoft2000/ahasoft20001601/ahasoft2000160102630/51026650-fecha-hora-de-iconos-de-vectores-el-estilo-es-el-s%C3%ADmbolo-c%C3%ADrculo-plana-bicolor-colores-azul-y-gris-%C3%A1.jpg?ver=6 width=125 height=125 align="left">$(date)</p>" >> index.html
echo "<br clear="left">" >> index.html
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html

#4.2 Mostrar Autor del script
echo "<p><h3 style=\"color: #229954; font-weight: 900;\">AUTOR</p></h3><p><img src=https://lh3.googleusercontent.com/a-/AOh14GjdMpuvg87pMvj626CD8QkeNEx48NhZjphKZXq8=s288-p-rw-no width=125 height=125 align="left"> Usuario: $USER. Soy Marcos Ricciardi.</p>" >> index.html
echo "<br clear="left">" >> index.html
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html
#4.3 mostrar capacidad utilizada de los discos
echo "<img src=https://us.123rf.com/450wm/blankstock/blankstock1802/blankstock180200779/95992615-icono-de-disco-duro-signo-de-almacenamiento-en-disco-duro-s%C3%ADmbolo-de-memoria-del-disco-duro-elemento.jpg?ver=6 width=150 height=125 align="left"><br><br><h3 style=\"color: #229954; font-weight: 900;\">CAPACIDAD UTILIZADA DE LOS DISCOS</h3> <br clear="left">" >> index.html
echo "<h5>$(df -h | grep -head)</h5>" >> index.html #Muestro la cabecera de la info de los discos en negrita
echo "<p>$(df -h | grep ^/dev)</p>" >> index.html #muestro la info de los discos
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html
#4.4 Mostrar Cantidad de procesadores del servidor
echo "<img src=https://st4.depositphotos.com/34463872/40302/v/600/depositphotos_403022252-stock-illustration-processor-icon-chip-logo-long.jpg width=125 height=125 align="left">" >> index.html
cant_cores_cpu=$(cat /proc/cpuinfo | grep 'cpu cores' | cut -d ":" -f 2 | head -n 1)
echo "<br><br><h3 style=\"color: #229954; font-weight: 900;\">"EL PROCESADOR TIENE $cant_cores_cpu NÚCLEOS!"</h3><br clear="left">" >> index.html
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html
#4.5 Mostrar procesos en ejecucion
echo "<img src=https://us.123rf.com/450wm/imagevectors/imagevectors1603/imagevectors160300839/53026849-piso-icono-negro-web-del-proceso-en-c%C3%ADrculo-sobre-fondo-blanco.jpg?ver=6 width=125 height=125 align="left"><br><br><h3 style=\"color: #229954; font-weight: 900;\">LISTA DE PROCESOS EN EJECUCIÓN</h3><br clear="left"> <h5>$(ps -aux | head -n 1)</h5>" >> index.html
cant_procesos=$(ps -aux | wc -l)
count=2
while [ $count -le $cant_procesos ] ;
do
	echo "<p>$(ps -aux | sed -n "$count"p)</p>" >> index.html
	count=$(( $count + 1 ))
done
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html

#4.6 Mostrar si hay mas usuarios conectados o si estoy solo yo
cant_users_connect_withoutme=$(users | tr " " "\n" | grep [^$USER] | wc -l) #Si estoy conectado de diferentes terminales puede figurar mi usuario varias veces, por eso cuento la cantidad de usuarios que hay, excepto yo y si es 0 es que estoy solo.
count=1
if [ $cant_users_connect_withoutme == 0 ];
then
	echo "<img src=https://www.clipartkey.com/mpngs/m/185-1852837_black-n-white-face-png-icon-em-png.png width=125 height=125 align="left"><br><br><h3 style=\"color: #229954; font-weight: 900;\">Estoy conectado solito :(</h3><br clear="left">" >> index.html
	echo "<p>Solo esta conectado $USER.</p>" >> index.html
else
	echo "<img src=https://www.clipartkey.com/mpngs/m/39-394174_happy-face-vector-png.png width=125 height=125 align="left"><br><br><h3 style=\"color: #229954; font-weight: 900;\">Somos varios conectados!!</h3><br clear="left">" >> index.html
	echo "<h4 style=\"color: #229954; font-weight: 900;\">Los usuarios conectados son: </h4>" >> index.html
	cant_users_connect_tot=$(users | tr " " "\n" | wc -l)
	count=1
	echo "<ul>" >> index.html
	while [ $count -le $cant_users_connect_tot ] ;
	do
		echo "<li>$(users | tr " " "\n" | sed -n "$count"p)</li>" >> index.html
		count=$(( $count + 1 ))
	done
	echo "</ul>" >> index.html
fi
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html

#4.7 Existe el elemento saludo en mi carpeta personal?
if [ -f $dir_inicial/saludo ] ;
then
	echo "<img src=https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4kE4EHIevaHAl2LZafHAXG_CsFiWVBdnTjSIISfSqMaF4yLNMx3DaeGzTPfcIgb4-IBw&usqp=CAU width=125 height=125 align="left"><br><br><h3 style=\"color: #229954; font-weight: 900;\">EL ARCHIVO SALUDO SI EXISTE!</h3><br clear="left">" >> index.html
	#4.8 Muestro el contenido del archivo saludo
	echo "<h4>El contendio de saludo es: $(cat $dir_inicial/saludo)</h4>" >> index.html
	#4.9 Elimino el archivo saludo y muestro que ya no existe mas
	rm $dir_inicial/saludo
	if [ -f $dir_inicial/saludo ] ;
	then
		echo "<h4>Fallo al eliminarse el archivo saludo</h4>" >> index.html
	else
		echo "<h4>El archivo saludo ya NO existe, fue removido!</h4>" >> index.html
	fi
else
	echo "<img src=https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfFkPwgrzamSOsITHavta8D7YgVx365U4ob1NZpVffi-iZswUr4M2VIKlhXSzztOSZuYk&usqp=CAU width=125 height=125 align="left"><br><br><h3 style=\"color: #229954; font-weight: 900;\">EL ARCHIVO SALUDO NO EXISTE!!</h3><br clear="left">" >> index.html
fi
echo -e "<h3 style=\"color: #16bee8; font-weight: 900;\">~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h3>" >> index.html

#Cambio de permisos y ceder propiedades Punto 5 y 6
echo "<img src=https://static.vecteezy.com/system/resources/previews/000/550/535/non_2x/user-icon-vector.jpg width=125 height=125 align="left"><br><br><h3>Usuarios, premisos y propiedades</h3><br clear="left">" >> index.html
echo "<h4>Los permisos actuales del directorio $(pwd) son: $(ls -l /var/www/html/so | grep $USER | cut -d " " -f 1)</h4>" >> index.html
chmod 755 `pwd`
echo "<h4>Los Nuevos permisos del directorio $(pwd) son: $(ls -l /var/www/html/so | grep $USER | cut -d " " -f 1)</h4>" >> index.html
echo "<h3>Cediendo propiedad. $(chown -R www-data:www-data $(pwd))</h3>" >> index.html

echo "</body></html>" >> index.html #Cierro html

#7-Panel para elegir directorio de backup
echo "Seleccione uno de los siguientes directorios para crear un backup del archivo index.html: (Cualquier opcion distinta será el mismo directorio donde se encuentra"
select dir_backup_index in "/var/www/html/so/$USER/" "/home/mz/so2021/$USER/" "/home/mz/so2021/compartido/"
do
	
	if [ -d $dir_backup_index ] ;
	then
		echo "Se creará un backup del archivo index.html en $dir_backup_index"
		cp index.html "$dir_backup_index"index_backup_maricciardi.html
	else
		echo "El directorio no existe, se procederá a crearlo"
		mkdir -p $dir_backup_index
		if [ -d $dir_backup_index ] ;
		then
			echo "Se creará un backup del archivo index.html en $dir_backup_indexv"
               		cp index.html "$dir_backup_index"index_backup_maricciardi.html
		else
			echo "No se pudo crear el directorio, por lo tanto tampoco se hizo el backup"
		fi

	fi	
	break
done

if [ -f $dir_backup_index/index_backup_maricciardi.html ];
then
	echo "El backup se creo exitosamente"
else
	echo "El backup no pudo ser creado"
fi

#9 Enviar copia del script a /home/evaluacion2021/
cp $dir_inicial/parcial1.sh /home/evaluacion2021/marcosricciardi.sh
cd
#FIN


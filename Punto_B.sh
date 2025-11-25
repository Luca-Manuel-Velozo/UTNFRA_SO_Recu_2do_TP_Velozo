cd /usr/local/bin/
cat << FIN >> velozo_clasif_animales.sh
lista_animales=$1
ANT_IFS=$IFS
IFS=$'\n'

mkdir -p /tmp/Animales/{Agua/,/Tierra/{Mamiferos,Oviparos}}
for i in `cat $lista_animales | awk '{print $1" "$2}' | grep -v   ^#`
do
	TXT="/tmp/animales.txt"
	ANIMAL=$(echo $i | awk '{print$1}')
	CLASIF=$(echo $i | awk '{print$2}')
	echo "20241119 - Animal: $ANIMAL - Habitat: $CLASIF" >> "$TXT"
	if [[ $CLASIF = "AG" ]]
	then
		AGUA=/tmp/Animales/Agua/$ANIMAL.txt
		echo "20241119 - Animal: $ANIMAL - Habitat: $CLASIF" >> "$AGUA"
	elif [[ $CLASIF = "TO" ]]
	then
		OVI=/tmp/Animales/Tierra/Oviparos/$ANIMAL.txt
		echo "20241119 - Animal: $ANIMAL - Habitat: $CLASIF" >> "$OVI"
	else
		MAMI=/tmp/Animales/Tierra/Mamiferos/$ANIMAL.txt
		echo "20241119 - Animal: $ANIMAL - Habitat: $CLASIF" >> "$MAMI"
	fi
done

IFS=$ANT_IFS

FIN 
sudo chmod +x velozo_clasif_animales.sh
/usr/local/bin/./velozo_clasif_animales.sh /home/LV/UTN-FRA_SO_Examenes/202411/bash_script/Lista_Animales.txt


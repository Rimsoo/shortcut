#!/bin/bash

createDesktop()
{
	DIR_1=$(readlink -f  "${1}") 
    NAME_1=$(basename "${1}")
    DIR_2=$(readlink -f  "${2}") 
    NAME_2=$(basename "${2}")

	echo -e "#!/bin/bash

name=$3
path=$DIR_1
path2=$DIR_2"> "$HOME/.local/bin/$3"
	echo 'if [[ -z $1 ]]; then
	exec "$path"
elif [[ $1 = "-u" ]]; then
	choice=n
	while [ ! -z "$choice" ]
	do
		read -p "Do you really want to delete Coffee break ? (Y/n) " choice
		if [ "$choice" = n ]; then
			echo "Quit..."
			exit
		elif [ "$choice" = y ]; then
			break
		fi
	done
	echo "Uninstalling in progress..."
	rm -rf "$path"
    rm -rf "$path2"
	rm -f "$HOME/.local/share/applications/$name.desktop"
	rm -f "$HOME/.local/bin/$name"
	echo "Done."
elif [[ $1 = "-h" ]]; then
	echo -e "\nUse -u to uninstall :
	$name -u\n"
fi' >> "$HOME/.local/bin/$3"
	chmod 711 "$HOME/.local/bin/$3"

	echo "Creating a desktop shortcut..."
	echo -e "[Desktop Entry]
Type=Application
Name=$3
GenericName=$3
Icon=$DIR_2
Exec=$DIR_1
Terminal=false  #ouvrir ou non un terminal lors de l'exécution du programme (false ou true)
StartupNotify=true  #notification de démarrage ou non (false ou true)
Categories=Game" > "$HOME/.local/share/applications/$3.desktop"
}

if [ $# -eq 3 ]  
then
    if [ -e $1 ]
    then
        if [ -e $2]
        then
            if [ ${2: -4} == ".jpg" ] || [ ${2: -4} == ".png" ] || [ ${2: -4} == ".ico" ] || [ ${2: -4} == ".svg" ]
            then
                createDesktop "$1" "$2" "$3"
            else
                echo "Second parameter need to be an icon.jpg/png/svg/ico file"
            fi
        else
            echo "$2 not found."
        fi
    else
        echo "$1 not found."
    fi
else
    echo "Usage : shortcut 'executable' 'icon' 'name_of_shortcut'"
fi
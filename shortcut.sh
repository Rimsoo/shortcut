#!/bin/bash

createCommand()
{
	DIR_1=$(readlink -f  "${1}")
    DIR_2=$(readlink -f  "${3}")

	echo "Creating $NAME_1 command..."
	echo -e "#!/bin/bash

name=$2
path=$DIR_1
path2=$DIR_2"> "$HOME/.local/bin/$2"
	echo '
if [[ $1 = "-u" ]]; then
	choice=n
	while [ ! -z "$choice" ]
	do
		read -p "Do you really want to delete $name shortcut ? (Y/n) " choice
		if [ "$choice" = n ]; then
			echo "Quit..."
			exit
		elif [ "$choice" = y ]; then
			break
		fi
	done
	echo "Uninstalling in progress..."
	rm -f "$HOME/.local/share/applications/$name.desktop"
	rm -f "$HOME/.local/bin/$name"
	echo "Done."
elif [[ $1 = "--help" ]]; then
	echo -e "\nUse -u to uninstall the shortcut:
	$name -u\n"
else 
	exec "$path" "$@"
fi' >> "$HOME/.local/bin/$2"
	chmod 711 "$HOME/.local/bin/$2"
}

createDesktop()
{
	DIR_1=$(readlink -f  "${1}")
    DIR_2=$(readlink -f  "${3}")

	echo "Creating a desktop shortcut..."
	echo -e "[Desktop Entry]
Type=Application
Name=$2
GenericName=$2
Icon=$DIR_2
Exec=$DIR_1
Terminal=false  #ouvrir ou non un terminal lors de l'exécution du programme (false ou true)
StartupNotify=true  #notification de démarrage ou non (false ou true)
Categories=Game" > "$HOME/.local/share/applications/$2.desktop"
}

information()
{
	echo -e "
Shortcut version : 0.3

- Create shortcut 

Command and graphic shortcut :  
	shortcut executable name_of_shortcut icon

'executable' : The file to link to the shortcut  
'name_of_shortcut' : The name of the shortcut to create (graphic and command)  
'icon' : The icon of the shortcut (format : .ico, .png, .jpg, .svg)


Only command  
	shortcut executable name_of_shortcut

'executable' : The file to link to the shortcut  
'name_of_shortcut' : The name of the command shortcut to create  

- Delete shortcut
'name_of_shortcut -u'
"
}

if [ ! -d "$HOME/.local/bin" ]
then
	mkdir "$HOME/.local/bin"
	echo -e '# added by : https://github.com/Rimsoo/shortcut
export PATH="/home/'.$HOME.'/.local/bin:$PATH"' >> "$HOME/.bashrc"
	source "$HOME/.bashrc"
fi

if [ $# -eq 1 ] && [ $1 == "-h" ] 
then
	information
elif [ -e $1 ]
then
	if [ $# -eq 3 ]  
	then
        if [ -e $3 ]
        then
            if [ ${3: -4} == ".jpg" ] || [ ${3: -4} == ".png" ] || [ ${3: -4} == ".ico" ] || [ ${3: -4} == ".svg" ] || [ ${3: -4} == ".jpeg" ]
            then
				createCommand "$1" "$2"
				createDesktop "$1" "$2" "$3"
            else
                echo "Third parameter need to be an icon.jpg/png/svg/ico file"
            fi
        else
            echo "$3 not found."
        fi
	elif [ $# -eq 2 ] 
	then
		createCommand "$1" "$2"
	else
		echo -e "Usage : shortcut executable name_of_shortcut [icon]\nUse 'shortcut -h' for more information."
    fi
else
	echo "$1 not found."
fi
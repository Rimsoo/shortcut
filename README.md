# Shortcut
Create a command line and graphic shortcut for linux executables.  
Command shortuct in : `$HOME/.local/bin`  
Desktop shortcut in : `$HOME/.local/share/applications`  

## Install 
Clone the project :  
`git clone https://github.com/Rimsoo/shortcut.git`   
Install only for you :  
`cp shortcut/shortcut.sh $HOME/.local/bin/shortcut`  
For all users :  
`sudo cp shortcut/shortcut.sh /usr/bin/shortcut`  
You can now delete the project :  
`rm -r shortcut/`

## Usage 
### Create shortcut 
Command and graphic shortcut :  
`shortcut executable name_of_shortcut icon`  
`executable` : The file to link to the shortcut  
`name_of_shortcut` : The name of the shortcut to create (graphic and command)  
`icon` : The icon of the shortcut (format : .ico, .png, .jpg, .svg)

Only command  
`shortcut executable name_of_shortcut`  
`executable` : The file to link to the shortcut  
`name_of_shortcut` : The name of the command shortcut to create  

### Delete shortcut
`name_of_shortcut -u`

#!/bin/bash

if [[ $EUID != 0 ]]; then
	echo -e "\033[91mYou need to be r00t!\033[0m";
	exit;
fi;

#edit SERVER-variable to target your localhost-folder.

#server=~/storage/shared/htdocs/www/
server=/opt/lampp/htdocs/www/


sleepFor=0.4;

function usage(){
	echo -e "\n\n";
	echo -e "[\033[91mUsage\033[0m]\t$0 [\033[92mprojectName\033[0m]";
	echo -e "\n\n";
}

function checkServer(){
	if [[ ! -d $server ]]; then
		echo -e "[\033[91mError\033[0m]\tNo server path found.";
		exit;
	else
		echo -e "[\033[92mFound\033[0m]\t\tServer-path exists.";
	fi
}

#check argument.
if [[ $1 != "" ]]; then
	project=$1;
	echo -e "\033[96mProject name: $project\033[0m";
else
	usage;
	exit 1;
fi


checkServer;
cd $server;

if [[ -d $project ]]; then
	echo -e "[\033[91m$project\033[0m]\talready exists.";
	echo -e "Do you want to \033[91Overwrite\033[0m this project? [y/n]";
	read answer
	if [[ ${answer,,} == 'yes' ]] || [[ ${answer,,} == 'y' ]]; then
		echo -e "\033[92mOverwriting existing project..\033[0m";
		rm -rf ${server}${project};
	else
		echo -e "\033[91mAborting\033[0m";
		exit 1;
	fi
fi

clear

#====================
#creating the project
#====================

mkdir $project;
echo -e "[\033[96mCreating $project\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

cd $project;

mkdir css js libs func pages media
echo -e "[\033[96mCreating folders\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

touch css/main.css js/main.js pages/home.php index.php autoloader.php libs/dbconfig.class.php
echo -e "[\033[96mCreating files\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

#creating autoloader
echo -e "<?php \nfunction autoloader(\$class){ \n\tinclude(\"libs/\$class.class.php\"); \n} \n\nspl_autoload_register('autoloader'); \n?>" > autoloader.php;
echo -e "[\033[96mWriting autoloader\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

#creating css
echo -e "*{margin:0;padding:0;}\na{text-decoration:none;}\nbody{\nwidth:100%;\nheight:100%;\nfont-family:arial;\nfont-size:.9em;\n}\n" > css/main.css;
echo -e "[\033[96mWriting main[css]\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

#creating js
echo -e "window.onload = { \n\n\t//Do something....\n\n}" > js/main.js;
echo -e "[\033[96mWriting main[js]\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

#creating home
echo "This is home" > pages/home.php;
echo -e "[\033[96mWriting home.php\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

#creating index
echo -e "<?php\ninclude('autoloader.php');\n//\$db = new Dbconfig;\n?>\n<!DOCTYPE html>\n<head>\n\t<title>$project</title>\n\t<meta lang='en' />\n\t<meta charset='utf-8' />\n\t<meta name='viewport' content='width=device-width, initial-scale=1' />\n\t<link rel='stylesheet' href='css/main.css' media='all' />\n</head>\n<body>\n\n<?php include('pages/home.php'); ?>\n\n<script src='js/main.js'></script>\n</body>\n</html>" > index.php;
echo -e "[\033[96mWriting index.php\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

#creating dbconfig.class.php
echo -e "<?php \n\n//Make sure to edit the information before connecting to database.\n\nclass Dbconfig { \n\n \tpublic function __construct(){\n\t\t\$host='localhost';\n\t\t\$user='root';\n\t\t\$pass='';\n\t\t\$dbname='$project';\n\t\t\$this->conn = New Mysqli(\$host, \$user, \$pass, \$dbname);\n\t}\n\n}\n\n?>" > libs/dbconfig.class.php;
echo -e "[\033[96mWriting Dbconfig\033[0m]\t\033[92mDone\033[0m.";
sleep $sleepFor;

echo -e "\033[96mProject: $project created in ${server}";

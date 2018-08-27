# (1) SERVER INSTALL FINAL (ONCE ALREADY STARTED A VAGRANT INSTANCE OF UBUNTU)

# CONFIGURATION FILES FOR GIRDER:

# stellen sicher dass apt ausfuhren nicht ist
sudo pkill -9 apt

# ADDED DANTE STEP: ENSURE PIP IS INSTALLED
# echo "\nstellen sicher dass pip installiert ist"
# sudo apt-get install software-properties-common
# sudo apt-add-repository universe
# sudo apt-get update
# sudo apt-get install python-pip
# echo "\n"
# END DANTE STEP

echo "installiern sie die benotigten pakete\n"

sudo apt-get install curl g++ git libffi-dev libjpeg-dev libldap2-dev libsasl2-dev libssl-dev make python-dev python-pip zlib1g-dev

echo "\n"

echo "bekommt repo schussel fur mongod\n"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo "\n"

# maybe need this instead: deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    
echo "aktualisieren apt"
sudo apt-get update
echo "\ninstallieren mongodb-org-server"
sudo apt-get install mongodb-org-server
echo "\n"

# sudo rm /lib/systemd/system/mongod.service
# sudo vim /lib/systemd/system/mongod.service

## MAKE SURE THE BELOW IS IN THE ABOVE MENTIONED FILE WE'VE VIMED
# [Unit]
# Description=High-performance, schema-free document-oriented database
# After=network.target
# Documentation=https://docs.mongodb.org/manual

# [Service]
# User=mongodb
# Group=mongodb
# ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

# [Install]
# WantedBy=multi-user.target

sudo echo "[Unit]\n \
Description=High-performance, schema-free document-oriented database\n \
After=network.target\n \
Documentation=https://docs.mongodb.org/manual\n \
\n \
[Service]\n \
User=mongodb\n \
Group=mongodb\n \
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf\n \
\n \
[Install]\n \
WantedBy=multi-user.target" > mongod.service

sudo mv mongod.service /lib/systemd/system/mongod.service


#sudo service mongod start # THIS NEVER WORKS FOR ME BUT TRY IT ANYWAY

# mongod #...I END UP HAVING TO DO THIS AND START A NEW INSTANCE OF TERMINAL
# AT THIS POINT I STARTED A NEW VAGRANT UBUNTU INSTANCE IN ORDER TO CONTINUE UNLESS I CAN RUN MONGOD IN THE BACKGROUND SOMEHOW.

sudo mkdir -p /data/db

echo "tote alte mongod prozesse\n"
sudo pkill -9 mongod
echo "\n"

echo "beginnt mongod\n"
# just kidding forget mongod, run it in the background like so:
sudo mongod --fork --logpath /var/log/mongod.log
echo "\n"

echo "bekommt node/nodejs repo"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
echo "\n"

echo "installieren node/nodejs"
sudo apt-get install nodejs
echo "\n"

echo "aktualisieren npm\n"
sudo npm install -g npm # THIS IS IS USED TO UPDATE NPM (may have to use sudo before the command)
echo "\n"

# ----------- GET GIRDER VIR ENV AND RUN GIRDER ---------------
mkdir -p ~/apps
cd ~/apps
sudo pip install -U virtualenv pip
virtualenv girder_env
. girder_env/bin/activate
git clone --branch 2.x-maintenance https://github.com/girder/girder.git
cd girder
pip install -e . # MAY HAVE TO INCLUDE SUDO BEFORE THIS COMMAND

{
	#try
	girder-install web
} || {
	# catch
	# do nothing
}

# SINCE THE WEB INTERFACE FAILED I BELIEVE WE HAVE TO MANUALLY INSERT THE FOLLOWING IN ORDER TO GET SOME PARTIAL FUNCTIONALITY FROM THE INTAKE
#cd ~/apps/girder/clients/web/static/built
# git clone [GIT REPOSITORY WHERE I'VE STORED THE NEEDED FILES]

# NOW KILL MONGO ( sudo mongod --shutdown )

# vim Vagrantfile

# UNDER   Vagrant.configure("2") do |config|   INPUT:
# config.vm.network "forwarded_port", guest: 8081, host: 8081, auto_correct: true, host_ip: "127.0.0.1"
# NOTE: the host is the local machine and the guest is the VM


# por una razon esos documentos no estaban incluido en la instalacion de girder

sudo cp ../missing_girder_files/* ~/apps/girder/clients/web/static/built/




















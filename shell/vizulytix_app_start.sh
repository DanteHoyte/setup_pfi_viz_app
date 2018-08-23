# STARTING THE APP


echo "tote alte mongod prozesse\n"
sudo pkill -9 mongod
echo "\n"

echo "beginnt mongod\n"
# just kidding forget mongod, run it in the background like so:
sudo mongod --fork --logpath /var/log/mongod.log
echo "\n"


# sudo mkdir -p /var/log/girder

# IN ANOTHER PROCESS RUN GIRDER
echo "tote alte girder prozesse\n"
sudo pkill -9 girder
echo "\n"

echo "dienen girder"
. ~/apps/girder_env/bin/activate
girder serve &

echo "\n"
# cd ~/apps
# girder serve
# . girder_env/bin/activate
# cd girder
# girder serve

# RUN NGINX
echo "tote alte nginx prozesse\n"
sudo pkill -9 nginx
echo "\n"

echo "beginnt nginx\n"
sudo nginx
echo "\n"





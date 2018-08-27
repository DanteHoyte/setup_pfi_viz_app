# (2)
#NOTE FOR NEXT TIME
#asegura que pones la carpeta girder dentro de la carpeta "apps" para que la heirchia de carpetas sea como las de curtis y todo funciona mas fluidamente
# ahora tengo el camino ~/girder/clients/web/static/built$  en mi version local de vagrant pero debe estar ~/apps/girder/clients/web/static/built$ 
#... para estar como la de curtis.


# NGINX INSTALL

echo "installieren setuptools, arrow, pymongo, nginx"

sudo pip install setuptools
sudo pip install arrow
sudo pip install pymongo
sudo apt install nginx

# add server definition into /etc/nginx/sites-available/default
# i.e. TO EDIT CURRENT SERVER DEFINITIONS: sudo vim /etc/nginx/sites-available/default
# [CAN ADD ALL CONFIGURATIONS/STATIC PAGE PATHS/ETC HERE]

# UNDER SERVER:
# CHANGE THE LISTEN PORTS TO 8070
# CHANGE THE ROOT TO: root /home/vagrant/apps/intake-form;
# my root folder was originally: /usr/share/nginx/html;
# ADD THE FOLLOWING

sudo cp ../default /etc/nginx/sites-available/default

# echo "hinzufugen text nach 'server {' in die Datei /etc/nginx/sites-available/default"
# sed -i '/server {/a \
# location /girder/ { \
# 		proxy_set_header Host $proxy_host; \
# 		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; \
# 		proxy_set_header X-Forwarded-Host $host; \
# 		proxy_set_header X-Forwarded-Proto $scheme; \
# 		proxy_pass http://localhost:9000/; \
# 		# Must set the following for SSE notifications to work \
# 		proxy_buffering off; \
# 		proxy_cache off; \
# 		proxy_set_header Connection ''; \
# 		proxy_http_version 1.1; \
# 		chunked_transfer_encoding off; \
# 		proxy_read_timeout 600s; \
# 		proxy_send_timeout 600s; \
# 		# proxy_request_buffering off; # HAD TO COMMENT THIS OUT FOR SOME REASON. IS THIS CORRECT? \
# }' inputfile

# location /girder/ {
# 		proxy_set_header Host $proxy_host;
# 		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
# 		proxy_set_header X-Forwarded-Host $host;
# 		proxy_set_header X-Forwarded-Proto $scheme;
# 		proxy_pass http://localhost:9000/;
# 		# Must set the following for SSE notifications to work
# 		proxy_buffering off;
# 		proxy_cache off;
# 		proxy_set_header Connection '';
# 		proxy_http_version 1.1;
# 		chunked_transfer_encoding off;
# 		proxy_read_timeout 600s;
# 		proxy_send_timeout 600s;
# 		# proxy_request_buffering off; # HAD TO COMMENT THIS OUT FOR SOME REASON. IS THIS CORRECT?
# }

# ---------- setup girder as reverse proxy for nginx -------

sudo cp ../girder.local.cfg /home/vagrant/apps/girder/girder/conf/girder.local.cfg
# vim /home/vagrant/apps/girder/girder/conf/girder.local.cfg 

# add proxy info like it says on the webpage 
# :http://girder.readthedocs.io/en/latest/deploy.html#reverse-proxy


# ---------- load the app -------

# cd ~/apps
echo "kopieren Dateien von repo intake-form\n"
git clone https://github.com/curtislisle/intake-form.git ~/apps
echo "\n"

# [MORE STEPS IN BETWEEN HERE]

# sudo mkdir -p intake-form
cd intake-form
echo "installieren paketen .js"
npm install d3@4.10.0
npm install handlebars@4.0.10
npm install alpaca
npm install moment
npm install bootstrap-datetimepicker
npm install jquery
npm install popper.js
npm install bootstrap
echo "\n"

# TO START/KILL NGINX
# sudo service nginx start #[CALLS TO SERVICE SEEM TO NEVER WORK FOR ME. USED THE BELOW INSTEAD]
# sudo nginx
# in order to kill nginx I did pgrep nginx and kill all the processes with sudo kill -9 [PROCESS ID]


# included this in case it's needed because for some reason girder complained about not having this
sudo cp ~/apps/intake-form/node_modules/bootstrap/dist/css/bootstrap.min.css.map ~/apps/girder/clients/web/static/built/

sudo cp /index.html ~/apps/intake-form/index.html








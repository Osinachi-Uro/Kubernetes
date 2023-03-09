FROM nginx

EXPOSE 80/tcp

#--------------
# Install nginx
#--------------

# RUN apt -y update && apt -y install nginx

#------------------------------------------------------------------
# Clone my website file repo and move files to the container server
#------------------------------------------------------------------

RUN apt-get update -y && apt-get install git -y
RUN git clone https://github.com/Osinachi-Uro/Kubernetes.git /var/www/html/K8task 

#------------------------------------------
#Create the Nginx Configuration File
#------------------------------------------

COPY nginx.conf /etc/nginx/sites-available/
#RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Enable the new configuration file
RUN service nginx restart

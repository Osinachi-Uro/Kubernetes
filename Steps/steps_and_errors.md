## STEPS

1. Designed my simple website using HTML and CSS and pushed the files to my github repository
2. Created a Dockerfile FROM nginx to deploy my website image to DockerHub.
3. Dockerfile content Option 1 that didn't work (plan to fix it)
```
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

```
4. Dockerfile content Option 2 that worked
```
FROM nginx:alpine

COPY . /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

```

5. Run docker build ``` sudo docker build -t nachsdocker/web-page:1.0 . ```
<img width="815" alt="Capture 2" src="https://user-images.githubusercontent.com/83463641/222902895-0f33f3e6-9e9b-4929-a7f1-995c11f7407d.PNG">

6. Docker run

<img width="910" alt="Capture 4" src="https://user-images.githubusercontent.com/83463641/222896827-68df71e5-4cf1-48c7-9bbf-3c7678c14d2d.PNG">


7. From GCP Cloud shell

<img width="950" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/222902513-c5d98597-c17e-42b8-9bfd-eb7d3d07c73f.PNG">



## ERRORS & SOLUTIONS

### Error 1
<img width="951" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/222446654-98fc98aa-e502-4cb1-aedb-3bc7d96d6499.PNG">

#### Solution 1
Open /etc/resolv.conf, ```sudo nano /etc/resolv.conf```  Then replace the IP address in it to Google’s nameserver IP (8.8.8.8), Save and restart Docker ```sudo systemctl restart docker```

### Error 2
<img width="674" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/222442939-2547cc6e-992c-4464-84f1-aade4e4eec30.PNG">

#### Solution 2
Systemd is typically not installed on most docker images by default. So, instead of using systemd, use service. So, replace the systemctl command with 
``` service nginx restart ```


### Helpful Links:

https://www.baeldung.com/linux/nginx-docker-container

https://jgefroh.medium.com/a-guide-to-using-nginx-for-static-websites-d96a9d034940

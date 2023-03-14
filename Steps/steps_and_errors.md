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

6. Docker run and Docker push to Docker hub

<img width="910" alt="Capture 4" src="https://user-images.githubusercontent.com/83463641/222896827-68df71e5-4cf1-48c7-9bbf-3c7678c14d2d.PNG">

Image successfully created in Docker Hub

<img width="637" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/223969827-e0d300ab-6d30-41ba-b93d-f47cd39d8f41.PNG">


7. Go to GCP and create a Kubernetes cluster, remember to select 2 nodes as GCP creates 3 nodes by default. The cluster takes a while to create. 

<img width="942" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/223978952-c3e4abab-48d9-4bbb-adc5-c75cee9125c8.PNG">

8. When it is done connect to it and the page below will show.
 
<img width="950" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/222902513-c5d98597-c17e-42b8-9bfd-eb7d3d07c73f.PNG">

9. From GCP Cloud shell, hit ENTER and the next it connects to the cluster you created
<img width="384" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/223961612-0894dbd1-e5a6-4b3e-908e-543d07280e51.PNG">

10. To confirm the number of nodes created, run ``` kubectl get nodes ```
<img width="573" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/223962577-9aa22f94-9ad4-4f93-980b-0b43fc77cffa.PNG">

11. Create a directory and inside the directory cerate two files **deployment.yml** and **service.yml** with content as shown below 

<img width="551" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/223966528-97275b45-d7a0-438d-8876-9656a2e35ef5.PNG">

<img width="655" alt="Capture 2" src="https://user-images.githubusercontent.com/83463641/223966553-2234d62c-2ee8-4446-895f-ba2c21bda669.PNG">

<img width="563" alt="Capture 3" src="https://user-images.githubusercontent.com/83463641/223966636-0bd6bc70-d5f3-4b54-91d1-c515ba74cdf5.PNG">

12. Instruct Kubernetes to create each of the files by running the following commands: ``` kubectl create -f deployment.yml ``` and ``` kubectl create -f service.yml ```

Then check if the files have been excuted successfully, run ``` kubectl get deployments,svc ```

<img width="554" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/223969076-c59bfc17-3daf-4c35-8144-e7f5e212fa8d.PNG">


13. Copy the External-IP and place it on a browser to see if it deploys the web page from Docker Hub.

<img width="612" alt="Capture 2" src="https://user-images.githubusercontent.com/83463641/223968969-a9989d86-be3f-4833-9b03-ca3d8fee3fab.PNG">

14. Go back to GCP and Delete the Cluster to avoid billing!!!

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

## Notes

* To delete an existing deployment

First get a list of the existing  deployments:
```
kubectl get deploy
```
Then delete the depoyment:
```
kubectl delete deploy <deployement name>

### Helpful Links:

https://www.baeldung.com/linux/nginx-docker-container

https://jgefroh.medium.com/a-guide-to-using-nginx-for-static-websites-d96a9d034940

https://medium.com/@CloudTopG/learn-how-to-containerize-your-website-and-deploy-it-with-kubernetes-in-less-than-5-minutes-dcd52ed6501

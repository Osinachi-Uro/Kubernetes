## STEPS

1. Designed my simple website using HTML and CSS and pushed the files to my github repository
2. Created a Dockerfile FROM nginx to deploy my website image to DockerHub.

3. Dockerfile content 
```

```
5. Run docker build ``` sudo docker build -t nachsdocker/web-page:1.0 . ```

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

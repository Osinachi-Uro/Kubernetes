### Error 1
<img width="951" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/222446654-98fc98aa-e502-4cb1-aedb-3bc7d96d6499.PNG">

#### Solution 1
Open /etc/resolv.conf, ```sudo nano /etc/resolv.conf```  Then replace the IP address in it to Google’s nameserver IP (8.8.8.8), Save and restart Docker ```sudo systemctl restart docker```

### Error 2
<img width="674" alt="Capture 1" src="https://user-images.githubusercontent.com/83463641/222442939-2547cc6e-992c-4464-84f1-aade4e4eec30.PNG">

#### Solution 2
Systemd is typically not installed on most docker images by default. So, instead of using systemd, use service. So, replace the systemctl command with 
``` service nginx restart ```



### Error 3

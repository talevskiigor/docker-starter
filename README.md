# Update 
## Docker
`sudo apt update`

`sudo apt upgrade`

`sudo rm /usr/local/bin/docker-compose`

`sudo apt remove docker-compose`

`sudo apt autoremove`

`sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

`sudo chmod +x /usr/local/bin/docker-compose`

# Setup SSH

# Install

## Clone the docker project

-	 Clone the docker project.

		`git clone git@git.internetbrands.com:webmgr/webmgr-docker.git`



- Copy the configuration file and replace values with your values.  
	`cp .env.example .env`

	> **IMPORTANT:** for MAC users please replace host names.

```
	DB_HOST=dev-postgresql
	MEMCACHED_HOST=dev-memcached    
```   
    

		with specific for Mac:


```
DB_HOST=host.docker.internal
MEMCACHED_HOST=host.docker.internal
```

### HINTS

#### LOCAL_USER_ID
- your local user id

	**Linux**: id can be found with command `id -u` 

	**Windows**: just enter 1000

	**Mac OS**: TODO: test and update this docs for Mac


#### TZ
 - time zone  

 	**Linux**: you can see the time zone with  
		`echo "TZ=$(ls -la /etc/localtime | cut -d/ -f7-9)"`


### start the continers

- build and start the containers
	> RUN `./start.sh` and wait to finish

### Install the editor project ###
- go to local html folder (`./www/html`) and clone the webmgr project  

	`git clone git@git.internetbrands.com:webmgr/webmgr.git`

- attach to  the apache `./shell.sh`
- chdir usign `cd /var/www/html/webmgr`
- run `php installer_updater.php`


	>If you see this error: **pathspec 'develop' did not match any file(s) known to git** then scrllop up and find the last plugin and chdir to develop folder, run `git status` and go back to `/var/www/html/webmgr`. You will get this error on some plugins who has no default develop branch. Repeat the steps and re-run the `php installer_updater.php`

	This plugins are know to fail at the first install:  
	- [FeaturedArticles](https://gitlab.git.internetbrands.com/webmgr-plugins/featuredarticles.git)  
	- [Gallery](https://gitlab.git.internetbrands.com/webmgr-plugins/gallery.git)  
	- [testimonials](https://gitlab.git.internetbrands.com/webmgr-plugins/testimonials.git)



- When all finished ok, stop the docker using `Ctrl + C` or `docker-compose stop`.

- uncomment the line `IncludeOptional /var/.../webmgr*/.../local*/*.conf`  
  in the virtual host config
   `./apache/etc/apache2/conf/docker.virtual_host.conf`   
   remove *#* in begin of the line and *restart* the docker.

### Add domains to your local hosts file
```
### Local development ###
# special hosts
127.0.0.1 api.webmgr.local
127.0.0.1 local-development.webmgr.com
127.0.0.1 local-webmgr-mastersite.com
127.0.0.1 image-resizer.localhost
# brands
127.0.0.1 chirodemosite.local-demandforced3.com
127.0.0.1 chirotemplates.local-demandforced3.com
127.0.0.1 chirotestsite.local-demandforced3.com
127.0.0.1 demosite-local.webmd.com
127.0.0.1 demosite-st-local.webmd.com
127.0.0.1 demosite.local-brimhallwebsite.com
127.0.0.1 demosite.local-chiromatrix.com
127.0.0.1 demosite.local-coachingwebsites.com
127.0.0.1 demosite.local-dentrix.com
127.0.0.1 demosite.local-dentrixascend.com
127.0.0.1 demosite.local-dentrixenterprise.com
127.0.0.1 demosite.local-domaindomain2.com
127.0.0.1 demosite.local-easydental.com
127.0.0.1 demosite.local-imatrix.com
127.0.0.1 demosite.local-lh360.com
127.0.0.1 demosite.local-martindalenolo.com
127.0.0.1 demosite.local-officite.com
127.0.0.1 demosite.local-onlinechiro.com
127.0.0.1 demosite.local-onlinepodiatrysites.com
127.0.0.1 demosite.local-theonlinepractice.com
127.0.0.1 demosite.local-therapysites.com
127.0.0.1 demosite.local-vetmatrix.com
127.0.0.1 imxdemosite.local-demandforced3.com
127.0.0.1 imxtemplates.local-demandforced3.com
127.0.0.1 my-webmgr-local.webmd.com
127.0.0.1 my-webmgr-st-local.webmd.com
127.0.0.1 my.local-brimhallwebsite.com
127.0.0.1 my.local-chiromatrix.com
127.0.0.1 my.local-dentrix.com
127.0.0.1 my.local-dentrixascend.com
127.0.0.1 my.local-dentrixenterprise.com
127.0.0.1 my.local-domaindomain2.com
127.0.0.1 my.local-easydental.com
127.0.0.1 my.local-imatrix.com
127.0.0.1 my.local-lh360.com
127.0.0.1 my.local-martindalenolo.com
127.0.0.1 my.local-officite.com
127.0.0.1 my.local-onlinechiro.com
127.0.0.1 my.local-onlinepodiatrysites.com
127.0.0.1 my.local-theonlinepractice.com
127.0.0.1 my.local-vetmatrix.com
127.0.0.1 mychiro.local-demandforced3.com
127.0.0.1 myimx.local-demandforced3.com
127.0.0.1 mysites.local-coachingwebsites.com
127.0.0.1 mysites.local-therapysites.com
127.0.0.1 myvet.local-demandforced3.com
127.0.0.1 templates-local.webmd.com
127.0.0.1 templates-st-local.webmd.com
127.0.0.1 templates.local-brimhallwebsite.com
127.0.0.1 templates.local-chiromatrix.com
127.0.0.1 templates.local-coachingwebsites.com
127.0.0.1 templates.local-dentrix.com
127.0.0.1 templates.local-dentrixascend.com
127.0.0.1 templates.local-dentrixenterprise.com
127.0.0.1 templates.local-domaindomain2.com
127.0.0.1 templates.local-easydental.com
127.0.0.1 templates.local-imatrix.com
127.0.0.1 templates.local-lh360.com
127.0.0.1 templates.local-martindalenolo.com
127.0.0.1 templates.local-officite.com
127.0.0.1 templates.local-onlinechiro.com
127.0.0.1 templates.local-onlinepodiatrysites.com
127.0.0.1 templates.local-theonlinepractice.com
127.0.0.1 templates.local-therapysites.com
127.0.0.1 templates.local-vetmatrix.com
127.0.0.1 testsite.local-brimhallwebsite.com
127.0.0.1 testsite.local-chiromatrix.com
127.0.0.1 testsite.local-coachingwebsites.com
127.0.0.1 testsite.local-demandforced3.com
127.0.0.1 testsite.local-dentrix.com
127.0.0.1 testsite.local-dentrixascend.com
127.0.0.1 testsite.local-dentrixenterprise.com
127.0.0.1 testsite.local-domaindomain2.com
127.0.0.1 testsite.local-easydental.com
127.0.0.1 testsite.local-imatrix.com
127.0.0.1 testsite.local-lh360.com
127.0.0.1 testsite.local-martindalenolo.com
127.0.0.1 testsite.local-officite.com
127.0.0.1 testsite.local-onlinechiro.com
127.0.0.1 testsite.local-onlinepodiatrysites.com
127.0.0.1 testsite.local-theonlinepractice.com
127.0.0.1 testsite.local-therapysites.com
127.0.0.1 testsite.local-vetmatrix.com
127.0.0.1 testsite.local-webmd.com
127.0.0.1 vetdemosite.local-demandforced3.com
127.0.0.1 vettemplates.local-demandforced3.com
127.0.0.1 vettestsite.local-demandforced3.com

```

```
### dev development ###
# special hosts
10.161.134.148 api.webmgr.dev
10.161.134.148 dev-development.webmgr.com
10.161.134.148 dev-webmgr-mastersite.com
10.161.134.148 image-resizer.localhost
# brands
10.161.134.148 chirodemosite.dev-demandforced3.com
10.161.134.148 chirotemplates.dev-demandforced3.com
10.161.134.148 chirotestsite.dev-demandforced3.com
10.161.134.148 demosite-dev.webmd.com
10.161.134.148 demosite-st-dev.webmd.com
10.161.134.148 demosite.dev-brimhallwebsite.com
10.161.134.148 demosite.dev-chiromatrix.com
10.161.134.148 demosite.dev-coachingwebsites.com
10.161.134.148 demosite.dev-dentrix.com
10.161.134.148 demosite.dev-dentrixascend.com
10.161.134.148 demosite.dev-dentrixenterprise.com
10.161.134.148 demosite.dev-domaindomain2.com
10.161.134.148 demosite.dev-easydental.com
10.161.134.148 demosite.dev-imatrix.com
10.161.134.148 demosite.dev-lh360.com
10.161.134.148 demosite.dev-martindalenolo.com
10.161.134.148 demosite.dev-officite.com
10.161.134.148 demosite.dev-onlinechiro.com
10.161.134.148 demosite.dev-onlinepodiatrysites.com
10.161.134.148 demosite.dev-theonlinepractice.com
10.161.134.148 demosite.dev-therapysites.com
10.161.134.148 demosite.dev-vetmatrix.com
10.161.134.148 imxdemosite.dev-demandforced3.com
10.161.134.148 imxtemplates.dev-demandforced3.com
10.161.134.148 my-webmgr-dev.webmd.com
10.161.134.148 my-webmgr-st-dev.webmd.com
10.161.134.148 my.dev-brimhallwebsite.com
10.161.134.148 my.dev-chiromatrix.com
10.161.134.148 my.dev-dentrix.com
10.161.134.148 my.dev-dentrixascend.com
10.161.134.148 my.dev-dentrixenterprise.com
10.161.134.148 my.dev-domaindomain2.com
10.161.134.148 my.dev-easydental.com
10.161.134.148 my.dev-imatrix.com
10.161.134.148 my.dev-lh360.com
10.161.134.148 my.dev-martindalenolo.com
10.161.134.148 my.dev-officite.com
10.161.134.148 my.dev-onlinechiro.com
10.161.134.148 my.dev-onlinepodiatrysites.com
10.161.134.148 my.dev-theonlinepractice.com
10.161.134.148 my.dev-vetmatrix.com
10.161.134.148 mychiro.dev-demandforced3.com
10.161.134.148 myimx.dev-demandforced3.com
10.161.134.148 mysites.dev-coachingwebsites.com
10.161.134.148 mysites.dev-therapysites.com
10.161.134.148 myvet.dev-demandforced3.com
10.161.134.148 templates-dev.webmd.com
10.161.134.148 templates-st-dev.webmd.com
10.161.134.148 templates.dev-brimhallwebsite.com
10.161.134.148 templates.dev-chiromatrix.com
10.161.134.148 templates.dev-coachingwebsites.com
10.161.134.148 templates.dev-dentrix.com
10.161.134.148 templates.dev-dentrixascend.com
10.161.134.148 templates.dev-dentrixenterprise.com
10.161.134.148 templates.dev-domaindomain2.com
10.161.134.148 templates.dev-easydental.com
10.161.134.148 templates.dev-imatrix.com
10.161.134.148 templates.dev-lh360.com
10.161.134.148 templates.dev-martindalenolo.com
10.161.134.148 templates.dev-officite.com
10.161.134.148 templates.dev-onlinechiro.com
10.161.134.148 templates.dev-onlinepodiatrysites.com
10.161.134.148 templates.dev-theonlinepractice.com
10.161.134.148 templates.dev-therapysites.com
10.161.134.148 templates.dev-vetmatrix.com
10.161.134.148 testsite.dev-brimhallwebsite.com
10.161.134.148 testsite.dev-chiromatrix.com
10.161.134.148 testsite.dev-coachingwebsites.com
10.161.134.148 testsite.dev-demandforced3.com
10.161.134.148 testsite.dev-dentrix.com
10.161.134.148 testsite.dev-dentrixascend.com
10.161.134.148 testsite.dev-dentrixenterprise.com
10.161.134.148 testsite.dev-domaindomain2.com
10.161.134.148 testsite.dev-easydental.com
10.161.134.148 testsite.dev-imatrix.com
10.161.134.148 testsite.dev-lh360.com
10.161.134.148 testsite.dev-martindalenolo.com
10.161.134.148 testsite.dev-officite.com
10.161.134.148 testsite.dev-onlinechiro.com
10.161.134.148 testsite.dev-onlinepodiatrysites.com
10.161.134.148 testsite.dev-theonlinepractice.com
10.161.134.148 testsite.dev-therapysites.com
10.161.134.148 testsite.dev-vetmatrix.com
10.161.134.148 testsite.dev-webmd.com
10.161.134.148 vetdemosite.dev-demandforced3.com
10.161.134.148 vettemplates.dev-demandforced3.com
10.161.134.148 vettestsite.dev-demandforced3.com
```

```
### xdev xdevelopment ###
# special hosts
10.161.134.148 api.webmgr.xdev
10.161.134.148 xdev-xdevelopment.webmgr.com
10.161.134.148 xdev-webmgr-mastersite.com
10.161.134.148 image-resizer.localhost
# brands
10.161.134.148 chirodemosite.xdev-demandforced3.com
10.161.134.148 chirotemplates.xdev-demandforced3.com
10.161.134.148 chirotestsite.xdev-demandforced3.com
10.161.134.148 demosite-xdev.webmd.com
10.161.134.148 demosite-st-xdev.webmd.com
10.161.134.148 demosite.xdev-brimhallwebsite.com
10.161.134.148 demosite.xdev-chiromatrix.com
10.161.134.148 demosite.xdev-coachingwebsites.com
10.161.134.148 demosite.xdev-dentrix.com
10.161.134.148 demosite.xdev-dentrixascend.com
10.161.134.148 demosite.xdev-dentrixenterprise.com
10.161.134.148 demosite.xdev-domaindomain2.com
10.161.134.148 demosite.xdev-easydental.com
10.161.134.148 demosite.xdev-imatrix.com
10.161.134.148 demosite.xdev-lh360.com
10.161.134.148 demosite.xdev-martindalenolo.com
10.161.134.148 demosite.xdev-officite.com
10.161.134.148 demosite.xdev-onlinechiro.com
10.161.134.148 demosite.xdev-onlinepodiatrysites.com
10.161.134.148 demosite.xdev-theonlinepractice.com
10.161.134.148 demosite.xdev-therapysites.com
10.161.134.148 demosite.xdev-vetmatrix.com
10.161.134.148 imxdemosite.xdev-demandforced3.com
10.161.134.148 imxtemplates.xdev-demandforced3.com
10.161.134.148 my-webmgr-xdev.webmd.com
10.161.134.148 my-webmgr-st-xdev.webmd.com
10.161.134.148 my.xdev-brimhallwebsite.com
10.161.134.148 my.xdev-chiromatrix.com
10.161.134.148 my.xdev-dentrix.com
10.161.134.148 my.xdev-dentrixascend.com
10.161.134.148 my.xdev-dentrixenterprise.com
10.161.134.148 my.xdev-domaindomain2.com
10.161.134.148 my.xdev-easydental.com
10.161.134.148 my.xdev-imatrix.com
10.161.134.148 my.xdev-lh360.com
10.161.134.148 my.xdev-martindalenolo.com
10.161.134.148 my.xdev-officite.com
10.161.134.148 my.xdev-onlinechiro.com
10.161.134.148 my.xdev-onlinepodiatrysites.com
10.161.134.148 my.xdev-theonlinepractice.com
10.161.134.148 my.xdev-vetmatrix.com
10.161.134.148 mychiro.xdev-demandforced3.com
10.161.134.148 myimx.xdev-demandforced3.com
10.161.134.148 mysites.xdev-coachingwebsites.com
10.161.134.148 mysites.xdev-therapysites.com
10.161.134.148 myvet.xdev-demandforced3.com
10.161.134.148 templates-xdev.webmd.com
10.161.134.148 templates-st-xdev.webmd.com
10.161.134.148 templates.xdev-brimhallwebsite.com
10.161.134.148 templates.xdev-chiromatrix.com
10.161.134.148 templates.xdev-coachingwebsites.com
10.161.134.148 templates.xdev-dentrix.com
10.161.134.148 templates.xdev-dentrixascend.com
10.161.134.148 templates.xdev-dentrixenterprise.com
10.161.134.148 templates.xdev-domaindomain2.com
10.161.134.148 templates.xdev-easydental.com
10.161.134.148 templates.xdev-imatrix.com
10.161.134.148 templates.xdev-lh360.com
10.161.134.148 templates.xdev-martindalenolo.com
10.161.134.148 templates.xdev-officite.com
10.161.134.148 templates.xdev-onlinechiro.com
10.161.134.148 templates.xdev-onlinepodiatrysites.com
10.161.134.148 templates.xdev-theonlinepractice.com
10.161.134.148 templates.xdev-therapysites.com
10.161.134.148 templates.xdev-vetmatrix.com
10.161.134.148 testsite.xdev-brimhallwebsite.com
10.161.134.148 testsite.xdev-chiromatrix.com
10.161.134.148 testsite.xdev-coachingwebsites.com
10.161.134.148 testsite.xdev-demandforced3.com
10.161.134.148 testsite.xdev-dentrix.com
10.161.134.148 testsite.xdev-dentrixascend.com
10.161.134.148 testsite.xdev-dentrixenterprise.com
10.161.134.148 testsite.xdev-domaindomain2.com
10.161.134.148 testsite.xdev-easydental.com
10.161.134.148 testsite.xdev-imatrix.com
10.161.134.148 testsite.xdev-lh360.com
10.161.134.148 testsite.xdev-martindalenolo.com
10.161.134.148 testsite.xdev-officite.com
10.161.134.148 testsite.xdev-onlinechiro.com
10.161.134.148 testsite.xdev-onlinepodiatrysites.com
10.161.134.148 testsite.xdev-theonlinepractice.com
10.161.134.148 testsite.xdev-therapysites.com
10.161.134.148 testsite.xdev-vetmatrix.com
10.161.134.148 testsite.xdev-webmd.com
10.161.134.148 vetdemosite.xdev-demandforced3.com
10.161.134.148 vettemplates.xdev-demandforced3.com
10.161.134.148 vettestsite.xdev-demandforced3.com
```

```
### stg stgelopment ###
# special hosts
10.161.149.96 api.webmgr.stg
10.161.149.96 stg-stgelopment.webmgr.com
10.161.149.96 stg-webmgr-mastersite.com
10.161.149.96 image-resizer.localhost
# brands
10.161.149.96 chirodemosite.stg-demandforced3.com
10.161.149.96 chirotemplates.stg-demandforced3.com
10.161.149.96 chirotestsite.stg-demandforced3.com
10.161.149.96 demosite-stg.webmd.com
10.161.149.96 demosite-st-stg.webmd.com
10.161.149.96 demosite.stg-brimhallwebsite.com
10.161.149.96 demosite.stg-chiromatrix.com
10.161.149.96 demosite.stg-coachingwebsites.com
10.161.149.96 demosite.stg-dentrix.com
10.161.149.96 demosite.stg-dentrixascend.com
10.161.149.96 demosite.stg-dentrixenterprise.com
10.161.149.96 demosite.stg-domaindomain2.com
10.161.149.96 demosite.stg-easydental.com
10.161.149.96 demosite.stg-imatrix.com
10.161.149.96 demosite.stg-lh360.com
10.161.149.96 demosite.stg-martindalenolo.com
10.161.149.96 demosite.stg-officite.com
10.161.149.96 demosite.stg-onlinechiro.com
10.161.149.96 demosite.stg-onlinepodiatrysites.com
10.161.149.96 demosite.stg-theonlinepractice.com
10.161.149.96 demosite.stg-therapysites.com
10.161.149.96 demosite.stg-vetmatrix.com
10.161.149.96 imxdemosite.stg-demandforced3.com
10.161.149.96 imxtemplates.stg-demandforced3.com
10.161.149.96 my-webmgr-stg.webmd.com
10.161.149.96 my-webmgr-st-stg.webmd.com
10.161.149.96 my.stg-brimhallwebsite.com
10.161.149.96 my.stg-chiromatrix.com
10.161.149.96 my.stg-dentrix.com
10.161.149.96 my.stg-dentrixascend.com
10.161.149.96 my.stg-dentrixenterprise.com
10.161.149.96 my.stg-domaindomain2.com
10.161.149.96 my.stg-easydental.com
10.161.149.96 my.stg-imatrix.com
10.161.149.96 my.stg-lh360.com
10.161.149.96 my.stg-martindalenolo.com
10.161.149.96 my.stg-officite.com
10.161.149.96 my.stg-onlinechiro.com
10.161.149.96 my.stg-onlinepodiatrysites.com
10.161.149.96 my.stg-theonlinepractice.com
10.161.149.96 my.stg-vetmatrix.com
10.161.149.96 mychiro.stg-demandforced3.com
10.161.149.96 myimx.stg-demandforced3.com
10.161.149.96 mysites.stg-coachingwebsites.com
10.161.149.96 mysites.stg-therapysites.com
10.161.149.96 myvet.stg-demandforced3.com
10.161.149.96 templates-stg.webmd.com
10.161.149.96 templates-st-stg.webmd.com
10.161.149.96 templates.stg-brimhallwebsite.com
10.161.149.96 templates.stg-chiromatrix.com
10.161.149.96 templates.stg-coachingwebsites.com
10.161.149.96 templates.stg-dentrix.com
10.161.149.96 templates.stg-dentrixascend.com
10.161.149.96 templates.stg-dentrixenterprise.com
10.161.149.96 templates.stg-domaindomain2.com
10.161.149.96 templates.stg-easydental.com
10.161.149.96 templates.stg-imatrix.com
10.161.149.96 templates.stg-lh360.com
10.161.149.96 templates.stg-martindalenolo.com
10.161.149.96 templates.stg-officite.com
10.161.149.96 templates.stg-onlinechiro.com
10.161.149.96 templates.stg-onlinepodiatrysites.com
10.161.149.96 templates.stg-theonlinepractice.com
10.161.149.96 templates.stg-therapysites.com
10.161.149.96 templates.stg-vetmatrix.com
10.161.149.96 testsite.stg-brimhallwebsite.com
10.161.149.96 testsite.stg-chiromatrix.com
10.161.149.96 testsite.stg-coachingwebsites.com
10.161.149.96 testsite.stg-demandforced3.com
10.161.149.96 testsite.stg-dentrix.com
10.161.149.96 testsite.stg-dentrixascend.com
10.161.149.96 testsite.stg-dentrixenterprise.com
10.161.149.96 testsite.stg-domaindomain2.com
10.161.149.96 testsite.stg-easydental.com
10.161.149.96 testsite.stg-imatrix.com
10.161.149.96 testsite.stg-lh360.com
10.161.149.96 testsite.stg-martindalenolo.com
10.161.149.96 testsite.stg-officite.com
10.161.149.96 testsite.stg-onlinechiro.com
10.161.149.96 testsite.stg-onlinepodiatrysites.com
10.161.149.96 testsite.stg-theonlinepractice.com
10.161.149.96 testsite.stg-therapysites.com
10.161.149.96 testsite.stg-vetmatrix.com
10.161.149.96 testsite.stg-webmd.com
10.161.149.96 vetdemosite.stg-demandforced3.com
10.161.149.96 vettemplates.stg-demandforced3.com
10.161.149.96 vettestsite.stg-demandforced3.com
```

```
10.16.82.64 wiki.internetbrands.com
10.161.134.148 dev-smb-web1.internetbrands.com
10.161.134.196 stg-smb-jenkins1.internetbrands.com
10.161.134.148 dev-webmgr-mastersite.internetbrands.com
10.161.149.96 stg-webmgr-mastersite.internetbrands.com
10.161.134.196 smb.internetbrands.com
10.16.82.40 gitlab.git.internetbrands.com
10.161.134.173 stg-leads.internetbrands.com
10.161.134.196 ci.slogin.smb.internetbrands.com
10.161.134.186 apps.qa-officite.com
10.161.134.195 stg-smb-dns.internetbrands.com
10.161.134.196 ci.apps.smb.internetbrands.com

```

## Image resizer (optional)

- go to local html folder (`./www/html`) and clone the Image resizer project  

	`git clone git@git.internetbrands.com:smb/image-resizer.git`

- edit Webmgr .env file like:
```
IMAGE_RESIZER_ENABLED=true
IMAGE_RESIZER_HOSTS=http://image-resizer.localhost:8008
```

	note: please see docker-compose.yml(docker-compose-override.yml) if you need to change images path.




**Happy coding!**

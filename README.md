<h1>Contao CMS in Docker</h1>
This Docker image is to run Contao CMS in Docker.

<h2>How to use it</h2>
If you use the docker-compose file (you can find it 
<a href="https://github.com/INoTime/contao-docker-local-development" target="_blank">here</a>), 
all needed services for Contao will start automatically (you also have to download the ".env" file ).

If you want to start only the Contao image you can pull it from Docker 
Hub via "docker pull inotime/contao" or directly run it with 
"docker run inotime/contao"<br/>
If you want to build the image on your own, you can use the command 
"docker build ." in the directory of the Dockerfile.

<h3>All services were finally started</h3>
When all services were finally started you can access the several services<br/>
- the Contao CMS web server is running on https://localhost:443 or 
http://localhost:80<br/>
- phpMyAdmin is running on http://localhost:8081<br/>
- the database and the Contao web server are in the same internal network<br/>
- the database IP address is 192.168.0.2<br/>

<h3>After install</h3>
After successfully installed Contao you can access the Contao Backend via 
https://localhost:443/app.php/contao or http://localhost:80/app.php/contao

<h3>Access the Contao root directory</h3>
On Windows machines, you can access the Contao root directory from

    \\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\{dir}_docroot\_data
please change "{dir}" to your directory where the docker-compose file is placed.

<h2>Credentials</h2>

    mysql database:
        IP (internal network): 192.168.0.2
        username: admin/root
        password: admin1234
        database name: contao

GitHub: <a href="https://github.com/INoTime" target="_blank">INoTime</a> <br/>
Repository (GitHub): 
<a href="https://github.com/INoTime/contao-docker-local-development" target="_blank">Contao Docker local development</a>

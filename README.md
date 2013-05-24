
# Hosting of Golum in Phusion Passenger.

Copy and Fix `config.ru`

```console
$ cp config.ru.example config.ru
$ vi config.ru
```

*config.ru*

```
gollum_path = '/path/to/your-repo'
```

Bundler

```console
$ bundle install --path=vendor/bondle
```

Fix Apache Conf File

```
$ sudo vi /etc/httpd/conf.d/golum.conf
<VirtualHost *:80>
	ServerName		gollum.example.net:80
	ServerAlias		gollum.*

	ErrorLog		logs/gollum-error_log
	CustomLog		logs/gollum-access_log combined

	DocumentRoot		/path/to/gollum-server/gollum/lib/gollum/public/gollum
	PassengerAppRoot	/path/to/gollum-server

	<Directory /path/to/gollum-server/gollum/lib/gollum/public/gollum>
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>
```

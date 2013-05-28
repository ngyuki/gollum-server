# Hosting of Golum in Phusion Passenger

Clone `ngyuki/gollum-server`

```console
$ git clone https://github.com/ngyuki/gollum-server.git --recursive
$ cd gollum-server
```

Copy and Fix `config.ru`

```console
$ cp config.ru.example config.ru
$ vi config.ru
```

Fix `gollum_path` in `config.ru`

```ruby
gollum_path = '/path/to/your-repo'
```

Bundler

```console
$ bundle install --path=vendor/bondle
```

Fix Apache conf file

```console
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

Restart Apache

```console
$ sudo service httpd restart
```

# Changes from upstream

- Fixed: Error in edit view, when include non-ASCII characters in the header or footer.
- Fixed: TOC is Garbage characters, when include non-ASCII characters.
- Fixed: Layout of sidebar is broken in preview.

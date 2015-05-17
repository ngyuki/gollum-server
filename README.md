# Hosting of Golum on CentOS 6

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

Create upstart config

```console
$ cat <<EOS> /etc/init/gollum.conf
start on runlevel [2345]
stop on runlevel [!2345]
respawn
env PATH=$(rbenv prefix)/bin:/usr/local/bin:/bin:/usr/bin
chdir $PWD
exec su git -c "bundle exec thin -p 3000 -e production start"
EOS
```

Start gollum with upstart

```console
$ sudo initctl reload-configuration
$ sudo initctl start gollum
$ sudo initctl status gollum
```

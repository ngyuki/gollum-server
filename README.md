# Golum Server

## Use Docker

Pull `ngyuki/gollum-server`

```console
$ docker pull ngyuki/gollum-server
```

Create wiki repository

```console
$ git init --bare /srv/wiki.git
```

Run docker container

```console
$ docker run \
    --detach \
    --name gollum \
    --publish 3000:3000 \
    --volume /srv/wiki.git:/wiki.git \
    --env GOLLUM_CONFIG='
        require "gollum/app"
        gollum_path = "/wiki.git"
        Precious::App.set(:gollum_path, gollum_path)
        Precious::App.set(:default_markup, :markdown)
        Precious::App.set(:wiki_options, {
          :css           => true,
          :js            => true,
          :live_preview  => false,
          :mathjax       => false,
          :user_icons    => :gravatar,
          :show_all      => false,
          :collapse_tree => false,
          :h1_title      => true,
          :universal_toc => true,
          :allow_editing => true,
        })
        Precious::App.enable :session
        run Precious::App
    ' \
    ngyuki/gollum-server
```

## Hosting of Golum on CentOS 6

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

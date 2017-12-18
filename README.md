# HelloWorld: A Elixir Demo application

This is a very simple demo [Elixir](http://elixir-lang.github.io/) application written purely to do the fallowing things:

- Play around with Cowboy (Erlang HTTP server).
- Create a release using [Distillery](https://github.com/bitwalker/distillery) (maybe in combination with Docker).

More expirements may fallow (the above list will be updated).

# Docker

Building the docker container and run it:
```
docker build --rm -t hello_world .
docker run --rm -d -p 8080:8080 -t hello_world
```

# Creating certs (only needed if you dont use Docker)

Requirement for creating self-signed certificate is `openssl`. Find out if you have `openssl` installed by running the fallowing:
```
$ which openssl
/usr/bin/openssl
```
It returns `openssl not found` if you don't have `openssl` installed.

Creating the key and the crt files in `./cert`:
```
$ mkdir cert && cd cert
$ openssl req -newkey rsa:2048 -nodes -keyout hello_world.key -x509 -days 365 -out hello_world.crt -subj "/C=NL/ST= /L= /O= /CN= "
```

# TODO

- [x] Use a self-signed SSL sertificate so I can serve using HTTPS.
- [x] Use Docker.
- [x] Remove Server Response Header using a Cowboy Stream.
- [x] Redirect http to https.
- [ ] Create a docker-compose file.
- [ ] ~~Use [Conform](https://github.com/bitwalker/conform) for setting run-time configuration.~~ (Experimented with it, but at this time not needed.)

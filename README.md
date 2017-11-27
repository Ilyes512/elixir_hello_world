# HelloWorld: A Elixir Demo application

This is a very simple demo [Elixir](http://elixir-lang.github.io/) application written purely to do the fallowing things:

- Play around with Cowboy (Erlang HTTP server).
- Create a release using [Distillery](https://github.com/bitwalker/distillery) (maybe in combination with Docker).

More expirements may fallow (the above list will be updated).

# Docker

*Building the docker container and run it*

```
docker build --rm -t hello_world .
docker run --rm -p 8080:8080 -t hello_world
```

# TODO

- [ ] Use a self-signed SSL sertificate so I can serve using HTTPS.
- [ ] Use Docker.
- [ ] Use [Conform](https://github.com/bitwalker/conform) for setting run-time configuration.

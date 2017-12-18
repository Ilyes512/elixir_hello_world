defmodule HelloWorld.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Supervisor.child_spec({Task, fn -> HelloWorld.Cowboy.start_tls() end}, restart: :transient, id: :cowboy_tls),
      Supervisor.child_spec({Task, fn -> HelloWorld.Cowboy.start_redirect() end}, restart: :transient, id: :cowboy_clear)
    ]

    opts = [strategy: :one_for_one, name: HelloWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
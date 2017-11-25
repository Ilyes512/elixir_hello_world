defmodule HelloWorld.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    routes = [{:_, [
      {"/hello/:name[/:...]", HelloWorld.Cowboy.Handler.Hello, []},
      {"/hello", HelloWorld.Cowboy.Handler.HelloWorld, []},
      {:_, HelloWorld.Cowboy.Handler.Goodbye, []}
    ]}]

    dispatch = :cowboy_router.compile(routes)
    port = Application.get_env(:hello_world, :port, 8080)

    :cowboy.start_clear(:hello, [port: port], %{:env => %{:dispatch => dispatch}})
  end
end

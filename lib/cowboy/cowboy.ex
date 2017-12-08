defmodule HelloWorld.Cowboy do
  def start(_type, _args) do
    routes = [
      {:_, [
        {"/hello/:name[/:...]", HelloWorld.Cowboy.Handler.Hello, []},
        {"/hello", HelloWorld.Cowboy.Handler.HelloWorld, []},
        {:_, HelloWorld.Cowboy.Handler.Goodbye, []}
      ]}
    ]

    dispatch = :cowboy_router.compile(routes)
    port = Application.get_env(:hello_world, :port, 8080)

    case Application.get_env(:hello_world, :tls) do
      true ->
        :cowboy.start_tls(
          :hello,
          [
            port: port,
            certfile: Application.get_env(:hello_world, :certfile),
            keyfile: Application.get_env(:hello_world, :keyfile)
          ],
          %{:env => %{:dispatch => dispatch}}
        )
      _ ->
        :cowboy.start_clear(:hello, [port: port], %{:env => %{:dispatch => dispatch}})
    end
  end
end

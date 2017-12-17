defmodule HelloWorld.Cowboy do
  def start() do
    routes = [
      {:_, [
        {"/hello/:name[/:...]", HelloWorld.Cowboy.Handler.Hello, []},
        {"/hello", HelloWorld.Cowboy.Handler.HelloWorld, []},
        {:_, HelloWorld.Cowboy.Handler.Goodbye, []}
      ]}
    ]

    dispatch = :cowboy_router.compile(routes)
    port = Application.get_env(:hello_world, :port, 8080)

    proto_opts = %{
      :env => %{dispatch: dispatch},
      :stream_handlers => [
        :cowboy_stream_h,
        Cowboy.StreamHandlers.RemoveServerSig
      ]
    }

    case Application.get_env(:hello_world, :tls) do
      true ->
        :cowboy.start_tls(
          :hello,
          [
            port: port,
            certfile: Application.get_env(:hello_world, :certfile),
            keyfile: Application.get_env(:hello_world, :keyfile)
          ],
          proto_opts
        )

      _ ->
        :cowboy.start_clear(:hello, [port: port], proto_opts)
    end
  end
end
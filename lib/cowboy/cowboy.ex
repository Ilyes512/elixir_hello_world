defmodule HelloWorld.Cowboy do
  def start() do
    case Application.get_env(:hello_world, :tls) do
      true ->
        start_tls()

      _ ->
        start_clear()
    end
  end

  def start_clear() do
    port = Application.get_env(:hello_world, :port_clear)
    proto_opts = app_dispatch() |> proto_opts()

    :cowboy.start_clear(:hello_clear, [port: port], proto_opts)
  end

  def start_tls() do
    port = Application.get_env(:hello_world, :port_tls)
    proto_opts = app_dispatch() |> proto_opts()

    :cowboy.start_tls(
      :hello_tls,
      [
        port: port,
        certfile: Application.get_env(:hello_world, :certfile),
        keyfile: Application.get_env(:hello_world, :keyfile)
      ],
      proto_opts
    )
  end

  def start_redirect() do
    port = Application.get_env(:hello_world, :port_clear)
    proto_opts = redirect_dispatch() |> proto_opts()

    :cowboy.start_clear(:hello_redirect, [port: port], proto_opts)
  end

  defp app_dispatch() do
    [
      {:_, [
        {"/hello/:name[/:...]", HelloWorld.Cowboy.Handlers.Hello, []},
        {"/hello", HelloWorld.Cowboy.Handlers.HelloWorld, []},
        {:_, HelloWorld.Cowboy.Handlers.Goodbye, []}
      ]}
    ]
    |> :cowboy_router.compile()
  end

  defp redirect_dispatch() do
    port_tls = Application.get_env(:hello_world, :port_tls)

    [{:_, [{:_, HelloWorld.Cowboy.Handlers.Redirect, port_tls}]}]
    |> :cowboy_router.compile()
  end

  defp proto_opts(dispatch) do
    %{
      :env => %{dispatch: dispatch},
      :stream_handlers => [
        :cowboy_stream_h,
        Cowboy.StreamHandlers.RemoveServerSig
      ]
    }
  end
end
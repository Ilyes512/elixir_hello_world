defmodule HelloWorld.Cowboy.Handlers.HelloWorld do
  def init(req, state) do
    req =
      :cowboy_req.reply(
        200,
        %{"content-type" => "text/plain"},
        "Hello World!",
        req
      )

    {:ok, req, state}
  end
end
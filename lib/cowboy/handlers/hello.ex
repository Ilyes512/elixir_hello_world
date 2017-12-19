defmodule HelloWorld.Cowboy.Handlers.Hello do
  def init(req, state) do
    req =
      :cowboy_req.reply(
        200,
        %{"content-type" => "text/plain"},
        "Hello #{String.capitalize(req.bindings.name)}!",
        req
      )

    {:ok, req, state}
  end
end
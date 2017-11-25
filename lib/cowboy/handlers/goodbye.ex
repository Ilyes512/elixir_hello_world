defmodule HelloWorld.Cowboy.Handler.Goodbye do
  def init(req, state) do
    req =
      :cowboy_req.reply(
        200,
        %{"content-type" => "text/plain"},
        "Nope, nothing here! Goodbye!",
        req
      )

    {:ok, req, state}
  end
end
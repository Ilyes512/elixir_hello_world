defmodule HelloWorld.Cowboy.Handler.Redirect do
  def init(req, redirect_port) do
    uri = :cowboy_req.uri(req, %{:port => redirect_port, :scheme => "https"})
    req = :cowboy_req.reply(301, %{"location" => uri}, req)

    {:ok, req, redirect_port}
  end
end
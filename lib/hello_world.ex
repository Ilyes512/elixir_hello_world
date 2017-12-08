defmodule HelloWorld do
  def start_cowboy(type \\ :normal, args \\ []), do: HelloWorld.Cowboy.start(type, args)
end

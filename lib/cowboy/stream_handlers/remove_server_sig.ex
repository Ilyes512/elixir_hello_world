defmodule Cowboy.StreamHandlers.RemoveServerSig do
  @behaviour :cowboy_stream

  def init(stream_id, req, opts) do
    :cowboy_stream.init(stream_id, req, opts)
  end

  def data(stream_id, is_fin, data, state) do
    :cowboy_stream.data(stream_id, is_fin, data, state)
  end

  def info(stream_id, {:response, _, headers, _} = info, state) do
    headers = Map.delete(headers, "server")
    info = put_elem(info, 2, headers)

    :cowboy_stream.info(stream_id, info, state)
  end

  def info(stream_id, info, state) do
    :cowboy_stream.info(stream_id, info, state)
  end

  def terminate(stream_id, reason, state) do
    :cowboy_stream.terminate(stream_id, reason, state)
  end

  def early_error(stream_id, feason, partial_req, resp, opt) do
    :cowboy_stream.early_error(stream_id, feason, partial_req, resp, opt)
  end
end
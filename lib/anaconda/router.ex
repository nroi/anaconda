defmodule Anaconda.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  get "/" do
    hostname = :proplists.get_value("shorten-url", conn.req_headers)
    Logger.debug "Shorten URL: #{inspect hostname}"
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello, world!")
  end

  match _ do
    send_resp(conn, 404, "Invalid URL")
  end
end


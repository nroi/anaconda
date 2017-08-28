defmodule Anaconda.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  get "/" do
    url_to_shorten = :proplists.get_value("shorten-url", conn.req_headers)
    Logger.debug "Shorten URL: #{inspect url_to_shorten}"
    prefix = Application.fetch_env!(:anaconda, :url_prefix)
    suffix = Anaconda.random_string()
    url = "#{prefix}/#{suffix}\n"
    :ets.insert(:urls, {suffix, url_to_shorten})
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, url)
  end

  match _ do
    # TODO isn't there a better way to just get the last and only component of the url?
    case conn.path_info do
      encoded ->
        suffix = URI.decode(to_string(encoded))
        Logger.debug "suffix: #{inspect suffix}"
        case :ets.lookup(:urls, suffix) do
            [] ->
              send_resp(conn, 404, "Invalid path.\n")
            [{^suffix, suffix}] ->
              # TODO redirect
              Logger.debug "suffix: #{inspect suffix}"
              conn
              |> put_resp_content_type("text/html")
              |> send_resp(200, suffix)
        end
      _ -> send_resp(conn, 404, "Invalid path.")
    end
  end
end


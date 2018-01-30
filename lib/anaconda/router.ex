defmodule Anaconda.Router do
  use Plug.Router
  require Logger

  plug(:match)
  plug(:dispatch)

  post "/" do
    prefix = Application.fetch_env!(:anaconda, :url_prefix)
    long_url = :proplists.get_value("shorten-url", conn.req_headers)

    result =
      case :dets.match(:urls, {:"$1", long_url}) do
        [[suffix]] -> {:ok, suffix}
        [] -> :not_found
      end

    short_url =
      case result do
        {:ok, suffix} ->
          Logger.debug("Use existing suffix: #{inspect(suffix)} for URL #{long_url}")
          "#{prefix}/#{suffix}\n"

        :not_found ->
          Logger.debug("Shorten URL: #{inspect(long_url)}")
          suffix = Anaconda.random_string()
          :ok = :dets.insert(:urls, {suffix, long_url})
          "#{prefix}/#{suffix}\n"
      end

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, short_url)
  end

  match _ do
    case conn.path_info do
      [encoded] ->
        suffix = URI.decode(to_string(encoded))

        case :dets.lookup(:urls, suffix) do
          [] ->
            send_resp(conn, 404, "Invalid path.\n")

          [{^suffix, url}] ->
            Logger.debug("Redirect to #{url}")

            conn
            |> put_resp_header("location", url)
            |> send_resp(301, suffix)
        end

      _ ->
        send_resp(conn, 404, "Invalid path.")
    end
  end
end

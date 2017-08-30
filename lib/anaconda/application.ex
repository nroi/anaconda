defmodule Anaconda.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def create_cache_dir() do
    user_cache_dir = System.get_env("XDG_CACHE_HOME") || Path.join(System.user_home(), ".cache")
    anaconda_cache_dir = Path.join(user_cache_dir, "anaconda")
    File.mkdir_p!(anaconda_cache_dir)
    anaconda_cache_dir
  end

  def start(_type, _args) do
    cache_dir = create_cache_dir()
    port = Application.fetch_env!(:anaconda, :port)
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Anaconda.Router, [], [port: port])
    ]
    {:ok, _name} = :dets.open_file(:urls, file: to_charlist(Path.join(cache_dir, "urls.dat")))
    opts = [strategy: :one_for_one, name: Anaconda.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

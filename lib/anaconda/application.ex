defmodule Anaconda.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Anaconda.Worker.start_link(arg)
      # {Anaconda.Worker, arg},
      Plug.Adapters.Cowboy.child_spec(:http, Anaconda.Router, [], [port: 4072])
    ]

    :urls = :ets.new(:urls, [:set, :named_table, :public])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Anaconda.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

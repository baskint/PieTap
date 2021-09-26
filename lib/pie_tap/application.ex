defmodule PieTap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: PieTap.Handler.DynamicSupervisor},
      {Task, fn -> PieTap.accept(Application.get_env(:pie_tap, :port)) end}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PieTap.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

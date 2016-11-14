defmodule Olympics.Api do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Olympics.Web, [])
    ]

    opts = [strategy: :one_for_one, name: Olympics.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

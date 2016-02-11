defmodule Bot.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    token = System.get_env("SLACK_TOKEN")
    children = [
      worker(Calc, [token])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

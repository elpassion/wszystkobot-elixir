defmodule Bot.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    token = Application.get_env(:bot, :slack_token)
    children = [
      worker(Calc, [token]),
      worker(HubReporter, [token])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

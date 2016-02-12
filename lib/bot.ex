require :http_uri

defmodule Bot do
  use Application

  def start(_type, _args) do
    Bot.Supervisor.start_link
    :timer.sleep(:infinity)
  end
end



defmodule Bot.Mixfile do
  use Mix.Project

  def project do
    [app: :bot,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [ applications: [:logger, :slack, :edeliver, :quantum, :hub_reporter, :calc, :message_forwarder],
      mod: {Bot, []} ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [ {:slack, "~> 0.4.1"},
      {:websocket_client, git: "https://github.com/jeremyong/websocket_client"},
      {:quantum, ">= 1.6.1"},
      {:edeliver, ">= 1.1.1"},
      {:calc, ">= 0.0.1", path: "calc"},
      {:message_forwarder, ">= 0.0.1", path: "message_forwarder"},
      {:hub_reporter, ">= 0.0.1", path: "hub_reporter"}
    ]
  end
end

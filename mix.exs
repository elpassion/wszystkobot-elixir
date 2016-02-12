defmodule Bot.Mixfile do
  use Mix.Project

  def project do
    [app: :bot,
     version: "0.0.3",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # [ applications: [:logger, :slacker, :edeliver, :quantum, :hub_reporter, :calc, :message_forwarder, :love_spammer],
    [ applications: [:logger, :edeliver, :slacker, :calc, :hub_reporter],
      mod: {Bot, []} ]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [ {:websocket_client, git: "https://github.com/jeremyong/websocket_client.git"},
      {:slacker,  "~> 0.0.1"},
      {:edeliver, git: "https://github.com/boldpoker/edeliver.git"},
      {:exrm, "~> 0.19"},
      {:conform, "~> 0.17", override: true},
      {:conform_exrm, "~> 0.2"},
      {:calc, ">= 0.0.1", path: "calc"},
      {:hub_reporter, ">= 0.0.1", path: "hub_reporter"} ]
  end
end

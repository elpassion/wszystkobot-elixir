defmodule HubReporter.Mixfile do
  use Mix.Project

  def project do
    [app: :hub_reporter,
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
    [applications: [:logger, :httpoison, :tzdata]]
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
    [ {:expr, git: "https://github.com/elpassion/expr.git"},
      {:websocket_client, git: "https://github.com/jeremyong/websocket_client.git"},
      {:slacker,  "~> 0.0.1"},
      {:exjsx, "~> 3.1"},
      {:httpoison, "~> 0.8.0"},
      {:timex, "~> 1.0.0"} ]
  end
end

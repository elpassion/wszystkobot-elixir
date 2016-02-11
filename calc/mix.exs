defmodule Calc.Mixfile do
  use Mix.Project

  def project do
    [app: :calc,
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
    [applications: [:logger]]
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
  def deps do
    [ {:expr, git: "https://github.com/elpassion/expr.git"},
      {:websocket_client, github: "jeremyong/websocket_client"},
      {:slacker,  "~> 0.0.1"} ]
  end
end

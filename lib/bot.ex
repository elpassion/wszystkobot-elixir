defmodule Bot do
  use Slack

  def start(_type, _args) do
    Bot.start_link(System.get_env("SLACK_TOKEN"), [])
  end

  def handle_connect(slack, state) do
    {:ok, state}
  end

  def handle_message(message = %{type: "message", text: "help"}, slack, state) do
    send_message(Bot.Help.call, message.channel, slack)
    {:ok, state }
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    # TODO: make it better
    somethingDone = false

    if HubReporter.can_handle_message(message) do
      send_message(HubReporter.handle_message(message), message.channel, slack)
      somethingDone = true
    end

    unless somethingDone do
      infoAboutHelp(message.channel, slack)
    end

    {:ok, state ++ [message.text]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end

  def infoAboutHelp(to, slack) do
    send_message("unknown command, type `help` to see awailable options", to, slack)
  end
end

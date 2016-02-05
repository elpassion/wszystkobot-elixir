defmodule Bot do
  use Slack

  def start(_type, _args) do
    IO.puts System.get_env("SLACK_TOKEN")
    Bot.start_link(System.get_env("SLACK_TOKEN"), [])
  end

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    message_to_send = "Received #{length(state)} messages so far!"
    send_message(message_to_send, message.channel, slack)

    if HubReporter.can_handle_message(message) do
      send_message(HubReporter.handle_message(message), message.channel, slack)
    end

    {:ok, state ++ [message.text]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end
end

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
    responses = []

    if HubReporter.can_handle_message(message) do
      responses = List.insert_at(responses, -1, HubReporter.handle_message(message))
    end

    handle_responses(responses, message, slack)

    {:ok, state ++ [message.text]}
  end

  def handle_responses(responses, message, slack) do
    unless List.keyfind(responses, :ok, 0) do
      infoAboutHelp(message.channel, slack)
    end

    responses |> Enum.map(fn (response) ->
      if elem(response, 1) == :message do
        send_message(elem(response, 2), message.channel, slack)
      end
    end)
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end

  def infoAboutHelp(to, slack) do
    send_message("unknown command, type `help` to see awailable options", to, slack)
  end
end

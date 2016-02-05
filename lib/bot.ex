defmodule Bot do
  use Slack

  def start(_type, _args) do
    Bot.start_link(System.get_env("SLACK_TOKEN"), [])
  end

  def handle_connect(slack, state) do
    Agent.start_link(fn -> slack end, name: Bot)
    {:ok, state}
  end

  def handle_message(message = %{type: "message", text: "help"}, slack, state) do
    send_message(Bot.Help.call, message.channel, slack)
    {:ok, state }
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    responses = []

    responses = List.insert_at(responses, -1, call_hub(message))
    responses = List.insert_at(responses, -1, call_calc(message))
    responses = List.insert_at(responses, -1, call_love_spammer(message))

    handle_responses(responses, message, slack)

    {:ok, state ++ [message.text]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end

  # private

  defp handle_responses(responses, message, slack) do
    unless List.keyfind(responses, :ok, 0) || List.keyfind(responses, :error, 0)do
      infoAboutHelp(message.channel, slack)
    end

    responses |> Enum.map(fn (response) ->
      if elem(response, 1) == :message do
        send_message("#{elem(response, 2)}", message.channel, slack)
      end
    end)
  end

  defp infoAboutHelp(to, slack) do
    send_message("unknown command, type `help` to see awailable options", to, slack)
  end

  defp call_calc(message) do
    try do
      CALC.interact(message.text)
    rescue
      e -> {:error, :message, Exception.message(e)}
    end
  end

  defp call_hub(message) do
    try do
      if HubReporter.can_handle_message(message) do
        HubReporter.handle_message(message)
      else
        {:ignored, :none, ""}
      end
    rescue
      e -> {:error, :message, Exception.message(e)}
    end
  end

  defp call_love_spammer(message) do
    if LoveSpammer.can_handle_message(message) do
      LoveSpammer.handle_message(message)
    else
      {:ignored, :none, ""}
    end
  end
end

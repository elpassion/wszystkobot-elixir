defmodule HubReporter do

  def can_handle_message(message) do
    [prefix | _] = String.split(message.text)
    prefix == "hub"
  end

  def handle_message(message) do
    case message.text do
      "hub token" <> tail ->
        TokenHandler.handle(String.split(tail), message.user)
      "hub fetch" <> tail ->
        ReportsHandler.handle_latest(String.split(tail), message.user)
      "hub push" <> tail ->
        ReportsHandler.handle_sending_report(tail, message.user)
      "hub status" <> tail ->
        "hub status"
      _ ->
        "There's no function #{message.text}"
    end
  end
end

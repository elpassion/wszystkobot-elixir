defmodule HubReporter do

  def can_handle_message(message) do
    [prefix | _] = String.split(message.text)
    prefix == "hub"
  end

  def handle_message(message) do
    resp = case message.text do
      "hub token" <> tail ->
        TokenHandler.handle(String.split(tail), message.user)
      "hub fetch" <> tail ->
        ReportsHandler.handle_latest(String.split(tail), message.user)
      "hub push " <> tail ->
        ReportsHandler.handle_sending_report(tail, message.user)
      "hub status" <> tail ->
        ReportsHandler.handle_status(message.user)
      _ ->
        "There's no function #{message.text}"
    end
    {:ok, :message, resp}
  end
end

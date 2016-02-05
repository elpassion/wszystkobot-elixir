defmodule HubReporter do

  def can_handle_message(message) do
    [prefix | _] = String.split(message.text)
    prefix == "hub"
  end

  def handle_message(message) do
    resp = case message.text do
      "hub token" <> tail ->
        TokenHandler.handle(String.split(tail), message.user)
      "hub latest" <> tail ->
        ReportsHandler.handle(String.split(tail), message.user)
      _ ->
        "There's no function #{message.text}"
    end
    {:ok, :message, resp}
  end
end

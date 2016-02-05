defmodule HubReporter do

  def can_handle_message(message) do
    [prefix | _] = String.split(message)
    prefix == "hub"
  end

  def handle_message("hub " <> message) do
    execute(String.split(message))
  end

  def handle_message(message) do
    message
  end

  def execute([ "token" | components]) do
    TokenHandler.handle(components)
  end

  def execute([ "latest" | components]) do
    ReportsHandler.handle(components)
  end

  def execute(components) do
    "There's no function #{hd(components)}"
  end
end

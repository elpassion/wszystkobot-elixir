defmodule HubReporter do

  def canHandleMessage(message) do
    [prefix | _] = String.split(message)
    prefix == "hub"
  end

  def handleMessage("hub " <> message) do
    execute(String.split(message))
  end

  def handleMessage(message) do
    message
  end

  def execute([ "token" | components]) do
    TokenHandler.handle(components)
  end

  def execute(components) do
    "There's no function #{hd(components)}"
  end
end

defmodule TokenHandler do

  def handle(components) when length(components) == 1 do
    File.write(".token", List.first(components))
    "Token added."
  end

  def handle(_) do
    handleShowToken(token())
  end

  def handleShowToken("") do
    "There's no token assigned to your account."
  end

  def handleShowToken(token) do
    "Your token is #{token}"
  end

  def token() do
    case File.read(".token") do
      {:ok, x} ->
        x
      _ -> ""
    end
  end

  def clean do
    File.write(".token", "")
  end
end

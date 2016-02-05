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

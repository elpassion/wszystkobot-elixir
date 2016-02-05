defmodule TokenHandler do

  def handle(components, user) when length(components) == 1 do
    current = read_file
    token = List.first(components)
    write_file(Map.put(current, user, token))
  end

  def handle(_, user) when user != "" do
    handleShowToken(token(user))
  end

  def handle(_, _) do
    handleShowToken("")
  end

  def handleShowToken(nil) do
    handleShowToken("")
  end

  def handleShowToken("") do
    "There's no token assigned to your account."
  end

  def handleShowToken(token) do
    "Your token is #{token}"
  end

  def token(user) do
    current = read_file
    current[user]
  end

  def clean do
    File.write(".token", "")
  end

  def read_file do
    case File.read(".token") do
      {:ok, x} ->
        decode(x)
      _ ->
        %{}
    end
  end

  defp decode(content) do
    case JSX.decode content do
      {:ok, body} ->
        body
      _ ->
        %{}
    end
  end

  defp write_file(content) do
    case JSX.encode content do
      {:ok, json} ->
        File.write(".token", json)
        "Token added."
      _ ->
        "Internal server error 500 ;("
    end
  end
end

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
    File.write(token_file_name, "")
  end

  def read_file do
    case File.read(token_file_name) do
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
        File.write(token_file_name, json)
        "Token added."
      _ ->
        "Internal server error 500 ;("
    end
  end

  defp token_file_name do
    Application.get_env(:hub_reporter, :token_file_name)
  end
end

defmodule AliasHandler do

  def handle(id, project_alias, user) do
    current = read_file(user)
    write_file(Map.put(current, project_alias, id), user)
  end

  def read_file(user) do
    case File.read("hub_reporter/aliases/.#{user}-aliases") do
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

  defp write_file(content, user) do
    case JSX.encode content do
      {:ok, json} ->
        File.write("hub_reporter/aliases/.#{user}-aliases", json)
        "Alias added."
      _ ->
        "Internal server error 500 ;("
    end
  end
end

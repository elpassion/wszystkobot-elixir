defmodule ProjectsHandler do

  def handle_alias(message, user) do
    token = TokenHandler.token(user)
    case Enum.count(String.split(message, " | ")) do
      2 ->
        handle_message(message, token, user)
      _ ->
        "Something went wrong"
    end
  end

  def handle_alias(user) do
    case Formatter.format_aliases(user) do
      "" ->
        "You've got no aliases."
      aliases ->
        aliases
    end
  end

  def handle_projects(_, user) do
    token = TokenHandler.token(user)
    Formatter.format_projects(HubApi.fetch_projects(token))
  end

  def handle_projects(_, _) do
    "Something went really, really wrong"
  end

  def handle_message(message, token, user) do
    message = String.split(message, " | ")
    id = get_an_id(message)
    project_alias = get_an_alias(message)
    case validate_errors(id, project_alias) do
      true ->
        AliasHandler.handle(id, project_alias, user)
      error ->
        error
    end
  end

  def validate_errors(id, project_alias) do
    case id do
      nil ->
        error = "ID is incorrect" #check if id exists?
      _ ->
        case project_alias do
          nil ->
            error = "Alias is incorrect. Should be minimum 3 characters long and without whitespaces"
          _ ->
            true
        end
    end
  end

  def get_an_alias(message) do
    case String.length(List.first(message)) > 2 do
      true ->
        case String.contains?(List.first(message), " ") do
          false ->
            List.first(message)
          true ->
            nil
        end
      false ->
        nil
    end
  end

  def get_an_id(message) do
    try do
      String.to_integer(List.last(message))
    rescue
      ArgumentError -> nil
      _ -> List.last(message)
    end
  end
end

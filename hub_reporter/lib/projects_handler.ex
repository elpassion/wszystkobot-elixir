defmodule ProjectsHandler do

  def handle(_, user) do
    Formatter.format_projects(HubApi.fetch_projects(TokenHandler.token(user)))
  end
end

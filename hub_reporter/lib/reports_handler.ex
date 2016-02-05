defmodule ReportsHandler do

  def handle([], user) do
    token = TokenHandler.token(user)
    Formatter.format_activities(HubApi.fetch_latest_activities(token), HubApi.fetch_projects(token))
  end

end

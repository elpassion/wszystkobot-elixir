defmodule ReportsHandler do

  def handle([]) do
    Formatter.format_activities(HubApi.fetch_latest_activities, HubApi.fetch_projects)
  end

end

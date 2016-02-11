defmodule ReportsHandler do
  use Timex

  def handle_latest(user) do
    token = TokenHandler.token(user)
    Formatter.format_activities(HubApi.fetch_latest_activities(token), HubApi.fetch_projects(token))
  end

  def handle_sending_report(message, user) do
    token = TokenHandler.token(user)
    projects = HubApi.fetch_projects(token)
    latest = HubApi.fetch_latest_activities(token)
    time_report = create_report(message, projects, latest)
    HubApi.send_report(token, time_report)
  end

  def handle_status(user) do
    token = TokenHandler.token(user)
    projects = HubApi.fetch_projects(token)
    latest = HubApi.fetch_latest_activities(token)
    project_name = Formatter.get_project_by_id(latest_project_id(latest), projects)["name"]
    date = date_string(Date.universal)

    "Your report status might be 8 hours for #{project_name} at #{date} ready to be pushed."
  end

  def create_report(message, projects, latest, date \\ Date.universal) do
    %TimeReport{
      performed_at: date_string(date),
      project_id: latest_project_id(latest),
      value: "8",
      comment: message
    }
  end

  def latest_project_id(latest) do
    item = List.last(latest)["project_id"]
  end

  def date_string(date) do
    case date |> DateFormat.format("%Y-%m-%d", :strftime) do
      {:ok, str} ->
        str
      value ->
        ""
    end
  end

end

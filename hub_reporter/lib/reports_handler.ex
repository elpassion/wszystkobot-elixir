defmodule ReportsHandler do
  use Timex

  def handle_latest([], user) do
    token = TokenHandler.token(user)
    Formatter.format_activities(HubApi.fetch_latest_activities(token), HubApi.fetch_projects(token))
  end

  def handle_sending_report(message, user) do
    token = TokenHandler.token(user)
    projects = HubApi.fetch_projects(token)
    latest = HubApi.fetch_latest_activities(token)
    case Enum.count(String.split(message, " | ")) do
      0 ->
        "Something went wrong"
      1 ->
        make_simplified_report(message, projects, latest, token)
      3 ->
        make_extended_report(message, projects, latest, token)
    end
  end

  def handle_status(user) do
    token = TokenHandler.token(user)
    projects = HubApi.fetch_projects(token)
    latest = HubApi.fetch_latest_activities(token)
    project_name = Formatter.get_project_by_id(latest_project_id(latest), projects)["name"]
    date = date_string(Date.universal)

    "Your report status might be 8 hours for #{project_name} at #{date} ready to be pushed."
  end

  def create_report(date \\ date_string(Date.universal), value \\ "8", comment, projects, latest) do
    %TimeReport{
      performed_at: date,
      project_id: latest_project_id(latest),
      value: value,
      comment: comment
    }
  end

  def latest_project_id(latest) do
    List.last(latest)["project_id"]
  end

  def date_string(date) do
    case date |> DateFormat.format("%Y-%m-%d", :strftime) do
      {:ok, str} ->
        str
      value ->
        ""
    end
  end

  def get_date_from_message(message) do
    case String.length(List.first(message)) do
      10 ->
        List.first(message)
      _ ->
        nil
    end
  end

  def get_value_from_message(message) do
    try do
      String.to_integer(Enum.at(message, 1))
    rescue
      ArgumentError -> nil
      _ -> Enum.at(message, 1)
    end
  end

  def get_comment_from_message(message) do
    case String.length(List.last(message)) > 10 do
      true ->
        List.last(message)
      false ->
        nil
    end
  end

  def validate_errors(date, value, comment) do
    validate_date(date, value, comment)
  end

  def validate_date(date, value, comment) do
    case date do
      nil ->
        error = "Wrong date format. Should be: YYYY-MM-DD."
      _ ->
        validate_value(value, comment)
    end
  end

  def validate_value(value, comment) do
    case value do
      nil ->
        error = "Wrong value format. Should be between 1-24"
      _ ->
        validate_comment(comment)
    end
  end

  def validate_comment(comment) do
    case comment do
      nil ->
        error = "Comment non given or too short. Should be at least 10 characters long."
      _ ->
        true
    end
  end

  def make_simplified_report(message, projects, latest, token) do
    comment = message
    time_report = create_report(comment, projects, latest)
    HubApi.send_report(token, time_report)
  end

  def make_extended_report(message, projects, latest, token) do
    message = String.split(message, " | ")
    date = get_date_from_message(message)
    value = get_value_from_message(message)
    comment = get_comment_from_message(message)
    case validate_errors(date, value, comment) do
      true ->
        time_report = create_report(date, value, comment, projects, latest)
        HubApi.send_report(token, time_report)
      error ->
        error
    end
  end
end

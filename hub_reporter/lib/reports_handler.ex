defmodule ReportsHandler do
  use Timex

  def handle_latest(_, user) do
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
      4 ->
        make_extended_report(message, projects, latest, token, user)
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

  def create_report(date \\ date_string(Date.universal), value \\ "8", projects_alias_id \\ nil, comment, projects, latest) do
    check_if_projects_alias_non_given(projects_alias_id, latest)
    %TimeReport{
      performed_at: date,
      project_id: projects_alias_id,
      value: value,
      comment: comment
    }
  end

  def check_if_projects_alias_non_given(projects_alias_id, latest) do
    case projects_alias_id do
      nil ->
        latest_project_id(latest)
      projects_alias_id ->
        projects_alias_id
    end
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

  def get_projects_alias_from_message(message, user) do
    given_alias = Enum.at(message, 2)
    aliases = AliasHandler.read_file(user)

    case Map.has_key?(aliases, given_alias) do
      true ->
        case Kernel.is_integer(Map.get(aliases, given_alias)) do
          true ->
            Map.get(aliases, given_alias)
          false ->
            nil
        end
      false ->
        nil
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

  def validate_errors(date, value, comment, projects_alias_id) do
    validate_date(date, value, comment, projects_alias_id)
  end

  def validate_date(date, value, comment, projects_alias_id) do
    case date do
      nil ->
        error = "Wrong date format. Should be: YYYY-MM-DD."
      _ ->
        validate_value(value, comment, projects_alias_id)
    end
  end

  def validate_value(value, comment, projects_alias_id) do
    case value do
      nil ->
        error = "Wrong value format. Should be between 1-24"
      _ ->
        validate_project_id(comment, projects_alias_id)
    end
  end

  def validate_project_id(comment, projects_alias_id) do
    case projects_alias_id do
      nil ->
        error = "Something went wrong with your alias. Check if exists by hub alias command"
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
    "Succes simp"
    HubApi.send_report(token, time_report)
  end

  def make_extended_report(message, projects, latest, token, user) do
    message = String.split(message, " | ")
    date = get_date_from_message(message)
    value = get_value_from_message(message)
    projects_alias_id = get_projects_alias_from_message(message, user)
    comment = get_comment_from_message(message)
    case validate_errors(date, value, comment, projects_alias_id) do
      true ->
        time_report = create_report(date, value, projects_alias_id, comment, projects, latest)
        HubApi.send_report(token, time_report)
      error ->
        error
    end
  end
end

defmodule Formatter do
  def format_activities(activities, projects) do
    items = Enum.map activities, fn(x) ->
      format_activity(x, projects)
    end
    Enum.join(items)
  end

  def format_activity(activity, projects) do
    project = get_project_by_id(activity["project_id"], projects)
    "Date: #{activity["performed_at"]} Project: #{project["name"]} Hours: #{activity["value"]} Comment: #{activity["comment"]}\n"
  end

  def format_projects(projects) do
    items = Enum.map projects, fn(project) ->
      format_project(project)
    end
    items
    |> Enum.sort
    |> Enum.join("\n")
  end

  def format_aliases(user) do
    aliases =for {key, value} <- AliasHandler.read_file(user) do
      "#{value} - ID: #{key}"
    end
    aliases |> Enum.join("\n")
  end

  def format_project(project) do
    "#{project["name"]}: #{project["id"]}"
  end

  def get_project_by_id(id, projects) do
    Enum.find projects, fn(x) ->
      x["id"] == id
    end
  end
end

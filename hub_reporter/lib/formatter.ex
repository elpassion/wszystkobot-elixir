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

  def get_project_by_id(id, projects) do
    Enum.find projects, fn(x) ->
      x["id"] == id
    end
  end
end

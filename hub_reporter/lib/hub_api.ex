defmodule TimeReport do
  defstruct performed_at: "", project_id: "", value: "8", comment: "", report_type: 0
end

defmodule HubApi do

  def fetch_latest_activities(token, fetcher \\ HTTPoison) do
    get("activities/latest", fetcher, token)
  end

  def fetch_projects(token, fetcher \\ HTTPoison) do
    get("/projects", fetcher, token)
  end

  def send_report(token, time_report, fetcher \\ HTTPoison) do
    case fetcher.post("https://hub.elpassion.com/api/v1/activities", encode(params(time_report)), headers(token)) do
      {:ok, response} ->
        body = decode(response.body)
        "Time report pushed for #{body["performed_at"]}"
      _ ->
        "Sending report failed"
    end
  end

  def params(time_report) do
    %{
      "activity": %{
        "performed_at": time_report.performed_at,
        "project_id": time_report.project_id,
        "value": time_report.value,
        "comment": time_report.comment
        # "report_type": time_report.report_type
        }
      }
  end

  defp get(suffix, fetcher, token) do
    case fetcher.get("https://hub.elpassion.com/api/v1/#{suffix}", headers(token)) do
      {:ok, response} ->
        decode(response.body)
      _ ->
        []
    end
  end

  defp encode(params) do
    case JSX.encode params do
      {:ok, string} ->
        string
      _ ->
        nil
    end
  end

  defp decode(body) do
    case JSX.decode body do
      {:ok, response} ->
        response
      _ ->
        []
    end
  end

  defp headers(token) do
    [{ "X-Access-Token", token }, { "Content-Type", "application/json" }]
  end

end

defmodule HubApi do

  def fetch_latest_activities(token, fetcher \\ HTTPoison) do
    get("activities/latest", fetcher, token)
  end

  def fetch_projects(token, fetcher \\ HTTPoison) do
    get("/projects", fetcher, token)
  end

  defp get(suffix, fetcher, token) do
    case fetcher.get("https://hub.elpassion.com/api/v1/#{suffix}", headers(token)) do
      {:ok, response} ->
        decode(response.body)
      _ ->
        []
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
    [{ "X-Access-Token", token }]
  end

end

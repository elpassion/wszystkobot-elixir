defmodule HubApi do

  def fetch_latest_activities(fetcher \\ HTTPoison) do
    get("activities/latest", fetcher)
  end

  def fetch_projects(fetcher \\ HTTPoison) do
    get("/projects", fetcher)
  end

  defp get(suffix, fetcher) do
    case fetcher.get("https://hub.elpassion.com/api/v1/#{suffix}", headers) do
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

  defp headers do
    [{ "X-Access-Token", TokenHandler.token() }]
  end

end

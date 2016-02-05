defmodule CreateRepoTest do
  use ExUnit.Case
  use Timex
  doctest HubReporter

  # performed_at: "", project_id: "", value: "8", comment: "", report_type: 0

  test "" do
    message = "comment"
    report = ReportsHandler.create_report(message, projects, latest, date("2000-01-01"))

    expected = %TimeReport{performed_at: "2000-01-01", project_id: "3", value: "8", comment: "comment"}
    assert report == expected
  end

  def projects do
    [
      %{"project_id": 1, "name": "BeautySets"},
      %{"project_id": 2, "name": "FinxS"},
    ]
  end

  def latest do
    json([
      %{"project_id": "3"}
    ])
  end

  def date(str) do
    case DateFormat.parse(str, "%Y-%m-%d", :strftime) do
      {:ok, value} ->
        value
      ehh ->
        Date.universal
    end
  end

  def json(map) do
    case JSX.encode map do
      {:ok, string} ->
        case JSX.decode string do
          {:ok, value} ->
            value
        end
    end
  end
end

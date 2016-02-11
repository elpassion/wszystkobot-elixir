defmodule HubReporter do
  @moduledoc false

  use Slacker
  use Slacker.Matcher

  match ~r/^hub token (.*)/i, :store_token
  match ~r/^hub token\z/i, :show_token
  match ~r/^hub fetch\z/i, :fetch
  match ~r/^hub status\z/i, :status
  match ~r/^hub push ?(.*)/i, :push

  def show_token(reporter, message) do
    say reporter, message["channel"], TokenHandler.handle(message["user"])
  end

  def store_token(reporter, message, token) do
    say reporter, message["channel"], TokenHandler.handle(token, message["user"])
  end

  def fetch(reporter, message) do
    say reporter, message["channel"], ReportsHandler.handle_latest(message["user"])
  end

  def status(reporter, message) do
    say reporter, message["channel"], ReportsHandler.handle_status(message["user"])
  end

  def push(reporter, message, report) do
    say reporter, message["channel"], ReportsHandler.handle_sending_report(report, message["user"])
  end
end

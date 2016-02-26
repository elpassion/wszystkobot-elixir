defmodule HubReporter.Help do
  def call do
    ~s"""
      hub token TOKEN - saves user token
      hub token - shows user token
      hub status - shows a status for a simplified hub push command
      hub push COMMENT - adds a time report for today's date, 8 hours and today's date
      hub push YYYY-MM-DD | HOURS | COMMENT - adds a time report for latest project with declared date and value, for example: "hub push 2000-10-10 | 8 | playing fifa all day long" (USE THIS ORDER!)
    """
  end
end

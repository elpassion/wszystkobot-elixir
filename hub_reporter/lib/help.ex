defmodule HubReporter.Help do
  def call do
    ~s"""
      hub token TOKEN - saves user token
      hub token - shows user token
      hub status - shows a status for a simplified hub push command
      hub push COMMENT - adds a time report for 8 hours and today's date
      hub alias - shows your aliases
      hub alias ALIAS | ID - adds new alias for specific projects id
      hub projects - shows projects ids
      hub push YYYY-MM-DD | HOURS | ALIAS | COMMENT - adds a time report with declared date, value and project, for example: "hub push 2000-10-10 | 8 | OEL | playing fifa all day long" (USE THIS ORDER!)
    """
  end
end

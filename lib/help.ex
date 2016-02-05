defmodule Bot.Help do
  def call do
    ~s"""
      help:
        wszsytkobot potrafi robić:

        hub:
          #{HubReporter.Help.call}

        calc:
          #{CALC.Help.call}
    """
  end
end

defmodule Bot.Help do
  def call do
    ~s"""
      help:
        wszsytkobot potrafi robić:

        hub:
          #{HubReporter.Help.call}

        calc:
          #{Calc.Help.call}
    """
  end
end

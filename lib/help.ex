defmodule Bot.Help do
  def call do
    ~s"""
      help:
        wszsytkobot potrafi robić:

        hub:
          #{HubReporter.Help.call}
    """
  end
end

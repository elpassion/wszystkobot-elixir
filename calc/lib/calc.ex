defmodule Calc do
  @moduledoc false

  use Slacker
  use Slacker.Matcher

  import List

  match ~r/help/i, :help
  match ~r/^How much is ([0-9+-\/*%\(\) ]*)/i, :interact
  match ~r/^calc ([0-9+-\/*%\(\) ]*)/i, :interact

  def interact(calc, msg, equation) do
    try do
      say calc, msg["channel"], proceed(equation)
    rescue
      _ -> say calc, msg["channel"], "Naah, something is wrong with your equation, man."
    end
  end

  def proceed(msg) do
    msg
    |> calculate
    |> Kernel.to_string
  end

  def help(reporter, message) do
    say reporter, message["channel"], help_message
  end

  defp calculate(equation) do
    equation |> Expr.eval! |> hd
  end

  defp help_message do
    ~s"""
      calc:
      	how much is OP - returns the result of a mathematical operation
      	calc OP - returns the result of a mathematical operation
    """
  end
end

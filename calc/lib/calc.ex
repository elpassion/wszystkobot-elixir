defmodule Calc do
  @moduledoc false

  use Slacker
  use Slacker.Matcher

  import List

  @servicable_msg_regexp ~r/^How much is ([0-9+-\/*%\(\) ]*)/i

  match @servicable_msg_regexp, :interact

  def interact(calc, msg, level) do
    say calc, msg["channel"], proceed(msg["text"])
  end

  def proceed(msg) do
    msg
    |> extract_equation
    |> calculate
    |> Kernel.to_string
  end

  defp extract_equation(msg) do
    @servicable_msg_regexp |> Regex.run(msg) |> last
  end

  defp calculate(equation) do
    equation |> Expr.eval! |> hd
  end
end

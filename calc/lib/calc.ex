defmodule Calc do
	@moduledoc false

	import List

  @servicable_msg_regexp ~r/^How much is ([0-9+-\/*%\(\) ]*)/i
  @fail_msg "Naah, something is wrong with your equation, man."

  def interact(msg) do
    if msg |> can_handle_message? do
        try do
          { :ok, :message, msg |> extract_equation |> calculate }
        rescue
          _ -> { :ok, :message, @fail_msg}
        end
    else 
        { :ignored, :none, "" }
    end
  end

	def can_handle_message?(msg) do
		@servicable_msg_regexp |> Regex.match?(msg)
	end

	defp extract_equation(msg) do
		@servicable_msg_regexp |> Regex.run(msg) |> last
	end

	defp calculate(equation) do
		equation |> Expr.eval! |> hd
	end

end

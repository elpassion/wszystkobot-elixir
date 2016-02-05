defmodule CALC do
	import List

	@servicable_msg_regexp ~r/^How much is ([0-9+-\/*%\(\) ]*)/i

	def interact (msg) do
		unless servicable(msg) do
			{ :ignored }
		else
			try do
				equation = extract_equation(msg)
				result = calculate(equation)
				{ :ok,  result }
			rescue
				_ -> { :ok, "Naah, something is wrong with your equation, man."}
			end			
		end
	end

	defp servicable (msg) do
		Regex.match?(@servicable_msg_regexp, msg)
	end

	defp extract_equation(msg) do
		last(Regex.run(@servicable_msg_regexp, msg))
	end

	defp calculate(equation) do
		hd(Expr.eval!(equation))	
	end

end

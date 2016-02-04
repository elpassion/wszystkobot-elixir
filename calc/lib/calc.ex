defmodule CALC do
	import Code
	import List

	@servicable_msg_regexp ~r/^How much is ([0-9+-\/* ]*)/i

	def interact (msg) do
		unless servicable(msg) do
			{ :ignored }
		else
			equation = extract_equation(msg)
			result = calculate(equation)
			{ :ok,  result }
		end
	end

	defp servicable (msg) do
		Regex.match?(@servicable_msg_regexp, msg)
	end

	defp extract_equation(msg) do
		last(Regex.run(@servicable_msg_regexp, msg))
	end

	defp calculate(equation) do
		[ result ] = Expr.eval!(equation)
		
		#dough.. maybe there's a better way to convert float to int
		result_int = round(result)
		if result_int == result do
			result_int
		else
			result
		end
	end

end

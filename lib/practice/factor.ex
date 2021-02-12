defmodule Practice.Factor do 
	def factor(x) do
		if (!is_integer(x)) do 
		 	input = String.to_integer(x)
			factor_helper(input, 2, [])
		else 
			if (x <= 0) do 
				raise ArgumentError, "invalid argument"
			else
				factor_helper(x, 2, [])
			end

		end 
	end 

	def factor_helper(x, i, acc) do 
		if (x === 1) do
			acc	
		else  	
			cond do 
				rem(x, i) === 0 -> factor_helper(div(x, i), 2, acc++[i])
				true -> factor_helper(x, i+1, acc)
			end 
		end 
	end
end



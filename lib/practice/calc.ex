defmodule Practice.Calc do
	def parse_float(text) do
		{num, _} = Float.parse(text)
		num
	end
	
	def prece(op) do 
		case op do 
			"+" -> 1
			"-" -> 1
			"*" -> 2
			"/" -> 2
		end 
	end 

	def push_post(stack, postfix) do 
		if (length(stack) == 0) do 
			postfix
		else 
			push_post(tl(stack), postfix++[{:op, hd(stack)}])
		end
	end 

	def postfix(expr, stack, postfix) do 
		if expr === [] do 
			push_post(Enum.reverse(stack), postfix)
		else 
			case hd(expr) do 
				{:op, value} -> 
					if length(stack) == 0 do 
						postfix(tl(expr), stack++[value], postfix)
					else
						if (prece(value) > prece(List.last(stack))) do 
							postfix(tl(expr), stack++[value], postfix)
						else 
							postfix(tl(expr), []++[value], push_post(Enum.reverse(stack), postfix))
						end
					end
				{:num, value} -> postfix(tl(expr), stack, postfix++[{:num, value}])
			end
		end
	end
	
	def tokenize(op) do 
		case op do 
			"+" -> {:op, "+"}
			"-" -> {:op, "-"}
			"/" -> {:op, "/"}
			"*" -> {:op, "*"}
			x   -> {:num, parse_float(x)}
		end
	end 

	def handle_calculation(op, x, y) do 
		case op do 
			"+" -> x + y
			"-" -> x - y
			"*" -> x * y 
			"/" -> x / y 
			_ -> raise ArgumentError, "invalid calculation operator"
		end
	end

	def handle_expr(prefix, result) do 
		if (prefix === []) do 
			hd(result)
		else 
			value1 = List.pop_at(prefix, length(prefix) - 1)
			case elem(value1, 0) do 
				{:op, value} -> 
					{operand1 , stack1}  = List.pop_at(result, 0)
					{operand2 , stack2} = List.pop_at(stack1, 0)
					calc = handle_calculation(value, operand2, operand1)
					handle_expr(elem(value1, 1), [calc]++stack2)

				{:num, value} -> (handle_expr(elem(value1, 1), [value]++result)) 
			end
		end 	
	end 

	def calc(expr) do
		expr
		|> String.split()
		|> Enum.map(fn value -> tokenize(value) end)
		|> postfix([],[])
		|> Enum.reverse
		|> handle_expr([])
	end
end

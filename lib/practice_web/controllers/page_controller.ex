defmodule PracticeWeb.PageController do
	use PracticeWeb, :controller

  	def index(conn, _params) do
    		render(conn, "index.html")
 	 end

  	def double(conn, %{"x" => x}) do
    		{x, _} = Integer.parse(x)
    		y = Practice.double(x)
    		render conn, "double.html", x: x, y: y
  	end

  	def calc(conn, %{"expr" => expr}) do
    		y = Practice.calc(expr)
    		render conn, "calc.html", expr: expr, y: y
  	end

  	def factor(conn, %{"x" => x}) do
		try do 
    			factors = Practice.factor(x)
			y = Enum.join(factors, ", ")
			render conn, "factor.html", x: x, y: y
		rescue 
			ArgumentError ->
			y = "Invalid Input, input should be a number that is great than 0."
			render conn, "factor.html", x: x, y: y
		end
    		 	 
	end

	def palindrome(conn, %{"expr" => expr}) do 
		y = Practice.palindrome(expr)
		render conn, "palindrome.html", expr: expr, y: y
	end
end

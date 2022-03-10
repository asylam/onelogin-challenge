# Expression expects input to be two fractions/integers and a legal operator
# separated by white space. Raises exceptions for unexpected input and
# zero division errors.
class Expression
	def initialize(input)
  	@tokens = input.split(/\s+/)
  	parse_tokens
	end

  def evaluate
  	case @operator
  	when '+'
  		solution = @operand_left + @operand_right
  	when '-'
  		solution = @operand_left - @operand_right
  	when '*'
  		solution = @operand_left * @operand_right
  	when '/'
  		solution = @operand_left / @operand_right
  	else
  		raise ArgumentError
  	end
  	return format(solution)
  end

  private

  # parse_token utilizes Rational class for evaluation. Raises error with
  # incorrect number of arguments and validates that input is an integer.
  def parse_tokens
  	raise ArgumentError if @tokens.length != 3
  	@operand_left = Rational(*split_token(@tokens[0]))
  	@operator = @tokens[1]
  	@operand_right = Rational(*split_token(@tokens[2]))
  end

  # split_token returns array [numerator, denominator] for splat.
  # Ignores underscores and accepts negative integers.
  def split_token(token)
  	token.split('/').map do |n|
  		n.delete!('_')
  		if n.match(/\A[+-]?\d+\z/)
  			n.to_i
  		else
  			raise ArgumentError
  		end
  	end
  end

  # format reintroduces underscores for printing solution.
  def format(solution)
  	output = solution.numerator.abs.to_s.chars.join('_')
  	unless solution.denominator.abs == 1
  		output += "/#{solution.denominator.to_s.chars.join('_')}"
  	end
  	return solution.negative? ? "-#{output}" : output
  end
end

puts "Input expression. Type 'end' to terminate."
print prompt = '? '
until (input = gets.chomp) == 'end'
	begin
		expression = Expression.new(input)
		puts "= #{expression.evaluate}"
	rescue ZeroDivisionError
		puts 'Error: Attempting to divide by 0.'
	rescue ArgumentError
		puts 'Error: Unexpected input.'
	end
		print prompt
end

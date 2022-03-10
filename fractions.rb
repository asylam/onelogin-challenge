# Expression expects input to be two fractions/integers and a legal operator
# separated by white space. 
# Raises exceptions for unexpected input and zero division errors.
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
		@operand_left = parse_operand(@tokens[0])
		@operator = @tokens[1]
		@operand_right = parse_operand(@tokens[2])
	end

	# parse_operand parses the operand string and returns a Rational sum
	def parse_operand(token)
		numbers = token.split('_')
		numbers.map! do |n|
			if n.include?('/')
				parse_fraction(n)
			elsif is_integer?(n)
				n.to_i
			else
				raise ArgumentError
			end
		end
		numbers.reduce(0, :+)
	end

	# parse_fraction takes a string with a division sign and returns a Rational
	def parse_fraction(input)
		input.split('/').map! do |n|
			if is_integer?(n)
				n.to_i
			else
				raise ArgumentError
			end
		end
		return Rational(*input)
	end

	def is_integer?(input)
		input.match(/\A[+-]?\d+\z/)
	end

	# format reintroduces underscores for printing solution.
	def format(solution)
		if solution.abs < 1
			solution
		else
			output = solution.truncate
			output == solution ? output.to_s : "#{output}_#{(solution - output).abs}"
		end
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

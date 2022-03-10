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
  	end
  	format(solution)
  end

  private

  def parse_tokens
  	@operand_left = Rational(*split_token(@tokens[0]))
  	@operator = @tokens[1]
  	@operand_right = Rational(*split_token(@tokens[2]))
  end

  def split_token(token)
  	token.split('/').map {|n| n.delete('_').to_i}
  end

  def format(solution)
  	print = solution.numerator.abs.to_s.chars.join('_')
  	unless solution.denominator.abs == 1
  		print += "/#{solution.denominator.to_s.chars.join('_')}"
  	end
  	return solution.negative? ? "-#{print}" : print
  end
end

print '? '
input = gets.chomp
until input == 'end'
	expression = Expression.new(input)
	print "= #{expression.evaluate}\n? "
	input = gets.chomp
end

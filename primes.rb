require 'prime'

Maxvalue = 1000000


def consecutive_prime_sum
	primes = generate_prime_numbers(Maxvalue)
	is_prime = flag_prime_numbers primes
	primes_comulative_sum = primes_comulative_sum primes
	get_longest_sequence_of_prime_numbers primes_comulative_sum, is_prime
end


# Use EratosthenesGenerator to get all prime numbers less than 1,000,000  in an array "primes"
def generate_prime_numbers(max_value)
	primes_generator = Prime::EratosthenesGenerator.new
	primes = primes_generator.take_while {|prime| prime < max_value }
end


## Returns a boolean array where the element with prime index is marked true otherwise false
## Use this array to check if a number is prime or not.

def flag_prime_numbers primes
	is_prime = Array.new(Maxvalue + 1, false)
	is_prime[primes[0]] = true
	for i in (1...primes.size)
		is_prime[primes[i]] = true
	end
	return is_prime
end


#Returns the comulative sum of the "primes" array

def primes_comulative_sum primes
	primes_comulative_sum = []
	primes_comulative_sum[0] = primes[0]
	for i in (1...primes.size/2)
		primes_comulative_sum[i] = primes_comulative_sum[i-1] + primes[i]
	end
	primes_comulative_sum
end

#This method takes the comulative sum and the is_prime array and gets the longest sequence of primes thats sums to a prime number

def get_longest_sequence_of_prime_numbers primes_comulative_sum, is_prime
	consecutive_sum = 0
	max_consecutive_elements_length = 0
	for i in 1...primes_comulative_sum.size
		for j in 0...i
			sum_of_primes_between_i_j = j == 0 ? primes_comulative_sum[i] : primes_comulative_sum[i] - primes_comulative_sum[j-1]
			if(is_prime[sum_of_primes_between_i_j])
				number_of_consecutive_elements = i-j + 1
				if number_of_consecutive_elements > max_consecutive_elements_length
					max_consecutive_elements_length = number_of_consecutive_elements
					consecutive_sum = sum_of_primes_between_i_j
				end
			end
		end
	end
	puts "The longest sum of consecutive primes less than #{Maxvalue} is: #{consecutive_sum} "
	puts "The sum contains #{max_consecutive_elements_length} terms" 
end

consecutive_prime_sum











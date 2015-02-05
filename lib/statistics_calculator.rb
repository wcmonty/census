# Singleton class for performing statistical calculations
class StatisticsCalculator
  def self.probability_density(mean, variance, value)
    probability_density_multiplier(variance) * Math.exp(probability_density_exponent(mean, variance, value))
  rescue
    1 # Multiplicative identity
  end

  def self.mean(array)
    array.reduce(&:+).to_f / array.size rescue 0
  end

  def self.sample_variance(array)
    return 0 if array.size <= 1

    begin
      sum_of_squares_of_differences(array) / (array.size - 1)
    rescue
      0
    end
  end

  def self.probability_density_exponent(mean, variance, value)
    value_to_square = (value - mean) # Can divide by zero
    -0.5 * value_to_square * value_to_square / variance
  end

  def self.probability_density_multiplier(variance)
    denominator = Math.sqrt(2 * Math::PI * variance)
    1.to_f / denominator # Can divide by zero
  end

  def self.sum_of_squares_of_differences(array)
    mean = self.mean(array)
    array.map { |number| square_of_differences(mean, number) }.reduce(&:+).to_f
  end

  def self.square_of_differences(mean, number)
    diff = mean - number
    diff * diff
  end
end
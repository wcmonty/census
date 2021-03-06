# Singleton class for performing statistical calculations
class StatisticsCalculator
  def self.probability_density(mean, variance, value)
    exponent = probability_density_exponent(mean, variance, value)
    probability_density_multiplier(variance) * Math.exp(exponent)
  rescue
    1 # Multiplicative identity
  end

  def self.mean(array)
    compacted_array = array.select { |element| element.is_a? Numeric }
    return 0 if compacted_array.empty?
    compacted_array.reduce(&:+).to_f / compacted_array.size
  end

  def self.sample_variance(array)
    compacted_array = array.select { |element| element.is_a? Numeric }
    return 0 if compacted_array.size <= 1

    begin
      sum_of_squares_of_differences(compacted_array) / (compacted_array.size - 1)
    rescue
      0
    end
  end

  private

  def self.probability_density_exponent(mean, variance, value)
    raise ZeroDivisionError if variance == 0
    value_to_square = (value - mean)
    (-0.5 * value_to_square * value_to_square) / variance
  end

  def self.probability_density_multiplier(variance)
    raise ZeroDivisionError if variance == 0
    denominator = Math.sqrt(2 * Math::PI * variance)
    1.0 / denominator
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

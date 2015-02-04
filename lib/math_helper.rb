class MathHelper
  def self.probability_density(mean, variance, value)
    begin
      probability_density_multiplier(variance) * Math.exp(probability_density_exponent(mean, variance, value))
    rescue
      0
    end
  end

  private

  def self.probability_density_exponent(mean, variance, value)
    value_to_square = (value - mean) / variance # Can divide by zero
    -0.5 * value_to_square * value_to_square
  end

  def self.probability_density_multiplier(variance)
    denominator = variance * Math.sqrt(2 * Math::PI)
    1.to_f / denominator # Can divide by zero
  end
end
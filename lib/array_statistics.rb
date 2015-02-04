module ArrayStatistics
  def mean(array)
    array.reduce(&:+).to_f / array.size rescue 0
  end

  def sample_variance(array)
    return 0 if array.size <= 1

    mean = self.mean(array)
    begin
      array.map { |number| diff = mean - number; diff * diff }
          .reduce(&:+).to_f / (array.size - 1)
    rescue
      0
    end
  end
end
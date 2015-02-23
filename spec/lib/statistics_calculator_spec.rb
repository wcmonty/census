# Require the specific file so that the load time
# is less
require_relative '../../lib/statistics_calculator'

describe StatisticsCalculator do
  describe '.probability_density' do
    it 'calculates the probability density' do
      # Expectations taken from http://en.wikipedia.org/wiki/Naive_Bayes_classifier
      mean = 5.855
      sigma_squared = 0.035033
      value = 6
      expect(StatisticsCalculator.probability_density(mean, sigma_squared, value)).to be_between(1.5788, 1.5789)
    end
  end

  describe '.mean' do
    it 'calculates the mean' do
      data = [1, 2, 3, 4]
      expect(StatisticsCalculator.mean(data)).to eq 2.5
    end

    it 'returns float' do
      data = [90, 94, 53, 68, 79, 84, 87, 72, 70, 69, 65, 89, 85, 83, 72]
      expect(StatisticsCalculator.mean(data)).to be_between(77.3333, 77.3334)
    end

    it 'returns 0 when there are no elements' do
      data = []
      expect(StatisticsCalculator.mean(data)).to eq 0
    end

    it 'ignores elements that are nil' do
      data = [nil, 1, nil, 2, nil, 3, nil, 4, nil]
      expect(StatisticsCalculator.mean(data)).to eq 2.5
    end

    it 'ignores non numerical elements' do
      data = [1, '2', 2, 3, 4, 'a', :foo]
      expect(StatisticsCalculator.mean(data)).to eq 2.5
    end
  end

  describe '.sample_variance' do
    it 'calculates the sample variance' do
      data = [1, 2, 3, 4]
      expect(StatisticsCalculator.sample_variance(data)).to be_between(1.6666, 1.6667)
    end

    it 'returns 0 when there are no elements' do
      data = []
      expect(StatisticsCalculator.sample_variance(data)).to eq 0
    end

    it 'returns 0 when there is 1 element' do
      data = [1]
      expect(StatisticsCalculator.sample_variance(data)).to eq 0
    end

    it 'ignores elements that are nil' do
      data = [nil, 1, nil, 2, nil, 3, nil, 4, nil]
      expect(StatisticsCalculator.sample_variance(data)).to be_between(1.6666, 1.6667)
    end

    it 'ignores non numerical elements' do
      data = [1, '2', 2, 3, 4, 'a', :foo]
      expect(StatisticsCalculator.sample_variance(data)).to be_between(1.6666, 1.6667)
    end
  end
end
# Require the specific file so that the load time
# is less
# require_relative '../../lib/statistics_calculator'
require 'rails_helper'

describe StatisticsCalculator do
  let(:sc) { StatisticsCalculator }

  describe '.probability_density' do
    it 'calculates the probability density' do
      # Expectations taken from http://en.wikipedia.org/wiki/Naive_Bayes_classifier
      mean = 5.855
      sigma_squared = 0.035033
      value = 6
      expect(sc.probability_density(mean, sigma_squared, value)).to be_between(1.5788, 1.5789)
    end

    it 'does not handle floating points very well' do
      # Expectations taken from http://en.wikipedia.org/wiki/Naive_Bayes_classifier
      # TODO This should probably handle floating points better.  BigDecimal is a potential solution.
      mean = 176.25
      sigma_squared = 0.012292
      value = 130
      expect(sc.probability_density(mean, sigma_squared, value)).to eq 0.0 # 5.9881e-6
    end

    it 'returns 1 when the answer cannot be calculated' do
      values = [5.85, 0, 6]
      expect(sc.probability_density(5.855, 0, 6)).to eq 1
    end
  end

  describe '.mean' do
    it 'calculates the mean' do
      data = [1, 2, 3, 4]
      expect(sc.mean(data)).to eq 2.5
    end

    it 'returns float' do
      data = [90, 94, 53, 68, 79, 84, 87, 72, 70, 69, 65, 89, 85, 83, 72]
      expect(sc.mean(data)).to be_between(77.3333, 77.3334)
    end

    it 'returns 0 when there are no elements' do
      data = []
      expect(sc.mean(data)).to eq 0
    end

    it 'ignores elements that are nil' do
      data = [nil, 1, nil, 2, nil, 3, nil, 4, nil]
      expect(sc.mean(data)).to eq 2.5
    end

    it 'ignores non numerical elements' do
      data = [1, '2', 2, 3, 4, 'a', :foo]
      expect(sc.mean(data)).to eq 2.5
    end
  end

  describe '.sample_variance' do
    it 'calculates the sample variance' do
      data = [1, 2, 3, 4]
      expect(sc.sample_variance(data)).to be_between(1.6666, 1.6667)
    end

    it 'returns 0 when there are no elements' do
      data = []
      expect(sc.sample_variance(data)).to eq 0
    end

    it 'returns 0 when there is 1 element' do
      data = [1]
      expect(sc.sample_variance(data)).to eq 0
    end

    it 'ignores elements that are nil' do
      data = [nil, 1, nil, 2, nil, 3, nil, 4, nil]
      expect(sc.sample_variance(data)).to be_between(1.6666, 1.6667)
    end

    it 'ignores non numerical elements' do
      data = [1, '2', 2, 3, 4, 'a', :foo]
      expect(sc.sample_variance(data)).to be_between(1.6666, 1.6667)
    end
  end
end
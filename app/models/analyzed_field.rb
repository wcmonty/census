class AnalyzedField < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :classification
  has_many :statistics, dependent: :destroy

  def mean
    @mean ||= find_statistics_by('mean')
  end

  def variance
    @variance ||= find_statistics_by('variance')
  end

  def probability_density(target)
    value = target.send(name)
    Census::Statistics.probability_density(mean, variance, value)
  end

  private

  def find_statistics_by(name)
    statistics.find {|statistic| statistic.name == name}.value rescue 0
  end
end

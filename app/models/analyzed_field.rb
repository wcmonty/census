class AnalyzedField < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :classification
  has_many :statistics, dependent: :destroy

  def mean
    @mean ||= statistics.find {|statistic| statistic.name == 'mean'}.value rescue 0
  end

  def variance
    @variance ||= statistics.find {|statistic| statistic.name == 'variance'}.value rescue 0
  end

  def probability_density(target)
    value = target.send(name)
    MathHelper.probability_density(mean, variance, value)
  end
end

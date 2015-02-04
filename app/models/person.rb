# A person that is either used for seed data or to be classified against the seed data
class Person < ActiveRecord::Base
  validates :gender, inclusion: { in: %w(male female) }
  validates :height, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, numericality: { only_integer: true, greater_than: 0 }

  # Triggering after every save, update, and destroy for this demo.
  # In a real production environment, we would probably want to
  # generate the statistics periodically, especially if there are a
  # number of changes.
  after_save :generate_statistics
  after_update :generate_statistics
  after_destroy :generate_statistics

  def categories
    @categories ||= BayesianClassifier.new(self).run
  end

  private

  def generate_statistics
    StatisticsGenerator.new(Person).run
  end
end

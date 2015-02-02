class Statistic < ActiveRecord::Base
  belongs_to :analyzed_field

  scope :mean, -> { where name: 'mean' }
  scope :variance, -> { where name: 'variance'}
end

# Container for all fields that a Model might have
class ClassifiedModel < ActiveRecord::Base
  validates :name, presence: true

  has_many :classified_fields, dependent: :destroy
end

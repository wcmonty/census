class ClassifiedModel < ActiveRecord::Base
  validates :name, presence: true

  has_many :classified_fields, dependent: :destroy
end

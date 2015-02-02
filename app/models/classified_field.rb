class ClassifiedField < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :classified_model
  has_many :classifications, dependent: :destroy
end

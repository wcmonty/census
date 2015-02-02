class Classification < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :classified_field
  has_many :analyzed_fields, dependent: :destroy
end

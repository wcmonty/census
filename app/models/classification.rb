class Classification < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :classified_field
  has_many :analyzed_fields, dependent: :destroy

  def posterior_numerator(target)
    @posterior_numerator ||= probability *
        analyzed_fields.map { |field| target ? field.probability_density(target) : 1 }.reduce(&:*)
  end
end

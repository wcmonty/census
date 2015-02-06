# Service class that classifies a subject using statistical analysis
# See http://en.wikipedia.org/wiki/Naive_Bayes_classifier
class BayesianClassifier
  attr_reader :klass, :target

  def initialize(target)
    @target = target
  end

  def run
    guesses = []

    fields_to_classify.each do |field_to_classify|
      max = field_to_classify.classifications.max do |a, b|
        a.posterior_numerator(target) <=> b.posterior_numerator(target)
      end

      guesses << max.name if max
    end

    guesses
  end

  private

  def model
    @model ||= ClassifiedModel.where(name: target.class.name)
               .includes(classified_fields: { classifications: { analyzed_fields: :statistics } })
               .first
  end

  def fields_to_classify
    @fields_to_classify ||= model.classified_fields.select { |field| nil_fields.include?(field.name) }
  end

  def nil_fields
    @nil_fields ||= target.attributes.select { |attribute| target.send(attribute).nil? }.keys
  end
end

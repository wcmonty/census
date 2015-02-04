# Generates statistics for a given class
class StatisticsGenerator
  attr_reader :klass

  def initialize(klass)
    @klass = klass
  end

  def run
    model = ClassifiedModel.find_or_create_by(name: klass)
    model.classified_fields.destroy_all

    fields_to_classify.each do |field_to_classify|
      analyze_classifications(model, field_to_classify)
    end
  end

  private

  def analyze_classifications(model, field_to_classify)
    field = ClassifiedField.create(name: field_to_classify, classified_model_id: model.id)

    current_values_in(field_to_classify).each do |classification|
      number_of_these_records = klass.where(field_to_classify => classification).count
      classification = create_classification(classification, field, number_of_these_records)

      analyze_fields(field_to_classify, classification)
    end
  end

  def create_classification(classification, field, number_of_records)
    probability =  number_of_records.to_f / klass.count
    classification = Classification.create(name: classification,
                                           classified_field_id: field.id,
                                           probability: probability)
  end

  def analyze_fields(field_to_classify, classification)
    fields_to_analyze.each do |field_to_analyze|
      analyzed_field = AnalyzedField.create(name: field_to_analyze,
                                            classification_id: classification.id)

      data = klass.where(field_to_classify => classification.name).pluck(field_to_analyze)
      generate_mean(analyzed_field, data)
      generate_variance(analyzed_field, data)
    end
  end

  def generate_mean(analyzed_field, data)
    Statistic.create(analyzed_field_id: analyzed_field.id, name: 'mean', value: Census::Statistics.mean(data))
  end

  def generate_variance(analyzed_field, data)
    Statistic.create(analyzed_field_id: analyzed_field.id, name: 'variance', value: Census::Statistics.sample_variance(data))
  end

  # We would probably want to allow explicit setting of fields to classify
  # Right now, we use any string field as a potential classifier
  # This would obviously break on a field such as address
  def fields_to_classify
    columns = klass.columns_hash
    columns.select { |key| columns[key].type == :string }.keys
  end

  # We would probably want to allow explicit setting of fields to analyze
  # Additionally, an integer could potentially have an enumeration that would
  # be a category.
  def fields_to_analyze
    columns = klass.columns_hash
    columns.select { |key| columns[key].type == :integer || columns[key].type == :float }
      .reject { |key| key == 'id' }.keys
  end

  def current_values_in(field)
    klass.all.pluck(field.to_sym).uniq
  end
end

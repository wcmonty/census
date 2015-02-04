# Controller for statistics
class StatisticsController < ApplicationController
  def index
    @classified_models = ClassifiedModel.all
                         .includes(classified_fields: { classifications: { analyzed_fields: :statistics } })
  end
end

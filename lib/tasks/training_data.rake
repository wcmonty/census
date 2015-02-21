require_relative '../file_opener'

namespace :training_data do
  desc 'Import records by reading JSON files from the command-line.'
  task :import, [:file] do |_task, args|
    FileOpener.new(args[:file]).run
  end

end
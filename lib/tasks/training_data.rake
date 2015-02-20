namespace :training_data do
  desc 'Import records by reading JSON files from the command-line.'
  task :import, [:file] do |_task, args|
    puts args[:file]
  end

end
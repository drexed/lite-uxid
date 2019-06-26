# frozen_string_literal: true

require 'bundler/setup'
require 'lite/uxid'
require 'active_record'
require 'database_cleaner'
require 'generator_spec'
require 'pathname'

spec_file_path = File.dirname(__FILE__)
spec_sprt_path = Pathname.new(File.expand_path('../spec/support', spec_file_path))
spec_temp_path = Pathname.new(File.expand_path('../spec/generators/lite/tmp', spec_file_path))

ActiveRecord::Base.configurations = YAML.load_file(spec_sprt_path.join('config/database.yml'))
ActiveRecord::Base.establish_connection(:test)
ActiveRecord::Base.time_zone_aware_attributes = true
ActiveRecord::Migration.verbose = false

load(spec_sprt_path.join('db/schema.rb'))

Dir.glob(spec_sprt_path.join('models/*.rb'))
   .each { |f| autoload(File.basename(f).chomp('.rb').camelcase.intern, f) }
   .each { |f| require(f) }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before { DatabaseCleaner.start }
  config.after { DatabaseCleaner.clean }

  config.after(:all) { FileUtils.remove_dir(spec_temp_path) if File.directory?(spec_temp_path) }
end

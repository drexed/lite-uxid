# frozen_string_literal: true

require 'bundler/setup'
require 'lite/uxid'
require 'active_record'
require 'database_cleaner'
require 'generator_spec'
require 'pathname'

spec_file_dir = File.dirname(__FILE__)
spec_support_path = Pathname.new(File.expand_path('../spec/support', spec_file_dir))
spec_tmp_path = Pathname.new(File.expand_path('../spec/generators/lite/tmp', spec_file_dir))

ActiveRecord::Base.configurations = YAML.load_file(spec_support_path.join('config/database.yml'))
ActiveRecord::Base.establish_connection(:test)

load(spec_support_path.join('db/schema.rb'))

Dir.glob(spec_support_path.join('models/*.rb'))
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

  config.after(:all) { FileUtils.remove_dir(spec_tmp_path) if File.directory?(spec_tmp_path) }
end

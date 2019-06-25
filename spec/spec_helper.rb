# frozen_string_literal: true

require 'bundler/setup'
require 'lite/uxid'

%w[active_record database_cleaner generator_spec pathname].each do |name|
  require name
end

spec_support_path = Pathname.new(File.expand_path('../spec/support', File.dirname(__FILE__)))
spec_tmp_path = Pathname.new(File.expand_path('../spec/generators/tmp', File.dirname(__FILE__)))

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

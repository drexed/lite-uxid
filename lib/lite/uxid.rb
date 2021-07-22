# frozen_string_literal: true

require 'generators/lite/uxid/install_generator' if defined?(Rails::Generators)

%w[version configuration base].each do |name|
  require "lite/uxid/#{name}"
end

%w[hashid nanoid ulid].each do |name|
  require "lite/uxid/record/#{name}"
  require "lite/uxid/#{name}"
end

# frozen_string_literal: true

%w[version configuration base].each do |name|
  require "lite/uxid/#{name}"
end

%w[hash nanoid ulid].each do |name|
  require "lite/uxid/record/#{name}"
  require "lite/uxid/#{name}"
end

require 'generators/lite/uxid/install_generator'

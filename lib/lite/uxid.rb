# frozen_string_literal: true

require "generators/lite/uxid/install_generator" if defined?(Rails::Generators)

require "lite/uxid/version"
require "lite/uxid/configuration"
require "lite/uxid/base/irreversible"
require "lite/uxid/base/reversible"
require "lite/uxid/record/hashid"
require "lite/uxid/record/nanoid"
require "lite/uxid/record/ulid"
require "lite/uxid/record/uuid"
require "lite/uxid/hashid"
require "lite/uxid/nanoid"
require "lite/uxid/ulid"
require "lite/uxid/uuid"

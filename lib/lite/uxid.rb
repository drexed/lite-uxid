# frozen_string_literal: true

require "securerandom" unless defined?(SecureRandom)
require "generators/lite/uxid/install_generator" if defined?(Rails::Generators)

require "lite/uxid/version"
require "lite/uxid/configuration"
require "lite/uxid/base"
require "lite/uxid/irreversible/base"
require "lite/uxid/irreversible/nanoid"
require "lite/uxid/irreversible/ulid"
require "lite/uxid/irreversible/uuid"
require "lite/uxid/reversible/base"
require "lite/uxid/reversible/hashid"
require "lite/uxid/reversible/scatterid"
require "lite/uxid/record/hashid"
require "lite/uxid/record/nanoid"
require "lite/uxid/record/scatterid"
require "lite/uxid/record/ulid"
require "lite/uxid/record/uuid"

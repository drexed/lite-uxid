# frozen_string_literal: true

require "active_support" unless defined?(ActiveSupport)

module Lite
  module Uxid
    module Record
      module Nanoid

        extend ActiveSupport::Concern

        included do
          before_create :callback_generate_uxid!, if: proc { respond_to?(:uxid) && !uxid? }
        end

        def uxid_prefix
          nil
        end

        private

        def callback_generate_uxid!
          random_nanoid = nil

          loop do
            random_nanoid = Lite::Uxid::Nanoid.encode(prefix: uxid_prefix)
            break unless self.class.exists?(uxid: random_nanoid)
          end

          self.uxid = random_nanoid
        end

      end
    end
  end
end

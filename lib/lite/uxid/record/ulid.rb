# frozen_string_literal: true

require "active_support" unless defined?(ActiveSupport)

module Lite
  module Uxid
    module Record
      module Ulid

        extend ActiveSupport::Concern

        included do
          before_create :callback_generate_uxid!,
            if: proc { respond_to?(:uxid) && !uxid? }
        end

        private

        def callback_generate_uxid!
          self.uxid = Lite::Uxid::Ulid.encode
        end

      end
    end
  end
end

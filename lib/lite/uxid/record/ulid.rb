# frozen_string_literal: true

module Lite
  module Uxid
    module Record
      module Ulid

        def self.included(base)
          base.class_eval do
            before_create :callback_generate_uxid!,
                          if: proc { respond_to?(:uxid) && !uxid? }
          end
        end

        private

        def callback_generate_uxid!
          self.uxid = Lite::Uxid::Irreversible::Ulid.encode
        end

      end
    end
  end
end

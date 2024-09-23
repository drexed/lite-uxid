# frozen_string_literal: true

module Lite
  module Uxid
    module Record
      module Nanoid

        def self.included(base)
          base.class_eval do
            before_create :callback_generate_uxid!,
                          if: proc { respond_to?(:uxid) && !uxid? }
          end
        end

        def uxid_prefix
          nil
        end

        private

        def callback_generate_uxid!
          random_nanoid = nil

          loop do
            random_nanoid = Lite::Uxid::Irreversible::Nanoid.encode(prefix: uxid_prefix)
            break unless self.class.exists?(uxid: random_nanoid)
          end

          self.uxid = random_nanoid
        end

      end
    end
  end
end

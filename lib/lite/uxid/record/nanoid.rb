# frozen_string_literal: true

require 'active_support' unless defined?(ActiveSupport)

module Lite
  module Uxid
    module Record
      module Nanoid

        extend ActiveSupport::Concern

        included do
          before_create :callback_generate_uxid!, if: proc { respond_to?(:uxid) }
        end

        class_methods do
          def find_by_uxid(uxid)
            find_by(uxid: uxid)
          end

          def find_by_uxid!(uxid)
            record = find_by_uxid(uxid)
            return record unless record.nil?

            raise ActiveRecord::RecordNotFound
          end
        end

        private

        def callback_generate_uxid!
          random_nanoid = nil

          loop do
            random_nanoid = Lite::Uxid::Nanoid.encode
            break unless self.class.exists?(uxid: random_nanoid)
          end

          self.uxid = random_nanoid
        end

      end
    end
  end
end

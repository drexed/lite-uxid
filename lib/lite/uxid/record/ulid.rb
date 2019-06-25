# frozen_string_literal: true

require 'active_record'
require 'active_support'

module Lite
  module Uxid
    module Record
      module Ulid
        extend ActiveSupport::Concern

        included do
          before_create :callback_generate_uxid!, if: proc { respond_to?(:uxid) }

          def self.find_by_uxid(uxid)
            find_by(uxid: uxid)
          end

          def self.find_by_uxid!(uxid)
            record = find_by_uxid(uxid)
            return record unless record.nil?

            raise ActiveRecord::RecordNotFound
          end
        end

        private

        def callback_generate_uxid!
          self.uxid = Lite::Uxid::Ulid.encode
        end

      end
    end
  end
end

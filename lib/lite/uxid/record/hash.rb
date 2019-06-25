# frozen_string_literal: true

require 'active_record'
require 'active_support'

module Lite
  module Uxid
    module Record
      module Hash

        extend ActiveSupport::Concern

        included do
          after_create :callback_generate_uxid!, if: proc { respond_to?(:uxid) }

          def self.find_by_uxid(uxid)
            decoded_id = Lite::Uxid::Hash.decode(uxid)
            find_by(id: decoded_id)
          end

          def self.find_by_uxid!(uxid)
            record = find_by_uxid(uxid)
            return record unless record.nil?

            raise ActiveRecord::RecordNotFound
          end
        end

        def uxid_to_id
          return unless respond_to?(:uxid)

          Lite::Uxid::Hash.decode(uxid)
        end

        private

        def callback_generate_uxid!
          hash = Lite::Uxid::Hash.encode(id)
          update_column(:uxid, hash)
        end

      end
    end
  end
end

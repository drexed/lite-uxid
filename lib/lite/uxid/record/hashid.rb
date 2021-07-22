# frozen_string_literal: true

require 'active_support' unless defined?(ActiveSupport)

module Lite
  module Uxid
    module Record
      module Hashid

        extend ActiveSupport::Concern

        included do
          after_create :callback_generate_uxid!, if: proc { respond_to?(:uxid) }
        end

        class_methods do
          def find_by_uxid(uxid)
            decoded_id = Lite::Uxid::Hashid.decode(uxid)
            find_by(id: decoded_id)
          end

          def find_by_uxid!(uxid)
            record = find_by_uxid(uxid)
            return record unless record.nil?

            raise ActiveRecord::RecordNotFound
          end
        end

        def uxid_to_id
          return unless respond_to?(:uxid)

          Lite::Uxid::Hashid.decode(uxid)
        end

        private

        def callback_generate_uxid!
          hash = Lite::Uxid::Hashid.encode(id)
          update_column(:uxid, hash)
        end

      end
    end
  end
end

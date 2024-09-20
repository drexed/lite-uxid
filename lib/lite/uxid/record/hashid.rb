# frozen_string_literal: true

require "active_support" unless defined?(ActiveSupport)

module Lite
  module Uxid
    module Record
      module Hashid

        extend ActiveSupport::Concern

        included do
          after_commit :callback_generate_uxid!,
                       if: proc { respond_to?(:uxid) && !uxid? },
                       on: :create
        end

        class_methods do
          def find_by_uxid(uxid)
            decoded_id = Lite::Uxid::Hashid.decode(uxid, prefix: new.uxid_prefix)
            find_by(id: decoded_id)
          end

          def find_by_uxid!(uxid)
            record = find_by_uxid(uxid)
            return record unless record.nil?

            raise ActiveRecord::RecordNotFound
          end
        end

        def id_to_uxid
          return unless respond_to?(:uxid)

          Lite::Uxid::Hashid.encode(id, prefix: uxid_prefix)
        end

        def uxid_to_id
          return unless respond_to?(:uxid)

          Lite::Uxid::Hashid.decode(uxid, prefix: uxid_prefix)
        end

        def uxid_prefix
          nil
        end

        private

        def callback_generate_uxid!
          update_column(:uxid, id_to_uxid)
        end

      end
    end
  end
end

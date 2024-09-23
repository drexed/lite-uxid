# frozen_string_literal: true

module Lite
  module Uxid
    module Record
      module Obfuscateid

        def self.included(base)
          base.extend ClassMethods
          base.class_eval do
            after_commit :callback_generate_uxid!,
                         if: proc { respond_to?(:uxid) && !uxid? },
                         on: :create
          end
        end

        module ClassMethods

          def find_by_uxid(uxid)
            decoded_id = Lite::Uxid::Reversible::Obfuscateid.decode(uxid)
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

          Lite::Uxid::Reversible::Obfuscateid.encode(id)
        end

        def uxid_to_id
          return unless respond_to?(:uxid)

          Lite::Uxid::Reversible::Obfuscateid.decode(uxid)
        end

        private

        def callback_generate_uxid!
          update_column(:uxid, id_to_uxid)
        end

      end
    end
  end
end

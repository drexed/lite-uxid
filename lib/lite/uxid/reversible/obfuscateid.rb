# frozen_string_literal: true

module Lite
  module Uxid
    module Reversible
      class Obfuscateid < Base

        def encode
          swap
          scatter

          "#{coder_prefix}#{joined_array}"
        end

        def decode
          @id = id.delete_prefix(coder_prefix.to_s)

          unscatter
          unswap
          joined_array.to_i
        end

        private

        def zero_padded_id
          @zero_padded_id ||= id.to_s.rjust(10, "0")
        end

        def coder_array
          @coder_array ||= zero_padded_id.chars.collect(&:to_i)
        end

        def joined_array
          coder_array.join
        end

        def swapper_map(index)
          array = (0..9).to_a
          Array.new(10) { |i| array.rotate!((index + i) ^ coder_spin).pop }
        end

        def swap
          coder_array.map!.with_index { |digit, i| swapper_map(i)[digit] }
        end

        def unswap
          coder_array.map!.with_index { |digit, i| swapper_map(i).rindex(digit) }
        end

        def scatter
          sum_of_digits = coder_array.sum.to_i
          @coder_array = Array.new(10) { coder_array.rotate!(coder_spin ^ sum_of_digits).pop }
        end

        def unscatter
          scattered_array = coder_array
          sum_of_digits = scattered_array.sum.to_i
          @coder_array = []

          coder_array.tap do |unscatter|
            10.times do
              unscatter.push(scattered_array.pop)
              unscatter.rotate!((sum_of_digits ^ coder_spin) * -1)
            end
          end
        end

      end
    end
  end
end

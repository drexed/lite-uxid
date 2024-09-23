# frozen_string_literal: true

module Lite
  module Uxid
    module Reversible
      class Scatterid < Base

        def encode
          "#{coder_prefix}#{hash}"
        end

        def decode
          @id = id.delete_prefix(coder_prefix.to_s)
          reverse_hash.to_i
        end

        private

        def zero_padded_id
          @zero_padded_id ||= id.to_s.rjust(10, "0")
        end

        # def coder_array
        #   @coder_array ||= zero_padded_id.chars.collect(&:to_i)
        # end

        ###

        def hash
          swap
          scatter
          completed_string
        end

        def reverse_hash
          unscatter
          unswap
          completed_string
        end

        def completed_string
          @working_array.join
        end

        def swapper_map(index)
          array = (0..9).to_a
          Array.new(10) { |i| array.rotate!((index + i) ^ coder_spin).pop }
        end

        def swap
          @working_array = zero_padded_id.chars.collect(&:to_i)
          @working_array = @working_array.map.with_index do |digit, index|
            swapper_map(index)[digit]
          end
        end

        # Reverse swap
        def unswap
          @working_array = @working_array.collect.with_index do |digit, index|
            swapper_map(index).rindex(digit)
          end
        end

        def scatter
          sum_of_digits = @working_array.sum.to_i
          @working_array = Array.new(10) do
            @working_array.rotate!(coder_spin ^ sum_of_digits).pop
          end
        end

        def unscatter
          scattered_array = zero_padded_id.chars.collect(&:to_i)
          sum_of_digits = scattered_array.inject(:+).to_i
          @working_array = []
          @working_array.tap do |unscatter|
            10.times do
              unscatter.push scattered_array.pop
              unscatter.rotate! (sum_of_digits ^ coder_spin) * -1
            end
          end
        end

      end
    end
  end
end

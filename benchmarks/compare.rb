# frozen_string_literal: true

%w[lib benchmarks].each { |name| $LOAD_PATH.unshift(name) }

require 'benchmark/ips'
require 'lite/uxid'

Benchmark.ips do |x|
  x.report('Hashid') do
    Lite::Uxid::Hashid.encode(rand(1..1_000_000))
  end

  x.report('NanoID') do
    Lite::Uxid::Nanoid.encode
  end

  x.report('ULID') do
    Lite::Uxid::Ulid.encode
  end

  x.compare!
end

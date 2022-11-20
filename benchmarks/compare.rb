# frozen_string_literal: true

%w[lib benchmarks].each { |name| $LOAD_PATH.unshift(name) }

require "benchmark/ips"
require "lite/uxid"

Benchmark.ips do |x|
  x.report("Hashid") do
    id = rand(1..1_000_000)
    Lite::Uxid::Hashid.encode(id)
  end

  x.report("NanoID") do
    _id = rand(1..1_000_000) # To simulate the extra work from `rand`
    Lite::Uxid::Nanoid.encode
  end

  x.report("ULID") do
    _id = rand(1..1_000_000) # To simulate the extra work from `rand`
    Lite::Uxid::Ulid.encode
  end

  x.report("UUID") do
    _id = rand(1..1_000_000) # To simulate the extra work from `rand`
    Lite::Uxid::Uuid.encode
  end

  x.compare!
end

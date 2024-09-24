# frozen_string_literal: true

%w[lib benchmarks].each { |name| $LOAD_PATH.unshift(name) }

require "benchmark/ips"
require "lite/uxid"

Benchmark.ips do |x|
  x.report("HashID") do
    id = rand(1..1_000_000)
    Lite::Uxid::Reversible::Hashid.encode(id)
  end

  x.report("ObfuscateID") do
    id = rand(1..1_000_000)
    Lite::Uxid::Reversible::Obfuscateid.encode(id)
  end

  # The irreversible examples include `rand` simulate
  # the extra work just like reversible examples.

  x.report("NanoID") do
    _id = rand(1..1_000_000)
    Lite::Uxid::Irreversible::Nanoid.encode
  end

  x.report("ULID") do
    _id = rand(1..1_000_000)
    Lite::Uxid::Irreversible::Ulid.encode
  end

  x.report("UUID v4") do
    _id = rand(1..1_000_000)
    Lite::Uxid::Irreversible::Uuid.encode
  end

  x.report("UUID v7") do
    _id = rand(1..1_000_000)
    Lite::Uxid::Irreversible::Uuid.encode(version: 7)
  end

  x.compare!
end

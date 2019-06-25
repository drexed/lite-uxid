# frozen_string_literal: true

RSpec.describe Lite::Uxid do

  it 'to be a version number' do
    expect(Lite::Uxid::VERSION).not_to be nil
  end

end

# frozen_string_literal: true

Lite::Uxid.configure do |config|
  config.encoding_chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.encoding_length = 26
  config.encoding_salt = 1_369_136
end

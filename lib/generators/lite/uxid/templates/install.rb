# frozen_string_literal: true

Lite::Uxid.configure do |config|
  config.encoding_chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.encoding_salt = 1_369_136
  config.hashid_length = 12
  config.nanoid_length = 21
  config.ulid_length = 26
end

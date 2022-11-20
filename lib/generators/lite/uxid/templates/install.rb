# frozen_string_literal: true

Lite::Uxid.configure do |config|
  config.hashid_charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.hashid_salt = 1_369_136
  config.hashid_size = 16
  config.nanoid_charset = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.nanoid_size = 21
  config.ulid_charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.ulid_size = 26
end

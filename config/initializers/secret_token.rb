# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# Friends::Application.config.secret_key_base = '767df2e84045a3bc64e7d94f151a0dc9909be122fa7f2e2a785dc4b21cfe93e237b1d8b0d122f88cc13dd5e322783b2130d4be13ae0433c7759bd2fa2ba9e875'
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Friends::Application.config.secret_key_base = secure_token


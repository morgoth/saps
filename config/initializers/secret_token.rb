# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Saps::Application.config.secret_token = ENV["SECRET_TOKEN"] || "370064c7496626c582fd0f67d4918a45"

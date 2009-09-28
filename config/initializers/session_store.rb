# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_trove_session',
  :secret      => '3a6c132ab73bc3909b18a0ef5cfbee52f79e1bdbf534975039bfe8a27199b2e6099852ea77ee3c768533d05e852eb78198568ac450b46bc19ea897f20efd7f36'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

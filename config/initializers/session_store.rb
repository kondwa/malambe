# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_malambe_session',
  :secret      => 'bea0908e870f24259dcf9427a958f66b9e9e361e46724bd79c5f070e6ec475e1c1502863b841440c175b64c0ace1a8ee62857ee15eb1e972fd8e9d29c08a5c2b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_calculator_session',
  :secret      => 'a8c53bf6d82de5f5c4daf04c7b283cc422323e796b7e77d02e87f0c6a86cc8c213acdda9273a2f056e02a14082dcdb247281b2c849cd0cc895254c5700903b64'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

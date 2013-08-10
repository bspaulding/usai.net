# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_usainet_rails_session',
  :secret      => 'cb2a26cfeb83c13fa7ee966f8685fe35b9274795912a2ee5e6ecc2954b2a8125da429945248e1341a118189d40367d4cfbb5dba27254765d299a3991b8d5ed60'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

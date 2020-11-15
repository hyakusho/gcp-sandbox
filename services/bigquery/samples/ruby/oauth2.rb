require 'googleauth'
require 'googleauth/stores/file_token_store'

CREDENTIALS_DIR="../../../../credentials"
OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'

scope = 'https://www.googleapis.com/auth/bigquery'

client_id = Google::Auth::ClientId.from_file("#{CREDENTIALS_DIR}/client_secret.json")
token_store = Google::Auth::Stores::FileTokenStore.new(file: "#{CREDENTIALS_DIR}/tokens.yaml")
authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)

user_id = 'hyakushoio@gmail.com'
credentials = authorizer.get_credentials(user_id)
if credentials.nil?
  url = authorizer.get_authorization_url(base_url: OOB_URI)
  puts "Open #{url} in your browser and enter the resulting code:"
  code = gets
  credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
end

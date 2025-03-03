import Config
require Logger

config :livebook, LivebookWeb.Endpoint,
  secret_key_base:
    Livebook.Config.secret!("LIVEBOOK_SECRET_KEY_BASE") ||
      Base.encode64(:crypto.strong_rand_bytes(48))

if password = Livebook.Config.password!("LIVEBOOK_PASSWORD") do
  config :livebook, authentication_mode: :password, password: password
else
  config :livebook, token: Livebook.Utils.random_id()
end

if port = Livebook.Config.port!("LIVEBOOK_PORT") do
  config :livebook, LivebookWeb.Endpoint, http: [port: port]
end

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ffx, FfxWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :xarango, :db,
  server: "http://192.168.99.100:8529",
  database: "ffx_test",
  username: System.get_env("ARANGO_USER"),
  password: System.get_env("ARANGO_PASSWORD")

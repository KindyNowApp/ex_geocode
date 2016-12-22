use Mix.Config

config :ex_geocode
  api_key: System.get_env("GOOGLE_MAPS_GEOCODE_API_KEY")

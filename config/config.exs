use Mix.Config

config :ex_geocode,
  api_host: "https://maps.googleapis.com/maps/api/geocode"

import_config "#{Mix.env}.exs"

defmodule ExGeocode.Config do
  @moduledoc """
  """

  def api_host, do: Application.get_env(:ex_geocode, :api_host)

  def base_url, do: api_host <> "/maps/api/geocode/json"

  def api_key, do: System.get_env("GOOGLE_MAPS_GEOCODE_API_KEY")
end

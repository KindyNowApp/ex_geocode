defmodule ExGeocode.Config do

  @moduledoc """
  Config required for geocoding.
  """

  @doc """
  The API host, which defaults to https://maps.googleapis.com
  """
  def api_host, do: Application.get_env(:ex_geocode, :api_host, "https://maps.googleapis.com")

  @doc """
  The base URL for requests which defaults to /maps/api/geocode/json
  """
  def base_url do
    api_host <> Application.get_env(:ex_geocode, :base_url, "/maps/api/geocode/json")
  end

  @doc """
  Your Google Maps API key, which we recommend you store in an environment variable.
  """
  def api_key, do: System.get_env("GOOGLE_MAPS_GEOCODE_API_KEY")

end

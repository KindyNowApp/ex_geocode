defmodule ExGeocode.Config do
  @moduledoc """
  """

  def api_key, do: System.get_env("GOOGLE_MAPS_GEOCODE_API_KEY")
end

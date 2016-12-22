defmodule ExGeocode.ComponentFilters do

  @moduledoc """
  Component filters based off the Geocoding Component Filtering spec
  which can be found here: https://developers.google.com/maps/documentation/geocoding/intro#ComponentFiltering
  """
  alias __MODULE__

  defstruct route: nil,
    locality: nil,
    administrative_area: nil,
    postal_code: nil,
    country: nil

  @type t :: %__MODULE__{}

  @doc ~S"""
  Serialize a component filters struct into a string,

  ### Examples

      iex> filters = %ComponentFilters{route: "Test Street", country: "AU"}
      ...> ExGeocode.ComponentFilters.serialize(filters)
      "country:AU|route:Test Street"
  """
  @spec serialize(ComponentFilters.t) :: String.t
  def serialize(%ComponentFilters{} = filters) do
    filters
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end) # remove nil values
    |> serialize_filters
    |> Enum.join("|")
  end

  @spec serialize_filters(map) :: Enumerable.t
  defp serialize_filters(filters) do
    for {k,v} <- filters, do: Atom.to_string(k) <> ":" <> v
  end

end

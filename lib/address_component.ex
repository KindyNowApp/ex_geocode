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


  @doc """
  Serialize component filters into a string,
  e.g. `postal_code:1234|country:AU`
  """
  def serialize(%ComponentFilters{} = filters) do
    filters
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end) # remove nil values
    |> serialize_filters
    |> Enum.join("|")
  end

  def serialize_filters(filters) do
    for {k,v} <- filters, do: Atom.to_string(k) <> ":" <> v
  end
end

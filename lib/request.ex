defmodule ExGeocode.Request do
  @moduledoc """
  """

  alias __MODULE__
  alias ExGeocode.ComponentFilters

  defstruct address: nil,
    components: nil

  @type t :: %__MODULE__{}

  def geocode(address) when is_bitstring(address) do
    %Request{address: address}
    |> geocode
  end

  def geocode(address, %ComponentFilters{} = components) do
    %Request{address: address, components: ComponentFilters.serialize(components)}
    |> geocode
  end

  def geocode(%Request{} = request) do
    request
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end) # remove nil values
    |> get
  end

  def get(request) do
    IO.inspect request
    base_url
    |> HTTPoison.get([], [params: request])
  end

  def base_url do
    "https://maps.googleapis.com/maps/api/geocode/json"
  end
end

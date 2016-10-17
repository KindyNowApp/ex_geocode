defmodule ExGeocode.Request do
  @moduledoc """
  """

  alias __MODULE__
  alias ExGeocode.Config
  alias ExGeocode.ComponentFilters

  defstruct address: nil,
    components: nil,
    key: nil

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
    |> attach_api_key
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end) # remove nil values
    |> get
  end

  def get(request) do
    base_url
    |> HTTPoison.get([], [params: request])
  end

  def base_url do
    api_host <> "/maps/api/geocode/json"
  end

  def api_host do
    Application.get_env(:ex_geocode, :api_host)
  end

  def attach_api_key(%Request{} = request) do
    %Request{request | key: Config.api_key}
  end
end

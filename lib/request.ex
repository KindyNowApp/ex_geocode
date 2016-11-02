defmodule ExGeocode.Request do

  @moduledoc """
  A geocode request which consists of an address and address components (optional).
  """

  alias __MODULE__
  alias ExGeocode.Config
  alias ExGeocode.ComponentFilters
  alias ExGeocode.Response

  defstruct address: nil,
    components: nil,
    key: nil

  @type t :: %__MODULE__{}

  @doc """
  Geocode an address.
  """
  @spec geocode(Request.t) :: {atom, map}
  def geocode(%Request{} = request) do
    request
    |> attach_api_key
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end) # remove nil values
    |> get
  end

  @spec geocode(String.t) :: {atom, map}
  def geocode(address) when is_bitstring(address) do
    %Request{address: address}
    |> geocode
  end

  @doc """
  Geocode an address with component filters.
  """
  @spec geocode(String.t, ComponentFilters.t) :: {atom, map}
  def geocode(address, %ComponentFilters{} = components) do
    %Request{address: address, components: ComponentFilters.serialize(components)}
    |> geocode
  end

  @spec get(map) :: {atom, map}
  defp get(request) do
    Config.base_url
    |> HTTPoison.get([], [params: request])
    |> parse_response
  end

  @spec parse_response({atom, HTTPoison.Response.t}) :: {atom, Response.t}
  @spec parse_response({atom, HTTPoison.Error.t}) :: {atom, String.t}
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, Response.parse(body)}
  end

  defp parse_response({:error, %HTTPoison.Error{id: _id, reason: reason}}) do
    {:error, reason}
  end

  @spec attach_api_key(Request.t) :: Request.t
  def attach_api_key(%Request{} = request) do
    %Request{request | key: Config.api_key}
  end
end

defmodule ExGeocode do

  @moduledoc """
  An Elixir API client for the Google Geocode API

  # Usage

  ```elixir
  def deps do
    [{:ex_geocode, "~> 0.1.0"}]
  end
  ```

  Add the `:ex_gecode` application as your list of applications in `mix.exs`:

  ```elixir
  def application do
    [applications: [:logger, :ex_geocode]]
  end
  ```

  Then run `$ mix do deps.get, compile` to download and compile your dependencies.

  You'll need to set a few config parameters, some in your app config, some, like
  API credentials, we recommend keeping as environment viarables: take a look in
  the lib/config.ex file to see what is required.

  Then geocoding an address is as easy as:

  ```elixir
  ExGeocode.geocode_address(address)
  ```
  """

  alias ExGeocode.{ComponentFilters, Request}

  @doc """
  Geocodes an address.
  """
  @spec geocode_address(String.t) :: {atom, map}
  def geocode_address(address) do
    Request.geocode(address)
  end

  @spec geocode_address(String.t, ComponentFilters.t) :: {atom, map}
  def geocode_address(address, component_filters) do
    Request.geocode(address, component_filters)
  end

end

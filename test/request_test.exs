defmodule ExGeocode.RequestTest do
  use ExUnit.Case, async: true

  alias ExGeocode.Request
  alias ExGeocode.ComponentFilters

  setup do
    full_address = "1600 Amphitheatre Parkway, Mountain View, CA"
    partial_address = "1 Smith Street"
    address_components = %ComponentFilters{
      locality: "Richmond",
      country: "AU"
    }

    # bypass = Bypass.open

    {:ok, %{
        full_address: full_address,
        partial_address: partial_address,
        address_components: address_components
        # bypass: bypass
      }
    }
  end

  test "geocode address", %{
    full_address: full_address
  } do
    # Bypass.expect bypass, fn conn ->
    #   assert "/maps/api/geocode/json" == conn.request_path
    #   assert "?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA" == conn.query_string
    #   assert "GET" == conn.method
    # end

    assert {:ok, response} = Request.geocode(full_address)
  end

  test "geocode address with components", %{
    partial_address: partial_address,
    address_components: address_components
  } do
    # Bypass.expect bypass, fn conn ->
    #   assert "/maps/api/geocode/json" == conn.request_path
    #   assert "?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA" == conn.query_string
    #   assert "GET" == conn.method
    # end

    assert {:ok, response} = Request.geocode(partial_address, address_components)
  end
end

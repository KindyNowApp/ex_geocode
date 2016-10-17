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

    api_key = "test_key"
    System.put_env "GOOGLE_MAPS_GEOCODE_API_KEY", api_key

    bypass = Bypass.open
    Application.put_env :ex_geocode, :api_host, "http://localhost:#{bypass.port}"

    valid_response = """
      {
        "results": ["foo"],
        "status": "OK"
      }
      """
    {:ok, %{
        full_address: full_address,
        partial_address: partial_address,
        address_components: address_components,
        api_key: api_key,
        valid_response: valid_response,
        bypass: bypass
      }
    }
  end

  test "geocode address", %{
    full_address: full_address,
    bypass: bypass,
    valid_response: valid_response,
    api_key: api_key
  } do
    Bypass.expect bypass, fn conn ->
      assert "/maps/api/geocode/json" == conn.request_path
      assert %{ "address" => full_address, "key" => api_key } == URI.decode_query(conn.query_string)
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 200, valid_response)
    end

    assert {:ok, _response} = Request.geocode(full_address)
  end

  test "geocode address with components", %{
    partial_address: partial_address,
    address_components: address_components,
    bypass: bypass,
    valid_response: valid_response,
    api_key: api_key
  } do
    Bypass.expect bypass, fn conn ->
      assert "/maps/api/geocode/json" == conn.request_path
      assert %{
        "address" => partial_address,
        "components" => ComponentFilters.serialize(address_components),
        "key" => api_key
      } == URI.decode_query(conn.query_string)
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 200, valid_response)
    end

    assert {:ok, _response} = Request.geocode(partial_address, address_components)
  end
end

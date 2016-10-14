defmodule ExGeocode.ComponentFiltersTest do
  use ExUnit.Case, async: false

  alias ExGeocode.ComponentFilters

  test "serialize component filters" do
    filters = %ComponentFilters{ route: "Test Street", country: "AU" }

    assert ComponentFilters.serialize(filters) == "country:AU|route:Test Street"
  end
end

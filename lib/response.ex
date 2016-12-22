defmodule ExGeocode.Response do

  @moduledoc """
  A geocode response.
  """

  alias __MODULE__
  alias ExGeocode.Helper
  import Poison, only: [decode!: 1]

  defstruct results: [],
    status: nil

  @type t :: %__MODULE__{}

  @doc """
  Parses a geocode JSON response.
  """
  @spec parse(String.t) :: map
  def parse(json) do
    response =
      json
      |> decode!
      |> Helper.atomise_keys
     struct(Response, response)
  end

end

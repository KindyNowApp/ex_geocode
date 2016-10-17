defmodule ExGeocode.Response do
  @moduledoc """
  """

  alias __MODULE__
  alias ExGeocode.Helper

  defstruct results: [],
    status: nil

  import Poison, only: [decode: 1]

  @type t :: %__MODULE__{}

  @doc """
  """
  @spec parse(String.t) :: map
  def parse(json) do
    response = json
      |> decode
      |> atomise_keys

    Response
      |> struct(response)
  end

  defp atomise_keys({:ok, response}) do
    Helper.atomise_keys(response)
  end

end

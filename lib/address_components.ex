defmodule ExGecode.AddressComponents do

  alias __MODULE__

  defstruct route: nil,
    locality: nil,
    administrative_area: nil,
    postal_code: nil,
    country: nil


  @type t :: %__MODULE__{}


  @doc """
  Serialize an AddressComponent into a string
  """
  def serialize(%AddressComponents{} = components) do

  end
end

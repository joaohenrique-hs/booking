defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_args), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &Map.put(&1, id, booking))

    {:ok, id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end
end

defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_args), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%User{cpf: cpf} = user), do: Agent.update(__MODULE__, &Map.put(&1, cpf, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end

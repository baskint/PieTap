defmodule ClientPie do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:ok, hostname } = :inet.gethostname
    {:ok, %{name: hostname}}
  end

  def get_name(pid) do
    GenServer.call(pid, :get_name)
  end

  def handle_call(:get_name, _from, state) do
    {:reply, Map.get(state, :name), state}
  end

end
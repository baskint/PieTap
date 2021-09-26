defmodule PieTap.ClientPie do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:ok, hostname } = :inet.gethostname
    {:ok, %{name: hostname}}

    port = Application.get_env :pie_tap, :port, 6767
  end

  def get_name(pid) do
    GenServer.call(pid, :get_name)
  end

  def handle_call(:get_name, _from, state) do
    {:reply, Map.get(state, :name), state}
  end

  def get_server_stats(pid, server_name) do
    :application.start(:sasl)
    :application.start(:os_mon)

    # get disk info
    diskInfo = :disksup.get_disk_data()

    # get memory data
    {total, allocated, {p1, p1allocated}} = :memsup.get_memory_data()

    :application.stop(:os_mon)
    :application.stop(:sasl)

    IO.puts p1allocated
    diskInfo

  end

end
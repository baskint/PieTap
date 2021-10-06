defmodule PieTap do
  require Logger
  alias PieTap.Handler

  def accept(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, active: true])

    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info("Accepted new connection")

    {:ok, pid} =
      DynamicSupervisor.start_child(PieTap.Handler.DynamicSupervisor, %{
        id: Handler,
        start: {Handler, :start_link, [%{socket: client}, []]},
        type: :worker,
        restart: :transient
      })

    :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end
end

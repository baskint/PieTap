defmodule ClientTest do
  use ExUnit.Case
  alias PieTap.ClientPie

  test "initial name is default" do

    {:ok, pid} = ClientPie.start_link

    assert 'enver' == ClientPie.get_name(pid)
  end

  test 'status request updates the server name' do
    {:ok, pid} = ClientPie.start_link

    ClientPie.get_server_stats(pid, 'mistral')
  end
end
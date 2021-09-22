defmodule ClientPieTest do
  use ExUnit.Case

  test "initial name is empty" do

    {:ok, pid} = ClientPie.start_link

    assert 'enver' == ClientPie.get_name(pid)
  end
end
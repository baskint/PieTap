defmodule PietapTest do
  use ExUnit.Case
  doctest Pietap

  test "greets the world" do
    assert Pietap.hello() == :world
  end

  # test "fails" do
  #   assert true == false
  # end
end

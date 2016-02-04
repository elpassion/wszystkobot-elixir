defmodule CALCTest do
  use ExUnit.Case

  doctest CALC

  test "defines interact/1 function" do
    assert is_function(&CALC.interact/1)
  end

  test "responds with {:ok,_} for servicable request" do
	  	assert { :ok, _ } = CALC.interact("how much is 2+2")
  end

  test "responds with {:ignored} for non servicable request" do
  		assert { :ignored } = CALC.interact("foo bar")
  end

  test "performs simple calculations" do
  		assert { :ok, 4 } = CALC.interact("how much is 2+2")
      assert { :ok, 3 } = CALC.interact("how much is 9 / 3")
  end
end

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
  		assert { :ok, 4.0 } = CALC.interact("how much is 2+2")
      assert { :ok, 3.0 } = CALC.interact("how much is 9 / 3")
  end

  test "it should nicely handle improper equations" do
    assert { :ok, "Naah, something is wrong with your equation, man." } = CALC.interact("how much is 3/0")
  end

  test "performs a little more complex expressions" do
    assert { :ok, 2.5 } = CALC.interact("how much is (9 % 6) * 0.5 + 1")
  end
end

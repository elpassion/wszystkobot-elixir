defmodule CalcTest do
  use ExUnit.Case

  doctest Calc

  test "defines interact/1 function" do
    assert is_function(&Calc.interact/1)
  end

  test "responds with {:ok,_} for servicable request" do
	  	assert { :ok, :message, _ } = Calc.interact("how much is 2+2")
  end

  test "responds with {:ignored} for non servicable request" do
  		assert { :ignored, :none, "" } = Calc.interact("foo bar")
  end

  test "performs simple calculations" do
  		assert { :ok, :message, 4.0 } = Calc.interact("how much is 2+2")
      assert { :ok, :message, 3.0 } = Calc.interact("how much is 9 / 3")
  end

  test "it should nicely handle improper equations" do
    assert { :ok, :message, "Naah, something is wrong with your equation, man." } = Calc.interact("how much is 3/0")
  end

  test "performs a little more complex expressions" do
    assert { :ok, :message, 2.5 } = Calc.interact("how much is (9 % 6) * 0.5 + 1")
  end
end

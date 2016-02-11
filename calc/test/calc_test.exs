defmodule CalcTest do
  use ExUnit.Case

  doctest Calc

  test "defines interact/3 function" do
    assert is_function(&Calc.interact/3)
  end

  test "defines proceed/1 function" do
    assert is_function(&Calc.proceed/1)
  end

  test "responds with result for servicable request" do
    assert "4.0" = Calc.proceed("how much is 2+2")
  end

  test "performs simple calculations" do
    assert "4.0" = Calc.proceed("how much is 2+2")
    assert "3.0" = Calc.proceed("how much is 9 / 3")
  end

  test "performs a little more complex expressions" do
    assert "2.5" = Calc.proceed("how much is (9 % 6) * 0.5 + 1")
  end
end

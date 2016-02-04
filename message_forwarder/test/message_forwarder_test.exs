defmodule MFTest do
  use ExUnit.Case
  doctest MF

  test "handle no input" do
    assert MF.handle_input() == {:error, "No message received!"}
  end

  test "handle empty input" do
    assert MF.handle_input("") == {:error, "Input is empty. No message received!"}
  end

  test "handle input" do
    assert MF.handle_input("<@U084BDT55>: asd") == {:ok, "U084BDT55", "asd"}
  end
end

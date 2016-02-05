defmodule PhrasesTest do
  use ExUnit.Case
  doctest Phrases

  test "get_phrases returns phrases of certain type" do
    assert Phrases.get_phrases("test_phrases") == ["Raz", "dwa", "Zażółć gęślą jaźń"]
  end
end

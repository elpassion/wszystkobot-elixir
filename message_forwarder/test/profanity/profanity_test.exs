defmodule MessageForwarder.ProfanityTest do
  use ExUnit.Case
  doctest MessageForwarder.Profanity
  alias MessageForwarder.Profanity, as: Profanity

  test "censor profane text" do
    assert Profanity.censor_profane("fucking building") == "******* building"
  end

  test "word is replaced by specific char" do
    assert Profanity.replace_word("word") == "****"
  end
end

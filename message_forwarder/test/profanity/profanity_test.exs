defmodule MessageForwarder.ProfanityTest do
  use ExUnit.Case
  doctest MessageForwarder.Profanity
  alias MessageForwarder.Profanity, as: Profanity

  setup_all do
    Profanity.new
    :ok
  end

  test "censor profane text" do
    assert Profanity.censor_profane("fucking building") == "******* building"
  end

  test "word is matched as profane" do
    assert Profanity.check_if_profane("fuck") == true
  end

  test "word is replaced by specific char" do
    assert Profanity.replace_word("word") == "****"
  end
end

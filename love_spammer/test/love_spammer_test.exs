defmodule LoveSpammerTest do
  use ExUnit.Case
  doctest LoveSpammer

  test "love_message returns sample love message" do
    assert Enum.member?(["Hi there :smile: You look great today! Have a nice day :dancer:", "Hi there! You look great today :smile: Have a nice day :dancer:"], LoveSpammer.love_message)
  end

  test "can_handle_message returns true given simple kiss message" do
    assert LoveSpammer.can_handle_message(":*") == true
  end

  test "can_handle_message returns true given emoticon kiss message" do
    assert LoveSpammer.can_handle_message(":kiss:") == true
  end

  test "can_handle_message returns false given random message" do
    assert LoveSpammer.can_handle_message(":kisso:") == false
  end
end

defmodule LoveSpammerTest do
  use ExUnit.Case
  doctest LoveSpammer

  test "loveMessage returns sample love message" do
    assert Enum.member?(["Hi there :smile: You look great today! Have a nice day :dancer:", "Hi there! You look great today :smile: Have a nice day :dancer:"], LoveSpammer.love_message)
  end
end

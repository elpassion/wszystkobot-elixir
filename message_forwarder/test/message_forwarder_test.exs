defmodule MessageForwarderTest do
  use ExUnit.Case
  doctest MessageForwarder

  setup_all do
    MessageForwarder.new
    :ok
  end

  test "handle no input" do
    assert MessageForwarder.forward_message() == {:error, "No message received!"}
  end

  test "handle empty input" do
    assert MessageForwarder.forward_message("") == {:error, "Input is empty. No message received!"}
  end

  test "handle input" do
    assert MessageForwarder.forward_message("<@U084BDT55>: Test message") == {:ok, :message, "Test message", "U084BDT55"}
  end

  test "handle input with profanity" do
    assert MessageForwarder.forward_message("<@U084BDT55>: Test message kurwa") == {:ok, :message, "Test message *****", "U084BDT55"}
  end
end

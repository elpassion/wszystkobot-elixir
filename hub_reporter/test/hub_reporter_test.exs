defmodule HubReporterTest do
  use ExUnit.Case
  doctest HubReporter

  setup do
    TokenHandler.clean()
    :ok
  end

  test "can handle messages with hub prefix" do
    assert HubReporter.canHandleMessage("hub test")
  end

  test "cannot handle messages without hub prefix" do
    assert HubReporter.canHandleMessage("some msg") == false
  end

  test "return info about non-existing functions" do
    assert HubReporter.handleMessage("hub some_function some_text") == "There's no function some_function"
  end

  test "can send user token" do
    assert HubReporter.handleMessage("hub token sample_token_123") == "Token added."
  end

  test "token does not exist" do
    assert HubReporter.handleMessage("hub token") == "There's no token assigned to your account."
  end

  test "return token when token was provided" do
    HubReporter.handleMessage("hub token asd")
    assert HubReporter.handleMessage("hub token") == "Your token is asd"
  end
end

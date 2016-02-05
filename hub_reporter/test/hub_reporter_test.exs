defmodule HubReporterTest do
  use ExUnit.Case
  doctest HubReporter

  setup do
    TokenHandler.clean()
    :ok
  end

  test "can handle messages with hub prefix" do
    assert HubReporter.can_handle_message("hub test")
  end

  test "cannot handle messages without hub prefix" do
    assert HubReporter.can_handle_message("some msg") == false
  end

  test "return info about non-existing functions" do
    assert HubReporter.handle_message("hub some_function some_text") == "There's no function some_function"
  end

  test "can send user token" do
    assert HubReporter.handle_message("hub token sample_token_123") == "Token added."
  end

  test "token does not exist" do
    assert HubReporter.handle_message("hub token") == "There's no token assigned to your account."
  end

  test "return token when token was provided" do
    HubReporter.handle_message("hub token asd")
    assert HubReporter.handle_message("hub token") == "Your token is asd"
  end
end

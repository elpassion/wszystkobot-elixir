defmodule Slack do
  defstruct text: "", user: ""
end

defmodule HubReporterTest do
  use ExUnit.Case
  doctest HubReporter

  setup_all do
    Application.put_env(:hub_reporter, :token_file_name, ".token_test")
  end

  setup do
    TokenHandler.clean()
    :ok
  end

  test "can handle messages with hub prefix" do
    assert HubReporter.can_handle_message(%Slack{text: "hub test"})
  end

  test "cannot handle messages without hub prefix" do
    assert HubReporter.can_handle_message(%Slack{text: "some msg"}) == false
  end

  test "return info about non-existing functions" do
    assert HubReporter.handle_message(%Slack{text: "hub some_function some_text"}) == {:ok, :message, "There's no function hub some_function some_text"}
  end

  test "can send user token" do
    assert HubReporter.handle_message(%Slack{text: "hub token sample_token_123"}) == {:ok, :message, "Token added."}
  end

  test "token does not exist" do
    assert HubReporter.handle_message(%Slack{text: "hub token"}) == {:ok, :message, "There's no token assigned to your account."}
  end

  test "token is assigned to one user" do
    HubReporter.handle_message(%Slack{text: "hub token asd", user: "user1"})
    assert HubReporter.handle_message(%Slack{text: "hub token", user: "user2"}) == {:ok, :message, "There's no token assigned to your account."}
  end

  test "return token when token was provided" do
    HubReporter.handle_message(%Slack{text: "hub token asd", user: "test"})
    assert HubReporter.handle_message(%Slack{text: "hub token", user: "test"}) == {:ok, :message, "Your token is asd"}
  end
end

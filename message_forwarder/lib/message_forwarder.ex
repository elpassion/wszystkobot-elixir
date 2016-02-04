defmodule MessageForwarder do

  def handle_input() do
    {:error, "No message received!"}
  end

  def handle_input("") do
    {:error, "Input is empty. No message received!"}
  end

  def handle_input(input) do
    [matched_string, user_name] = Regex.run(~r/^<@([A-Z]\w+)>:/, input)
    message = input |> String.replace(matched_string, "") |> String.strip

    {:ok, user_name, message}
  end

  def forward_message(input) do
    handle_input(input)
  end
end

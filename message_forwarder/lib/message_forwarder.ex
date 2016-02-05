defmodule MessageForwarder do
  alias MessageForwarder.Profanity, as: Profanity

  def new do
    Profanity.new
  end

  def forward_message() do
    {:error, "No message received!"}
  end

  def forward_message("") do
    {:error, "Input is empty. No message received!"}
  end

  def forward_message(input) do
    handle_input(input)
  end

  defp handle_input(input) do
    [matched_string, user_name] = Regex.run(~r/^<@([A-Z]\w+)>:/, input)
    case user_name do
      nil ->
        {:ignored, :none, ""}
      _ ->
        message = input |> String.replace(matched_string, "") |> String.strip
        message = Profanity.censor_profane(message)
        {:ok, :message, message, user_name}
    end
  end
end

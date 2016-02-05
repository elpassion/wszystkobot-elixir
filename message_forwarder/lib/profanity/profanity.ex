defmodule MessageForwarder.Profanity do
  @profane_list_file File.cwd! |> Path.join("config/profanity-list.yml")
  @replace_char "*"

  def new do
    Agent.start_link(fn -> YamlElixir.read_from_file(@profane_list_file) end, name: __MODULE__)
  end

  defp get_profane_list do
    Agent.get(__MODULE__, fn(word) -> word end)
  end

  def censor_profane(text) do
    text |> String.split(" ") |> Enum.map(fn(word) ->
      case check_if_profane(word) do
        true -> replace_word(word)
        _ -> word
      end
    end) |> Enum.join(" ")
  end

  def check_if_profane(word) do
    get_profane_list |> Enum.find_value(fn(profane) ->  profane == word end)
  end

  def replace_word(word) do
    len = word |> String.length
    String.duplicate(@replace_char, len)
  end

end

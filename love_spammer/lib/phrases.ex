defmodule Phrases do

  @def_phrases_path Application.get_env(:love_spammer, :phrases_path, to_string(:code.priv_dir(:love_spammer)) <> "/phrases/")
  @def_extension    Application.get_env(:love_spammer, :extension, ".txt")

  def get_phrases(type) do
    case get_file(type) do
      {:error, error} -> error
      str             -> str |> String.split("\n", trim: true)
    end
  end

  defp get_file(name) do
    try do
      build_phrases_filepath(name) |> File.read! |> String.strip
    rescue error ->
      {:error, error}
    end
  end

  defp build_phrases_filepath(name), do: @def_phrases_path <> name <> @def_extension

end

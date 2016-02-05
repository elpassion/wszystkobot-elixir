defmodule LoveSpammer do

  def love_message do
    :random.seed(:os.timestamp)

    punctuation_marks = (["!"] ++ (Phrases.get_phrases("smileys") |> Enum.take_random(1) |> Enum.map(fn(s) -> " #{s}" end))) |> Enum.shuffle
    icons             = Phrases.get_phrases("icons") |> Enum.take_random(:random.uniform(3) + 1)
    welcome           = Phrases.random_phrase("welcomes") <> (punctuation_marks |> Enum.at(0))
    compliment        = Phrases.random_phrase("compliments") <> (punctuation_marks |> Enum.at(1))
    ending            = Phrases.random_phrase("endings") <> " " <> (icons |> Enum.join())

    Enum.join([welcome, compliment, ending], " ")
  end

end

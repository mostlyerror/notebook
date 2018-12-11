require Integer

defmodule Schizo do
  @moduledoc """
  This is a module that provides odd behavior for transforming every other word
  in a string.

  Examples:
    
    iex> Schizo.uppercase("this is an example")
    "this IS an EXAMPLE"

    iex> Schizo.unvowel("this is an example")
    "this s an xmpl"
  """

  def every_other_word(string, fun) do
    string
    |> String.split(" ")
    |> Enum.with_index
    |> Enum.map(fn({word, index}) ->
      if Integer.is_even(index) do
        word
      else
        fun.(word)
      end
    end)
    |> Enum.join(" ")
  end

  def uppercase(string) do
    # every_other_word(string, fn(word) -> String.upcase(word) end)
    #
    # string
    # |> every_other_word(&String.upcase/1)
    #
    every_other_word(string, &String.upcase/1)
  end

  def unvowel(string) do
    # every_other_word(string, fn(word) -> Regex.replace(~r/[aeiou]/, word, "") end)
    #
    # string
    #|> every_other_word(&Regex.replace(~r/[aeiou]/, &1, ""))
    #
    every_other_word(string, &remove_vowels/1)
  end

  def remove_vowels(word) do
    Regex.replace(~r/[aeiou]/, word, "")
  end
end

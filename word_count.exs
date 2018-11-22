defmodule Words do
  defp downcase_and_remove_punctuation(string) do
    string
    |> String.replace(~r/!/, "")
    |> String.replace(~r/&/, "")
    |> String.replace(~r/:/, "")
    |> String.replace(~r/\$/, "")
    |> String.replace(~r/%/, "")
    |> String.replace(~r/\^/, "")
    |> String.replace(~r/@/, "")
    |> String.replace(~r/,/, "")
    |> String.downcase()
  end

  defp remove_punctuation_list([]), do: []

  defp remove_punctuation_list([head | tail]) do
    [downcase_and_remove_punctuation(head) | remove_punctuation_list(tail)]
  end

  defp make_word_list(sentence) do
    sentence
    |> String.split([" ", "_"])
    |> remove_punctuation_list
    |> Enum.filter(fn x -> x != "" end)
  end

  defp ocurrences(key, map) do
    Map.get(map, key, 0)
  end

  defp add_to_map(map, []), do: map

  defp add_to_map(map, [head | tail]) do
    Map.put(map, head, ocurrences(head, map) + 1)
    |> add_to_map(tail)
  end

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    add_to_map(%{}, make_word_list(sentence))
  end
end

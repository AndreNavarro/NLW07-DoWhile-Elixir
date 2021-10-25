defmodule HeatTags.Tags.Count do
  alias HeatTags.Messages.Get

  def call do
    Get.today_messages()
    |> Task.async_stream(&count_words(&1.message))
    # A função a seguir pode ser escritas das duas formas, sendo direta ou por cada elemento
    # |> Enum.reduce(%{}, &sum_values(&1, &2))
    |> Enum.reduce(%{}, fn elem, acc -> sum_values(elem, acc) end)
    |> IO.inspect()
  end

  defp count_words(message) do
    message
    |> String.split()
    |> Enum.frequencies()
  end

  defp sum_values({:ok, map1}, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end
end

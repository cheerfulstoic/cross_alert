defmodule Mix.Tasks.ConvertRedCross do
  use Mix.Task

  def run(_args) do
    for path <- Path.wildcard("*.json") do
      table_data =
        for tweet <- Jason.decode!(File.read!(path)) do
          text = text(tweet)
          datetime = twitter_datetime_to_iso8601(tweet["created_at"])

          [tweet["id"],
            text,
            Timex.format!(datetime, "%Y-%m-%d %H:%M:%S", :strftime)]
        end

      file = File.open!("#{path}.csv", [:write, :utf8])
      table_data |> CSV.encode |> Enum.each(&IO.write(file, &1))
    end
  end

  def text(data) do
    indifferent_get_in(data, ~w[retweeted_status extended_tweet full_text]a) ||
    indifferent_get_in(data, ~w[retweeted_status text]a) ||
    indifferent_get_in(data, ~w[text]a) || ""
    |> String.trim()
  end

  # RFC822
  def twitter_datetime_to_iso8601(string) do
    case Timex.parse(string, "%a %b %d %H:%M:%S %z %Y", :strftime) do
      # {:ok, datetime} -> Timex.format(datetime, "{ISO:Extended}")
      {:ok, datetime} -> datetime
      _ -> nil
    end
  end

  def indifferent_get_in(initial, path) do
    Enum.reduce(path, initial, fn
      (_, nil) -> nil
      (key, current) when is_atom(key) ->
        Map.get_lazy(current, key, fn -> Map.get(current, Atom.to_string(key)) end)
      (key, current) when is_binary(key) ->
        Map.get_lazy(current, key, fn -> Map.get(current, String.to_atom(key)) end)
    end)
  end
end


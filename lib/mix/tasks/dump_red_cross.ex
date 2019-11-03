defmodule Mix.Tasks.DumpRedCross do
  use Mix.Task

  def run(_args) do
    # {:ok, stream} = Twittex.stream(:sample, stage: true)
    # {:ok, stream} = Twittex.stream("är OR och", language: "sv")

    # IO.inspect(length(result["statuses"]))
    # IO.inspect(result["search_metadata"])

    # keywords = ~w[brand bomba skytten]
    # keywords = ~w[imam]
    # keywords = ~w[gävle säpo aboraad gävlemoskén] ++ ["abo raad"]
    # keywords = ~w[vattenmassa snökaos översvämning drunknat storm]
    # skjutning
    # keywords = ["olycka"]
    keywords = ["skjutning", "polis"]

    # for keyword <- keywords do
      tweets = get_results("", 100)

      {:ok, file} = File.open("sv_10000.json", [:write])
      IO.binwrite(file, Jason.encode!(tweets))
      File.close(file)
    # end
  end

  def get_results(term, 0, _since), do: []

  def get_results(term, pages_left, max_id \\ nil) do
    Process.sleep(10000)

    {:ok, %{"statuses" => statuses}} =
      Twittex.Client.search("lang:sv", count: 100, max_id: max_id)

    case statuses do
      [] -> []
      _ ->
        min_id = Enum.min_by(statuses, & &1["id"])["id"] - 1

        statuses ++ get_results(term, pages_left - 1, min_id)
    end
  end
end

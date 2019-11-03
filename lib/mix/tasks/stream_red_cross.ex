defmodule Mix.Tasks.StreamRedCross do
  use Mix.Task

  @count 1000

  def run(_args) do
    {:ok, stream} = Twittex.Client.stream(:sample, lang: "sv")

    tweets =
      stream
      |> Stream.filter(& &1["lang"] == "sv")
      |> Stream.each(fn (tweet) -> IO.write(".") end)
      |> Enum.take(@count)
    Jason.encode!(tweets)

    {:ok, file} = File.open("sv_#{@count}.json", [:write])
    IO.binwrite(file, Jason.encode!(tweets))
    File.close(file)
  end
end

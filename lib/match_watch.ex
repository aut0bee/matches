defmodule MatchWatch do
  alias ExtractSummoners, as: Summoners
  alias MatchMonitor, as: Monitor

  def inspect_matches(name, region) do
    with {:ok, puuid} <- Summoners.get_puuid(name, region),
         summoners <-
           puuid
           |> Summoners.get_match_ids(region)
           |> Summoners.get_participants(region)
           |> Summoners.get_names(region) do
      IO.puts("#{name} has recently played with")
      summoners
    else
      {:error, error} ->
        IO.puts("Error: #{error}")
    end
  end

  def start_monitor(summoners, region) do
    Monitor.start_link({summoners, region})
  end
end

defmodule MatchWatch.MatchCache do
  use GenServer

  @match_table :matches
  @name_table :names

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :ets.new(@match_table, [:named_table, read_concurrency: true])
    :ets.new(@name_table, [:named_table, read_concurrency: true])
    {:ok, %{}}
  end

  def cache_info(table, id, info) do
    GenServer.cast(__MODULE__, {:cache_info, table, id, info})
  end

  def handle_cast({:cache_info, table, key, info}, state) do
    :ets.insert(table, {key, info, System.system_time(:second)})
    {:noreply, state}
  end
end

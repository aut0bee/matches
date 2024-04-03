defmodule MatchWatch.MatchCacheReader do
  @ttl_seconds 3600

  def get_cached_info(table, key) do
    case :ets.lookup(table, key) do
      [{^key, info, timestamp}] ->
        if System.system_time(:second) - timestamp <= @ttl_seconds do
          {:ok, info}
        else
          :not_found
        end

      [] ->
        :not_found
    end
  end
end

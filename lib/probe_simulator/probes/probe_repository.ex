defmodule ProbeSimulator.Probes.ProbeRepository do
  use GenServer

  @name __MODULE__

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

  def init(_) do
    IO.puts("Creating ETS #{@name}")
    :ets.new(:probe_cache, [:set, :public, :named_table])
    {:ok, "ETS Created"}
  end

  def insert(probe) do
    GenServer.call(@name, {:insert, probe})
  end

  def get() do
    GenServer.call(@name, :get)
  end

  def delete() do
    GenServer.call(@name, :delete)
  end

  def handle_call(:get, _ref, state) do
    result = :ets.first(:probe_cache)
    case result do
      :"$end_of_table" -> {:reply, {:error, "This probe was not created."}, state}
      _ -> {:reply, {:ok, result}, state}
    end

  end

  def handle_call({:insert, data}, _ref, state) do
    try do
      result = :ets.insert_new(:probe_cache, {data})
      {:reply, result, state}
    catch
      error, _   ->
        {:reply, {error, "Failed to create probe, check if exists a cache table"}, state}
    end
  end

  def handle_call(:delete, _ref, state) do
    try do
      result = :ets.delete_all_objects(:probe_cache)
      {:reply, result, state}
    catch
      error, _   ->
        {:reply, {error, "Failed to update probe, check if exists a cache table"}, state}
    end
  end
end

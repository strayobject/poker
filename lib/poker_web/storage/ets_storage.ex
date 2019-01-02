defmodule PokerWeb.EtsStorage do
  use GenServer

  @moduledoc """
  Storage for any session related data
  """

  def init(:ok) do
    create(:sessions)
    {:ok, []}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def create(table, options \\ [:set, :public, :named_table]) do
    :ets.new(table, options)
  end

  def destroy(table) do
    :ets.delete(table)
  end

  def get(table, key) do
    :ets.lookup(table, key)
  end

  def set(table, key, value) do
    :ets.insert(table, {key, value})
  end

  def delete(table, key) do

  end
end
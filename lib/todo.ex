defmodule Todo do
  @moduledoc """
  Documentation for Todo.
  """

  alias :mnesia, as: Mnesia
  @table :todo

  Mnesia.create_schema([node()])
  Mnesia.start()

  def create_mnesia_table() do
    Mnesia.create_table(
      @table,
      type: :set,
      attributes: [:key, :text, :is_done, :is_archived],
      disc_copies: [node()]
    )
  end

  def gen_key() do
    :crypto.strong_rand_bytes(10) |> Base.encode32()
  end

  def add(text) do
    key = gen_key()
    {:atomic, :ok} = Mnesia.transaction fn ->
      Mnesia.write({@table, key, text, false, false})
    end
    key
  end

  def show(key) do
    {:atomic, [row]} = Mnesia.transaction fn ->
      Mnesia.read(@table, key)
    end
    row
  end

  def done(key) do
    {:atomic, :ok} = Mnesia.transaction fn ->
      [{@table, ^key, text, is_done, is_archived}] = Mnesia.read(@table, key)
      Mnesia.write({@table, key, text, true, is_archived})
    end
    key
  end

  def list() do
    list(false)
  end

  def list(all) do
    Mnesia.transaction fn ->
      # Mnesia.select(:todo, )
    end
  end
end

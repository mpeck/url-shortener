defmodule DB do
  @moduledoc """
  Documentation for DB.
  """

  @table DB.ShortURL

  @doc """
  Creates the initial schema and table

  ## Examples

      iex> DB.setup!()
      :ok

  """
  @spec setup!() :: :ok
  def setup!(nodes \\ [node()]) do
    # Create the DB directory
    if path = Application.get_env(:mnesia, :dir) do
      :ok = File.mkdir_p!(path)
    end

    # Create the schema
    Memento.stop()
    Memento.Schema.create(nodes)
    Memento.start()

    # Drop existing table
    Memento.Table.delete(@table)

    # Create the table
    Memento.Table.create(@table, disc_copies: nodes)
    :ok
  end

  @doc """
  Persists a url to the db

  ## Examples

      iex> DB.persist({"abadaba", "http://www.google.com"})
      %DB.ShortURL{id: "abadaba", url: "http://www.google.com"}
  """
  @spec persist({binary(), binary()}) :: %DB.ShortURL{}
  def persist({id, url}) do
    Memento.transaction!(fn ->
      Memento.Query.write(%DB.ShortURL{id: id, url: url})
    end)
  end

  @doc """
  Fetches a short url record from the db

      iex> DB.persist({"abadaba", "http://www.google.com"})
      ...> DB.fetch("abadaba")
      %DB.ShortURL{id: "abadaba", url: "http://www.google.com"}

  """
  @spec fetch(binary()) :: %DB.ShortURL{}
  def fetch(id) do
    Memento.transaction!(fn ->
      Memento.Query.read(DB.ShortURL, id)
    end)
  end
end

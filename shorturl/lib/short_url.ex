defmodule ShortURL do
  @moduledoc """
  Main internal API for generating and retrieving shortened URLs
  """

  alias :crypto, as: Crypto

  @allowed_schemes ["https", "http"]
  @key_size_in_bytes 8

  @doc """
  Creates a new key for a given URI. URI must use either the 'HTTP' or 'HTTPS' scheme.

  ## Examples

      iex> ShortURL.create("https://www.google.com")
      {:ok, {"557pzgbz", "https://www.google.com"}}

      iex> ShortURL.create("http://www.google.com")
      {:ok, {"oog56nnt", "http://www.google.com"}}

      iex> URI.parse("https://www.google.com") |> ShortURL.create()
      {:ok, {"557pzgbz", "https://www.google.com"}}

  """
  @spec create(binary() | %URI{}) :: {:ok, {binary(), binary()}} | {:error, {:bad_scheme, binary()}}
  def create(uri) when is_binary(uri) do
    URI.parse(uri) |> create()
  end
  def create(%URI{scheme: scheme} = uri) when scheme in @allowed_schemes do
    uri_string = URI.to_string(uri)

    <<key::binary-size(@key_size_in_bytes), _::binary>> =
      Crypto.hash(:sha, uri_string)
      |> Base.encode32(case: :lower)

    {:ok, {key, uri_string}}
  end
  def create(bad_uri) do
    {:error, {:bad_scheme, URI.to_string(bad_uri)}}
  end

  @doc """
  Persists ShortURLs to the specified store

  ## Examples

      iex> ShortURL.persist({"557pzgbz", "https://www.google.com"}, %{})
      {:ok, {"557pzgbz", "https://www.google.com"}}

  """
  @spec persist({binary(), binary()}, Store.t()) :: {:ok, Store.t()} | {:error, {atom(), binary()}}
  def persist({key, value}, store \\ %{}) do
    Store.persist(store, key, value)
  end

  @doc """
  Gets ShortURLs from the specified store

  ## Examples

      iex> ShortURL.get("557pzgbz", %{"557pzgbz" => "https://www.google.com"})
      {:ok, "https://www.google.com"}

      iex> ShortURL.get("557pzgbz", %{})
      {:error, :not_found}
  """
  @spec fetch(binary(), Store.t()) :: {:ok, binary()} | {:error, atom()}
  def fetch(key, store) do
    Store.fetch(store, key)
  end
end

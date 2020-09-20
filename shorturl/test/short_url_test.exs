defmodule ShortURLTest do
  use ExUnit.Case
  doctest ShortURL

  test "returns an error when the scheme is not specified" do
    bad_uri = "google.com"

    {:error, {:bad_scheme, ^bad_uri}} = ShortURL.create(bad_uri)
  end

  test "returns an error when a non supported scheme is specified" do
    bad_uri = "data://fakedomain.com/fakepath"

    {:error, {:bad_scheme, ^bad_uri}} = ShortURL.create(bad_uri)
  end
end

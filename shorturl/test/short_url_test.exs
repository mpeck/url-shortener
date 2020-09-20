defmodule ShortURLTest do
  use ExUnit.Case
  doctest ShortURL

  test "greets the world" do
    assert ShortURL.hello() == :world
  end
end

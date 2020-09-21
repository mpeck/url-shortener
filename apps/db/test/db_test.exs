defmodule DBTest do
  use ExUnit.Case, async: false

  setup do
    Application.ensure_started(:mnesia)

    Memento.Table.delete(DB.ShortURL)
    Memento.Table.create(DB.ShortURL)
  end

  test "persists a record" do
    id = "abadaba"
    url = "http://www.google.com"

    %DB.ShortURL{id: ^id, url: ^url} = DB.persist({id, url})
  end

  test "fetches a persisted record" do
    id = "abadaba"
    url = "http://www.google.com"

    DB.persist({id, url})

    %DB.ShortURL{id: ^id, url: ^url} = DB.fetch(id)
  end
end

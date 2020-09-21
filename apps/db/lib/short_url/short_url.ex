defmodule DB.ShortURL do
  use Memento.Table,
    attributes: [:id, :url]
end

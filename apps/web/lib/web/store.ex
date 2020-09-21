defimpl Store, for: DB.ShortURL do
  def persist(_db, key, value) do
    {:ok, DB.persist({key, value})}
  end

  def fetch(_db, key) do
    case DB.fetch(key) do
      nil -> {:error, :not_found}
      result -> {:ok, result}
    end
  end
end

defprotocol Store do
  @spec persist(t(), binary(), binary()) :: {:ok, t()} | {:error, atom()}
  def persist(store, key, value)

  @spec get(t(), binary()) :: {:ok, binary()} | {:error, atom()}
  def get(store, key)
end

defimpl Store, for: Map do
  def persist(map, key, value) do
    {:ok, Map.put(map, key, value)}
  end

  def get(map, key) do
    case Map.fetch(map, key) do
      {:ok, value} -> {:ok, value}
      :error -> {:error, :not_found}
    end
  end
end

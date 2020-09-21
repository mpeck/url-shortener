defmodule WebWeb.PageController do
  use WebWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"shortener" => %{"url" => url}}) do
    case ShortURL.create(url) do
      {:ok, {key, _} = rec} ->
        ShortURL.persist(rec, %DB.ShortURL{})

        conn
        |> put_flash(:info, "Great! Here is your shorter URL #{generate_url(key)}")
        |> render("index.html")

      {:error, {:bad_scheme, _}} ->
        conn
        |> put_flash(
          :error,
          "Invalid URL. Only fully qualified urls using the HTTP or HTTPS scheme are valid. For example, 'https://www.google.com'"
        )
        |> render("index.html")
    end
  end

  def get(conn, %{"key" => key}) do
    case ShortURL.fetch(key, %DB.ShortURL{}) do
      {:ok, %DB.ShortURL{url: url}} ->
        redirect(conn, external: url)

      {:error, :not_found} ->
        nil
    end
  end

  defp generate_url(key) do
    WebWeb.Endpoint.url() <> "/" <> key
  end
end

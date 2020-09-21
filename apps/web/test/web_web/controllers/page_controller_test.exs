defmodule WebWeb.PageControllerTest do
  use WebWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Tiny URL Shortener"
  end
end

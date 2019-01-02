defmodule PokerWeb.SessionController do
  use PokerWeb, :controller

  def show(conn, %{"id" => session_id}) do
  [{key, data}] = PokerWeb.EtsStorage.get(:sessions, session_id)

    conn
      |> put_flash(:info, "Welcome " <> data.owner)
      |> render("show.html")
  end

  def create(conn, params) do
    session_id = :crypto.strong_rand_bytes(15) |> Base.url_encode64() |> binary_part(0,15)
    PokerWeb.EtsStorage.set(:sessions, session_id, %{owner: Map.get(params, "session_owner")})

    conn
      |> put_flash(:info, "Your session id is:" <> session_id)
      |> redirect(to: Routes.session_path(conn, :show, session_id))
  end

  def delete(conn, _params) do

  end
end

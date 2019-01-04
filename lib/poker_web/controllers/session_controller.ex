defmodule PokerWeb.SessionController do
  use PokerWeb, :controller

  def show(conn, %{"id" => session_id}) do
    [{key, data}] = PokerWeb.EtsStorage.get(:sessions, session_id)

    conn
      |> put_flash(:info, "Welcome " <> data.name)
      |> render("show.html", session_id: session_id)
  end

  def create(conn, params) do
    session_id = :crypto.strong_rand_bytes(15) |> Base.url_encode64() |> binary_part(0,15)
    user_id = :crypto.strong_rand_bytes(15) |> Base.url_encode64() |> binary_part(0,15)
    user = %{owner: true, name: Map.get(params, "session_owner"), id: user_id}

    PokerWeb.EtsStorage.set(
      :sessions,
      session_id,
      user
    )

    conn
      |> put_session(:current_user, user)
      |> put_flash(:info, "Your session id is:" <> session_id)
      |> redirect(to: Routes.session_path(conn, :show, session_id))
  end

  def delete(conn, _params) do

  end
end

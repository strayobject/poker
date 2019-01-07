defmodule PokerWeb.SessionController do
  use PokerWeb, :controller

  def show(conn, %{"id" => session_id}) do
    case PokerWeb.EtsStorage.get(:sessions, session_id) do
      [] ->
        conn
          |> put_flash(:error, "Session does not exist. Please set up a new one.")
          |> redirect(to: Routes.page_path(conn, :index))
      [{key, data}] ->
        if current_user = get_session(conn, :current_user) do
          conn
            |> put_flash(:info, "Welcome " <> current_user.name)
            |> render("show.html", session_id: session_id)
        else
          conn
            |> redirect(to: Routes.session_user_path(conn, :new, session_id))
        end
    end
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

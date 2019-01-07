defmodule PokerWeb.SessionUserController do
  use PokerWeb, :controller

  def new(conn, %{"id" => session_id}) do
    conn
      |> render("index.html", session_id: session_id)
  end

  def create(conn, params) do
    session_id = Map.get(params, "id")
    user_id = :crypto.strong_rand_bytes(15) |> Base.url_encode64() |> binary_part(0,15)
    user = %{owner: false, name: Map.get(params, "name"), id: user_id}

#    PokerWeb.EtsStorage.set(
#      :sessions,
#      session_id,
#      user
#    )

    conn
      |> put_session(:current_user, user)
      |> redirect(to: Routes.session_path(conn, :show, session_id))
  end
end

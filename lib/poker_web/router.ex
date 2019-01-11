defmodule PokerWeb.Router do
  use PokerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PokerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:create, :show, :delete]
    get "/sessions/:id/users/new", SessionUserController, :new
    post "/sessions/:id/users", SessionUserController, :create
  end

  defp put_user_token(conn, _) do
    if current_user = get_session(conn, :current_user) do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      conn
        |> assign(:user_name, current_user.name)
        |> assign(:user_token, token)
    else
#      user_id = :crypto.strong_rand_bytes(15) |> Base.url_encode64() |> binary_part(0,15)
#      user = %{owner: false, name: "Guest", id: user_id}
#      token = Phoenix.Token.sign(conn, "user socket", user.id)
#
#      conn = put_session(conn, :current_user, user)
#      conn = assign(conn, :user_token, token)

      conn
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PokerWeb do
  #   pipe_through :api
  # end
end

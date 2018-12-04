defmodule PokerWeb.SessionController do
  use PokerWeb, :controller

  def show(conn, _params) do
    render conn, "show.html"
  end
end

defmodule PokerWeb.SessionChannel do
  use Phoenix.Channel

  def join("session:" <> session_id, _params, socket) do
    #{:error, %{reason: "unauthorized"}}
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_in("card_selected", %{"body" => body}, socket) do
    broadcast! socket, "card_selected", %{body: body}
    {:noreply, socket}
  end
end

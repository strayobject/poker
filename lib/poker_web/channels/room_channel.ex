defmodule PokerWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_session", %{"body" => body}, socket) do
    # redirect to a /session/<uuid> page with cards and chat
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_in("card_selected", %{"body" => body}, socket) do
    broadcast! socket, "card_selected", %{body: body}
    {:noreply, socket}
  end

  def handle_in("session_create", %{"sessionName" => sessionName, "sessionOwner" => sessionOwner}, socket) do

  end
end

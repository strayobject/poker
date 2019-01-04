defmodule PokerWeb.SessionChannel do
  use Phoenix.Channel

  def join("session:" <> _session_id, _params, socket) do
    #{:error, %{reason: "unauthorized"}}
    socket
      |> IO.inspect
    {:ok, socket}
  end

  def handle_in("card_selected", %{"body" => body}, socket) do
    socket |> IO.inspect
    broadcast! socket, "card_selected", %{body: body}
    {:noreply, socket}
  end
end

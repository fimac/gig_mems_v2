defmodule GigMemsV2Web.GigSearchLive do
  use Phoenix.LiveView
  alias GigMemsV2Web.GigView

  alias GigMemsV2.GigApi

  def render(assigns) do
    GigView.render("gig_search_live.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, gigs: [])}
  end

  def handle_event("search", %{"search_field" => %{"query" => query}}, socket) do
    gigs = GigApi.get_gig(query) |> GigApi.parse_response()
    {:noreply, assign(socket, gigs: gigs)}
  end
end

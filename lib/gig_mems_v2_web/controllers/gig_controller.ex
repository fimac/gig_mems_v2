defmodule GigMemsV2Web.GigController do
  use GigMemsV2Web, :controller

  def gig_search(conn, _params) do
    render(conn, "gig_search.html")
  end
end

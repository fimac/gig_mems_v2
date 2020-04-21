defmodule GigMemsV2Web.PageController do
  use GigMemsV2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

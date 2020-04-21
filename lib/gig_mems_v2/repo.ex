defmodule GigMemsV2.Repo do
  use Ecto.Repo,
    otp_app: :gig_mems_v2,
    adapter: Ecto.Adapters.Postgres
end

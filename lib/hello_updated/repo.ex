defmodule HelloUpdated.Repo do
  use Ecto.Repo,
    otp_app: :hello_updated,
    adapter: Ecto.Adapters.Postgres
end

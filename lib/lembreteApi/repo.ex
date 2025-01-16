defmodule LembreteApi.Repo do
  use Ecto.Repo,
    otp_app: :lembreteApi,
    adapter: Ecto.Adapters.Postgres
end

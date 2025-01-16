defmodule LembreteApi.Repo.Migrations.CreateLembretesTable do
  use Ecto.Migration

  def change do
    create table("lembretes") do
      add :name, :string
      add :date, :string
      timestamps()
    end
  end
end

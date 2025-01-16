defmodule LembreteApi.Core.Lembrete.Api do
  @moduledoc false

  import Ecto.Query
  alias LembreteApi.Repo
  alias LembreteApi.Core.Lembrete

  ## all
  def all do
    {:ok, Repo.all(Lembrete)}
  end

  ## get
  def get(id) do
    Repo.get(Lembrete, id)
    |> case do
      nil -> {:error, :not_found}
      lembrete -> {:ok, lembrete}
    end
  end

  ## get_by
  def get_by(where) do
    from(Lembrete)
    |> where(^where)
    |> Repo.one()
  end

  ## insert
  def insert(params) do
    # estrutura vazia
    %Lembrete{}
    |> Lembrete.changeset(params)
    |> Repo.insert()
  end

  ## update
  def update(model, params) do
    model
    |> Lembrete.changeset(params)
    |> Repo.update()
  end

  ## delete
  def delete(id) do
    case get(id) do
    {:ok, lembrete} -> Repo.delete(lembrete)
    error -> error
    end
  end

  ## json
  def json!(model, permission) do
    Map.take(model, Lembrete.permission(permission))
  end
end

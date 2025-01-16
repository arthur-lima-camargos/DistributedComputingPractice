defmodule LembreteApi.LembreteContext do
  # Funciona como Interface para lembrete_api.ex

  @moduledoc false

  alias LembreteApi.Core.Lembrete
  alias LembreteApi.Validate

  def all(_params) do
    case Lembrete.Api.all() do
      {:ok, lembretes} ->
        {:ok, lembretes |> Enum.map(&Lembrete.Api.json!(&1, :public))}

      # {:error, msg}
      error ->
        error
        # -> Não é interessante que LembreteContext tenha acesso a Lembretes
        # Apenas quem acessa essa classe será a API, para isso fazer a def json...
        # |> Enum.map(&Map.take(&1, Lembrete.permission(:public))) !!!
    end
  end

  def get(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- is_integer(id, "id"),
         {:ok, lembrete} <- Lembrete.Api.get(id) do
      {:ok, lembrete |> Lembrete.Api.json!(:public)}
    else
      error -> error
    end
  end

  def is_integer(value, field) do
    case Integer.parse(value) do
        {num, ""} -> {:ok, num}
        _->{:error, "#{field}: O valor do parâmetro deve ser um inteiro"}
    end
  end

  def create(params) do
    case Lembrete.Api.insert(params) do
        {:ok, lembrete} ->
            {:ok, lembrete |> Lembrete.Api.json!(:public)}
        {:error, %Ecto.Changeset {} = changeset} ->
            {:error, parse_errors(changeset)}
    end
  end

  defp parse_errors(changeset) do
    Enum.map(changeset.errors, fn
        {key, {msg, _}} -> "#{key}: #{msg}"
    end)
  end

  def update(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- is_integer(id, "id"),
         {:ok, lembrete} <- Lembrete.Api.get(id),
         {:ok, lembrete_updated} <- Lembrete.Api.update(lembrete, params) do
            {:ok, lembrete_updated |> Lembrete.Api.json!(:public)}
    else
        {:error, %Ecto.Changeset {} = changeset} ->
            {:error, parse_errors(changeset)}
        error -> error
    end
  end

  def delete(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- is_integer(id, "id"),
         {:ok, lembrete} <- Lembrete.Api.delete(id) do
      {:ok, lembrete |> Lembrete.Api.json!(:public)}
    else
      error -> error
    end
  end
end

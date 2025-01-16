defmodule LembreteApiWeb.LembretesController do
  @moduledoc false

  use LembreteApiWeb, :controller

  alias LembreteApi.LembreteContext

  def all(conn, params) do
    case LembreteContext.all(params) do
      {:ok, lembretes} ->
        json(conn, %{data: lembretes})

      {:error, msg} ->
        put_status(conn, 422)
        |> json(%{error: msg})
    end
  end

  def get(conn, params) do
    case LembreteContext.get(params) do
      {:ok, lembrete} ->
        json(conn, %{data: lembrete})

      {:error, msg} ->
        put_status(conn, 422)
        |> json(%{error: msg})
    end
  end

  def create(conn, params) do
    case LembreteContext.create(params) do
        {:ok, lembrete} ->
            json(conn, %{data: lembrete})

        {:error, msg} ->
        put_status(conn, 422)
        |> json(%{error: msg})
    end
  end

  def update(conn, params) do
    case LembreteContext.update(params) do
        {:ok, lembrete} ->
            json(conn, %{data: lembrete})

        {:error, msg} ->
        put_status(conn, 422)
        |> json(%{error: msg})
    end
  end

  def delete(conn, params) do
    case LembreteContext.delete(params) do
        {:ok, lembrete} ->
            json(conn, %{data: lembrete})

        {:error, msg} ->
        put_status(conn, 422)
        |> json(%{error: msg})
    end
  end
end

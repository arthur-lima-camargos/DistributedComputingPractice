defmodule LembreteApi.Validate do
  @moduledoc false

  def get_required(params, field) do
    case params[field] do
      nil -> {:error, "o campo `#{field} não existe ou é nulo.`"}
      value -> {:ok, value}
    end
  end
end

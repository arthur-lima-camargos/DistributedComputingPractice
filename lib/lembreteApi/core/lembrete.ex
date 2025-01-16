defmodule LembreteApi.Core.Lembrete do
    @moduledoc false

    use Ecto.Schema

    schema "lembretes" do
        field :name, :string
        field :date, :string

        timestamps() ## inserted_at e updated_at
    end

    # Retorno das requisições definido aqui:
    def permission(:public), do: [:id, :name, :date, :inserted_at, :updated_at]
    # Exemplo de aplicação:
    # def permission(:admin), do: [:id, :name, :date, :inserted_at, :updated_at, etc]

    def changeset(model, params) do
        model
        # Diz quais os parâmetros fazem parte desse fluxo
        |> Ecto.Changeset.cast(params, [:name, :date])
        # Valida se os campos virão preenchidos:
        |> Ecto.Changeset.validate_required([:name, :date])
    end
end

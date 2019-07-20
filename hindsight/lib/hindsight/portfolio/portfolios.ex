defmodule Hindsight.Portfolio.Portfolios do
  use Ecto.Schema
  import Ecto.Changeset

  schema "portfolios" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(portfolios, attrs) do
    portfolios
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

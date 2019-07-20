defmodule Hindsight.Profile.Profiles do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hindsight.Portfolio.Portfolios

  schema "profiles" do
    field :description, :string
    field :name, :string
    has_many(:portfolios, Portfolios)
    timestamps()
  end

  @doc false
  def changeset(profiles, attrs) do
    profiles
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

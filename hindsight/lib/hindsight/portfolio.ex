defmodule Hindsight.Portfolio do
  @moduledoc """
  The Portfolio context.
  """

  import Ecto.Query, warn: false
  alias Hindsight.Repo

  alias Hindsight.Portfolio.Portfolios

  @doc """
  Returns the list of portfolios.

  ## Examples

      iex> list_portfolios()
      [%Portfolios{}, ...]

  """
  def list_portfolios do
    Repo.all(Portfolios)
  end

  @doc """
  Gets a single portfolios.

  Raises `Ecto.NoResultsError` if the Portfolios does not exist.

  ## Examples

      iex> get_portfolios!(123)
      %Portfolios{}

      iex> get_portfolios!(456)
      ** (Ecto.NoResultsError)

  """
  def get_portfolios!(id), do: Repo.get!(Portfolios, id)

  @doc """
  Creates a portfolios.

  ## Examples

      iex> create_portfolios(%{field: value})
      {:ok, %Portfolios{}}

      iex> create_portfolios(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_portfolios(attrs \\ %{}) do
    %Portfolios{}
    |> Portfolios.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a portfolios.

  ## Examples

      iex> update_portfolios(portfolios, %{field: new_value})
      {:ok, %Portfolios{}}

      iex> update_portfolios(portfolios, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_portfolios(%Portfolios{} = portfolios, attrs) do
    portfolios
    |> Portfolios.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Portfolios.

  ## Examples

      iex> delete_portfolios(portfolios)
      {:ok, %Portfolios{}}

      iex> delete_portfolios(portfolios)
      {:error, %Ecto.Changeset{}}

  """
  def delete_portfolios(%Portfolios{} = portfolios) do
    Repo.delete(portfolios)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking portfolios changes.

  ## Examples

      iex> change_portfolios(portfolios)
      %Ecto.Changeset{source: %Portfolios{}}

  """
  def change_portfolios(%Portfolios{} = portfolios) do
    Portfolios.changeset(portfolios, %{})
  end
end

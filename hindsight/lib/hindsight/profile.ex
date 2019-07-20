defmodule Hindsight.Profile do
  @moduledoc """
  The Profile context.
  """

  import Ecto.Query, warn: false
  alias Hindsight.Repo

  alias Hindsight.Profile.Profiles

  @doc """
  Returns the list of profiles.

  ## Examples

      iex> list_profiles()
      [%Profiles{}, ...]

  """
  def list_profiles do
    Repo.all(Profiles)
  end

  @doc """
  Gets a single profiles.

  Raises `Ecto.NoResultsError` if the Profiles does not exist.

  ## Examples

      iex> get_profiles!(123)
      %Profiles{}

      iex> get_profiles!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profiles!(id), do: Repo.get!(Profiles, id)

  @doc """
  Creates a profiles.

  ## Examples

      iex> create_profiles(%{field: value})
      {:ok, %Profiles{}}

      iex> create_profiles(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profiles(attrs \\ %{}) do
    %Profiles{}
    |> Profiles.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profiles.

  ## Examples

      iex> update_profiles(profiles, %{field: new_value})
      {:ok, %Profiles{}}

      iex> update_profiles(profiles, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profiles(%Profiles{} = profiles, attrs) do
    profiles
    |> Profiles.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Profiles.

  ## Examples

      iex> delete_profiles(profiles)
      {:ok, %Profiles{}}

      iex> delete_profiles(profiles)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profiles(%Profiles{} = profiles) do
    Repo.delete(profiles)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profiles changes.

  ## Examples

      iex> change_profiles(profiles)
      %Ecto.Changeset{source: %Profiles{}}

  """
  def change_profiles(%Profiles{} = profiles) do
    Profiles.changeset(profiles, %{})
  end
end

defmodule HindsightWeb.ProfilesController do
  use HindsightWeb, :controller

  alias Hindsight.Profile
  alias Hindsight.Profile.Profiles

  def index(conn, _params) do
    profiles = Profile.list_profiles()
    render(conn, "index.html", profiles: profiles)
  end

  def new(conn, _params) do
    changeset = Profile.change_profiles(%Profiles{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"profiles" => profiles_params}) do
    case Profile.create_profiles(profiles_params) do
      {:ok, profiles} ->
        conn
        |> put_flash(:info, "Profiles created successfully.")
        |> redirect(to: Routes.profiles_path(conn, :show, profiles))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    profiles = Profile.get_profiles!(id)
    render(conn, "show.html", profiles: profiles)
  end

  def edit(conn, %{"id" => id}) do
    profiles = Profile.get_profiles!(id)
    changeset = Profile.change_profiles(profiles)
    render(conn, "edit.html", profiles: profiles, changeset: changeset)
  end

  def update(conn, %{"id" => id, "profiles" => profiles_params}) do
    profiles = Profile.get_profiles!(id)

    case Profile.update_profiles(profiles, profiles_params) do
      {:ok, profiles} ->
        conn
        |> put_flash(:info, "Profiles updated successfully.")
        |> redirect(to: Routes.profiles_path(conn, :show, profiles))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", profiles: profiles, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    profiles = Profile.get_profiles!(id)
    {:ok, _profiles} = Profile.delete_profiles(profiles)

    conn
    |> put_flash(:info, "Profiles deleted successfully.")
    |> redirect(to: Routes.profiles_path(conn, :index))
  end
end

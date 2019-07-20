defmodule HindsightWeb.ProfilesControllerTest do
  use HindsightWeb.ConnCase

  alias Hindsight.Profile

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:profiles) do
    {:ok, profiles} = Profile.create_profiles(@create_attrs)
    profiles
  end

  describe "index" do
    test "lists all profiles", %{conn: conn} do
      conn = get(conn, Routes.profiles_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Profiles"
    end
  end

  describe "new profiles" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_path(conn, :new))
      assert html_response(conn, 200) =~ "New Profiles"
    end
  end

  describe "create profiles" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_path(conn, :create), profiles: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_path(conn, :show, id)

      conn = get(conn, Routes.profiles_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Profiles"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_path(conn, :create), profiles: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Profiles"
    end
  end

  describe "edit profiles" do
    setup [:create_profiles]

    test "renders form for editing chosen profiles", %{conn: conn, profiles: profiles} do
      conn = get(conn, Routes.profiles_path(conn, :edit, profiles))
      assert html_response(conn, 200) =~ "Edit Profiles"
    end
  end

  describe "update profiles" do
    setup [:create_profiles]

    test "redirects when data is valid", %{conn: conn, profiles: profiles} do
      conn = put(conn, Routes.profiles_path(conn, :update, profiles), profiles: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_path(conn, :show, profiles)

      conn = get(conn, Routes.profiles_path(conn, :show, profiles))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, profiles: profiles} do
      conn = put(conn, Routes.profiles_path(conn, :update, profiles), profiles: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Profiles"
    end
  end

  describe "delete profiles" do
    setup [:create_profiles]

    test "deletes chosen profiles", %{conn: conn, profiles: profiles} do
      conn = delete(conn, Routes.profiles_path(conn, :delete, profiles))
      assert redirected_to(conn) == Routes.profiles_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_path(conn, :show, profiles))
      end
    end
  end

  defp create_profiles(_) do
    profiles = fixture(:profiles)
    {:ok, profiles: profiles}
  end
end

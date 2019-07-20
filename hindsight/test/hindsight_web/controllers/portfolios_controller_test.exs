defmodule HindsightWeb.PortfoliosControllerTest do
  use HindsightWeb.ConnCase

  alias Hindsight.Portfolio

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:portfolios) do
    {:ok, portfolios} = Portfolio.create_portfolios(@create_attrs)
    portfolios
  end

  describe "index" do
    test "lists all portfolios", %{conn: conn} do
      conn = get(conn, Routes.portfolios_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Portfolios"
    end
  end

  describe "new portfolios" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.portfolios_path(conn, :new))
      assert html_response(conn, 200) =~ "New Portfolios"
    end
  end

  describe "create portfolios" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.portfolios_path(conn, :create), portfolios: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.portfolios_path(conn, :show, id)

      conn = get(conn, Routes.portfolios_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Portfolios"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.portfolios_path(conn, :create), portfolios: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Portfolios"
    end
  end

  describe "edit portfolios" do
    setup [:create_portfolios]

    test "renders form for editing chosen portfolios", %{conn: conn, portfolios: portfolios} do
      conn = get(conn, Routes.portfolios_path(conn, :edit, portfolios))
      assert html_response(conn, 200) =~ "Edit Portfolios"
    end
  end

  describe "update portfolios" do
    setup [:create_portfolios]

    test "redirects when data is valid", %{conn: conn, portfolios: portfolios} do
      conn = put(conn, Routes.portfolios_path(conn, :update, portfolios), portfolios: @update_attrs)
      assert redirected_to(conn) == Routes.portfolios_path(conn, :show, portfolios)

      conn = get(conn, Routes.portfolios_path(conn, :show, portfolios))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, portfolios: portfolios} do
      conn = put(conn, Routes.portfolios_path(conn, :update, portfolios), portfolios: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Portfolios"
    end
  end

  describe "delete portfolios" do
    setup [:create_portfolios]

    test "deletes chosen portfolios", %{conn: conn, portfolios: portfolios} do
      conn = delete(conn, Routes.portfolios_path(conn, :delete, portfolios))
      assert redirected_to(conn) == Routes.portfolios_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.portfolios_path(conn, :show, portfolios))
      end
    end
  end

  defp create_portfolios(_) do
    portfolios = fixture(:portfolios)
    {:ok, portfolios: portfolios}
  end
end

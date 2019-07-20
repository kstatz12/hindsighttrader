defmodule Hindsight.PortfolioTest do
  use Hindsight.DataCase

  alias Hindsight.Portfolio

  describe "portfolios" do
    alias Hindsight.Portfolio.Portfolios

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def portfolios_fixture(attrs \\ %{}) do
      {:ok, portfolios} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portfolio.create_portfolios()

      portfolios
    end

    test "list_portfolios/0 returns all portfolios" do
      portfolios = portfolios_fixture()
      assert Portfolio.list_portfolios() == [portfolios]
    end

    test "get_portfolios!/1 returns the portfolios with given id" do
      portfolios = portfolios_fixture()
      assert Portfolio.get_portfolios!(portfolios.id) == portfolios
    end

    test "create_portfolios/1 with valid data creates a portfolios" do
      assert {:ok, %Portfolios{} = portfolios} = Portfolio.create_portfolios(@valid_attrs)
      assert portfolios.description == "some description"
      assert portfolios.name == "some name"
    end

    test "create_portfolios/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolio.create_portfolios(@invalid_attrs)
    end

    test "update_portfolios/2 with valid data updates the portfolios" do
      portfolios = portfolios_fixture()
      assert {:ok, %Portfolios{} = portfolios} = Portfolio.update_portfolios(portfolios, @update_attrs)
      assert portfolios.description == "some updated description"
      assert portfolios.name == "some updated name"
    end

    test "update_portfolios/2 with invalid data returns error changeset" do
      portfolios = portfolios_fixture()
      assert {:error, %Ecto.Changeset{}} = Portfolio.update_portfolios(portfolios, @invalid_attrs)
      assert portfolios == Portfolio.get_portfolios!(portfolios.id)
    end

    test "delete_portfolios/1 deletes the portfolios" do
      portfolios = portfolios_fixture()
      assert {:ok, %Portfolios{}} = Portfolio.delete_portfolios(portfolios)
      assert_raise Ecto.NoResultsError, fn -> Portfolio.get_portfolios!(portfolios.id) end
    end

    test "change_portfolios/1 returns a portfolios changeset" do
      portfolios = portfolios_fixture()
      assert %Ecto.Changeset{} = Portfolio.change_portfolios(portfolios)
    end
  end
end

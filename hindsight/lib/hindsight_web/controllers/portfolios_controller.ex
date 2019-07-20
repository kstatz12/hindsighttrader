defmodule HindsightWeb.PortfoliosController do
  use HindsightWeb, :controller

  alias Hindsight.Portfolio
  alias Hindsight.Portfolio.Portfolios

  plug :secure

  defp secure(conn, _) do
    user = get_session(conn, :current_user)
    case user do
      nil ->
        conn |> redirect(to: "/auth/auth0") |> halt
      _ ->
        conn |> assign(:current_user, user)
    end

  end

  def index(conn, _params) do
    portfolios = Portfolio.list_portfolios()
    render(conn, "index.html", portfolios: portfolios)
  end

  def new(conn, _params) do
    changeset = Portfolio.change_portfolios(%Portfolios{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"portfolios" => portfolios_params}) do
    case Portfolio.create_portfolios(portfolios_params) do
      {:ok, portfolios} ->
        conn
        |> put_flash(:info, "Portfolios created successfully.")
        |> redirect(to: Routes.portfolios_path(conn, :show, portfolios))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    portfolios = Portfolio.get_portfolios!(id)
    render(conn, "show.html", portfolios: portfolios)
  end

  def edit(conn, %{"id" => id}) do
    portfolios = Portfolio.get_portfolios!(id)
    changeset = Portfolio.change_portfolios(portfolios)
    render(conn, "edit.html", portfolios: portfolios, changeset: changeset)
  end

  def update(conn, %{"id" => id, "portfolios" => portfolios_params}) do
    portfolios = Portfolio.get_portfolios!(id)

    case Portfolio.update_portfolios(portfolios, portfolios_params) do
      {:ok, portfolios} ->
        conn
        |> put_flash(:info, "Portfolios updated successfully.")
        |> redirect(to: Routes.portfolios_path(conn, :show, portfolios))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", portfolios: portfolios, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    portfolios = Portfolio.get_portfolios!(id)
    {:ok, _portfolios} = Portfolio.delete_portfolios(portfolios)

    conn
    |> put_flash(:info, "Portfolios deleted successfully.")
    |> redirect(to: Routes.portfolios_path(conn, :index))
  end
end

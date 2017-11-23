defmodule MarshmashowWeb.UserView do
  use MarshmashowWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
    }
  end
end

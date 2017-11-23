defmodule Marshmashow.ShowTest do
  use MarshmashowWeb.DataCase

  alias Marshmashow.Show

  @valid_attrs %{synopsys: "some content", title: "some content", year: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Show.changeset(%Show{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Show.changeset(%Show{}, @invalid_attrs)
    refute changeset.valid?
  end
end

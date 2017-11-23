defmodule Marshmashow.EpisodeTest do
  use MarshmashowWeb.DataCase

  alias Marshmashow.Episode

  @valid_attrs %{number: 42, released: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, season: 42, synopsys: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Episode.changeset(%Episode{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Episode.changeset(%Episode{}, @invalid_attrs)
    refute changeset.valid?
  end
end

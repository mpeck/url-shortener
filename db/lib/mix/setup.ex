defmodule Mix.Tasks.Db.Setup do
  @shortdoc """
  Sets up the persistence layer for the URL Shortening service
  """

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    DB.setup!()
  end
end

defmodule BangersAndMash.Browser.UITest do
  use Hound.Helpers

  def run do
    fill_field({:id, "username"}, "Me")
    fill_field({:id, "password"}, "Pass")
    submit_element({:id, "password"})

    click({:id, "link"})

    String.contains?(inner_html({:id, "body"}), "text")
  end
end

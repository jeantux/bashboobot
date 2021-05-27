defmodule BashboobotTest do
  use ExUnit.Case
  doctest Bashboobot

  test "greets the world" do
    assert Bashboobot.hello() == :world
  end
end

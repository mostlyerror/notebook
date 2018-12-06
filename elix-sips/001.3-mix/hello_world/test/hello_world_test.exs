defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "division" do
    {:ok, result} = HelloWorld.div(2, 1)
    assert result == 2.0
  end

  test "division by zero" do
    {:error, err} = HelloWorld.div(1, 0)
    assert err == "attempt to divide by zero" 
  end

  test "pipes and strings" do
    import String
    val =
      "josh"
        |> reverse
        |> capitalize
        |> reverse
    assert val == "josH"
  end
end

defmodule ForPlaygroundTest do
  use ExUnit.Case

  test "basic for comprehensions" do
    result = for i <- [1, 2, 3], do: i
    assert [1, 2, 3] == result
  end

  test "basic for comprehensions 2" do
    result = 
      for i <- [1, 2, 3] do
        i
      end
    assert [1, 2, 3] == result
  end

  test "generating a deck of cards" do
    suits = [:clubs, :diamonds, :hearts, :spades]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
    all_cards =
      [
        {2, :clubs},
        {3, :clubs},
        {4, :clubs},
        {5, :clubs},
        {6, :clubs},
        {7, :clubs},
        {8, :clubs},
        {9, :clubs},
        {10, :clubs},
        {:jack, :clubs},
        {:queen, :clubs},
        {:king, :clubs},
        {:ace, :clubs},
        {2, :diamonds},
        {3, :diamonds},
        {4, :diamonds},
        {5, :diamonds},
        {6, :diamonds},
        {7, :diamonds},
        {8, :diamonds},
        {9, :diamonds},
        {10, :diamonds},
        {:jack, :diamonds},
        {:queen, :diamonds},
        {:king, :diamonds},
        {:ace, :diamonds},
        {2, :hearts},
        {3, :hearts},
        {4, :hearts},
        {5, :hearts},
        {6, :hearts},
        {7, :hearts},
        {8, :hearts},
        {9, :hearts},
        {10, :hearts},
        {:jack, :hearts},
        {:queen, :hearts},
        {:king, :hearts},
        {:ace, :hearts},
        {2, :spades},
        {3, :spades},
        {4, :spades},
        {5, :spades},
        {6, :spades},
        {7, :spades},
        {8, :spades},
        {9, :spades},
        {10, :spades},
        {:jack, :spades},
        {:queen, :spades},
        {:king, :spades},
        {:ace, :spades}
      ]
    result = 
      for suit <- suits,
          rank <- ranks,
          do: {rank, suit}

    assert all_cards == result
  end

  test "filters in for comprehensions" do
    result =
      for i <- 0..10, rem(i, 2) == 0 do
        i
      end
    assert result == [0, 2, 4, 6, 8, 10]
  end

  test "filters 2" do
    multiple_of_3? = fn(n) -> rem(n, 3) == 0 end
    result = for n <- 0..15, multiple_of_3?.(n), do: n * n
    assert result == [0, 9, 36, 81, 144, 225]
  end

  test "collecting results into a map" do
    # we'll use the `into` option to specify a diff term to collect into
    result =
      for i <- 0..2, into: %{} do
        # when collecting into maps, you're expected to return a 2-tuple with 
        # the key and value
        {"#{i}", i}
      end

    assert result == %{"0" => 0, "1" => 1, "2" => 2}
  end

  test "collecting into map 2" do
    result = 
      for {key, val} <- %{"a" => 1, "b" => 2}, into: %{} do
        {key, val * val}
      end

    assert result == %{"a" => 1, "b" => 4}
  end

  test "collecting into string" do
    result = for <<c <- " hello world " >>, c != ?\s, into: "", do: <<c>>
    assert result == "helloworld"
  end

  test "pattern matching in comprehensions" do
    values = [good: 1, good: 2, bad: 3, good: 4]
    result = for {:good, n} <- values, do: n * n
    assert result == [1, 4, 16]
  end


end

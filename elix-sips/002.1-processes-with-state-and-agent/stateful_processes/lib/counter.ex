defmodule Counter do
  def start(initial_value) do
    # {:ok, spawn(Counter, :loop, [initial_value])}
    # 
    # starting an agent just requires giving it a function that returns the
    # agen'ts initial value
    Agent.start(fn -> initial_value end)
  end

  def get_value(pid) do
    # to get the value, we pass a fn that receives the agent's state and
    # returns whatever we want - in our case, we want to wrap the value in an 
    # `:ok` 2-tuple.
    Agent.get(pid, fn(x) -> {:ok, x} end)
  end

  def increment(pid) do
    # to increment, we send a function that tells the agent what to do with its
    # state.
    Agent.update(pid, fn(x) -> x + 1 end)
  end

  def decrement(pid) do
    # to decrement, we send a function that tells the agent what to do with its
    # state.
    Agent.update(pid, fn(x) -> x - 1 end)
  end

  # def loop(value) do
  #   receive do
  #     # in our loop we'll expect to be told who a message is from, a ref that is
  #     # unique to their request, and a term that tells us what to do - in this 
  #     # case, get the value of the counter.
  #     #
  #     # we'll send the value back with the ref so they know it's the appropriate
  #     # response, and then we'll tail-call with the existing value
  #     {from, ref, :get_value} ->
  #       send(from, {:ok, ref, value})
  #       loop(value)
  #     :increment ->
  #       loop(value + 1)
  #     :decrement ->
  #       loop(value - 1)
  #   end
  # end

  # # then we just make the function to interact with our process loop
  # def get_value(pid) do
  #   ref = make_ref()
  #   send(pid, {self(), ref, :get_value})
  #   receive do
  #     {:ok, ^ref, val} -> {:ok, val}
  #   end
  # end

  # def increment(pid) do
  #   send(pid, :increment)
  #   :ok
  # end

  # def decrement(pid) do
  #   send(pid, :decrement)
  #   :ok
  # end
end

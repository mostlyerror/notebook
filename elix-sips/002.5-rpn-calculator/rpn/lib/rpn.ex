defmodule Rpn do
  def start do
    {:ok, spawn(__MODULE__, :loop, [[]])}
  end

  def loop(stack) do
   receive do
    # receive msg form another pid, with a ref, and the atom `peek.
    # send back 2-tuple containing the ref and the value of our stack.
    {from, ref, :peek} ->
      send(from, {ref, stack})
      loop(stack)

    {:push, :+} ->
      [second | [first | rest]] = stack
      loop([first + second | rest])

    {:push, :-} ->
      [second | [first | rest]] = stack
      loop([first - second | rest])

    {:push, :x} ->
      [second | [first | rest]] = stack
      loop([first * second | rest])

    {:push, val} ->
      loop([val | stack])
   end
  end

  # provide func that makes it easy to send the message the loop is wiating for
  # and then enters a receive loop of its own, awaiting a reply. the reason we
  # make these unique references is because anyone could send us a message at
  # any time, and if it matched the pattern we were looking for we would accept
  # it - this way we only match the messages we're hoping to get back.
  def peek(pid) do
    ref = make_ref()
    send(pid, {self(), ref, :peek})
    receive do
      {^ref, val} -> val
    end
  end

  def push(pid, val) do
    send(pid, {:push, val})
  end
end

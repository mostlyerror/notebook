defmodule Upcaser do
  def start do
    pid = spawn(Upcaser, :loop, [])
    {:ok, pid}
  end

  def loop do
    # listen for the messages we care about, and when we get one we'll
    # send the updated data back.
    receive do
      {from, ref, {:upcase, str}} -> send(from, {:ok, ref, String.upcase(str)})
    end
    loop()
  end

  def upcase(server_pid, str) do
    ref = make_ref()
    # send the server a request to upcase
    send(server_pid, {self(), ref, {:upcase, str}})
    # then we'll block, waiting to get a response. Once we do, we'll return it.
    receive do
      # here we're 'pinning' the ref variable - we're saying we only match where
      # the second element in the tuple matches a given variable, without the 
      # pin(^), this would rebind the `ref` var
      {:ok, ^ref, str} -> {:ok, str}
    end
  end
end

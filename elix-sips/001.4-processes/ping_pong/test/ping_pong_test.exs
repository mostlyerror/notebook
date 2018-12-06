defmodule PingPongTest do
  use ExUnit.Case
  doctest PingPong

  test "it responds to a pong with a ping" do
    # spawn takes a module, func name, list of args
    # starts a new process, running the func. when the func
    # returns, new process dies.
    ping = spawn(Ping, :start, [])
    # send data lets you send messages to a process
    # self provides the current process's PID, or Process ID
    send(ping, {:pong, self()})
    # assert that when we send a pong to a proc, we receive back a ping
    # this waits for up to 100ms and passes if the message is receifed in that
    # time frame, failing if it does not.
    assert_receive {:ping, ^ping}
  end

  test "it responds to two messages" do
    ping = spawn(Ping, :start, [])
    send(ping, {:pong, self()})
    assert_receive {:ping, ^ping}
    send(ping, {:pong, self()})
    assert_receive {:ping, ^ping}
  end
end

defmodule UpcaserTest do
  use ExUnit.Case
  doctest Upcaser

  test "starting the service" do
    assert {:ok, upcaser_pid} = Upcaser.start
    assert is_pid(upcaser_pid)
  end

  test "sending a string to be upcased" do
    # start the service
    {:ok, upcaser_pid} = Upcaser.start
    # send a string and get the expected response
    # send(upcaser_pid, {self(), {:upcase, "foo"}})
    # assert_receive {:ok, "FOO"}
    assert {:ok, "FOO"} = Upcaser.upcase(upcaser_pid, "foo")
  end


  #  test "responds with upcased string message when sent a string" do
  #    service = spawn(Upcaser, :start, [])
  #    send(service, {"some string", self()})
  #    assert_receive({:ok, "SOME STRING"})
  #  end

  #  test "responds with upcased string message each time when sent a string more than once" do
  #    service = spawn(Upcaser, :start, [])
  #    send(service, {"some string", self()})
  #    assert_receive({:ok, "SOME STRING"})
  #    send(service, {"another string", self()})
  #    assert_receive({:ok, "ANOTHER STRING"})
  #  end
end

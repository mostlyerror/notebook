defmodule HelloWorld do
  def div(a, 0) do
    {:error, "attempt to divide by zero"}
  end

  def div(a, b) do 
    {:ok, a / b}
  end
end

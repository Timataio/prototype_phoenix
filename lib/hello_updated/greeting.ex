defmodule Greeting do
	use Agent

	defstruct [:text, :inventor]
end
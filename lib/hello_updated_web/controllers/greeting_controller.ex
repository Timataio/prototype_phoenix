defmodule HelloUpdatedWeb.GreetingController do
  use HelloUpdatedWeb, :controller

  def greetlist(conn, _params) do
    render(conn, :greeting, greetings: Agent.get(:greetings, fn state -> state end))
  end
  
  def newgreeting(conn, _params) do
	Agent.update(:greetings, fn state -> [%Greeting{text: conn.body_params["greeting"], inventor: "You"} | state] end)
	redirect(conn, to: ~p"/home")
  end
  
  def customgreeting(conn, %{"greeting" => greeting}) do
	render(conn, :customgreet, greeting: greeting)
  end
end

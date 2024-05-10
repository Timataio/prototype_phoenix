defmodule HelloUpdatedWeb.GreetingHTML do
  use HelloUpdatedWeb, :html
  
  embed_templates "greeting_html/*"
  
end
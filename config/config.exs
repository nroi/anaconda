use Mix.Config

config :anaconda,
  # the prefix to use when sending the shortened URL in the response body
  url_prefix: "http://alarm.local:4072",

  # the length of the trailing random string attached to the url_prefix
  length: 5,

  # which port to  listen on
  port: 4072

use Mix.Config

config :pdf_generator,
  wkhtml_path: "/usr/bin/wkhtmltopdf",
#   pdftk_path:  "/usr/bin/pdftk",
  command_prefix:   nil

import_config "#{Mix.env}.exs"

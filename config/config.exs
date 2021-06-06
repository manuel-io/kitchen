use Mix.Config

config :kitchenlog, cowboy_port: 6000
config :kitchenlog, cowboy_interface: { 127, 0, 0, 1 }

config :kitchenlog, KitchenLog.Repo,
  hostname: System.get_env("KITCHENLOG_HOST") || "127.0.0.1",
  database: System.get_env("KICHENLOG_DBNAME") || "kitchenlog",
  username: System.get_env("KITCHNLOG_USR") || "kitchenlog",
  password: System.get_env("KITCHENLOG_PWD")

config :mix_systemd,
  release_name: Mix.env(),
  app_user: "kitchenlog",
  app_group: "kitchenlog",
  base_dir: "/home",

  env_vars: [
  ],

  dirs: [
    :runtime,
    :configuration,
  ],

  env_files: [
    ["-", :configuration_dir, "/environment"],
  ]

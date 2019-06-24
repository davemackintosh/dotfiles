return {
  locale = {
    "en_GB",
    keyboard = "us",
    encoding = "UTF-8",

    timezone = "Europe",
    place    = "London",
  },

  drives = {
    volGroupName = "vg0",
    drive        = exec("lsblk -d -p -n -l -o NAME -e 7,11"),
  },

  machine = {
    hostname = "ordoabchao",
  },
}


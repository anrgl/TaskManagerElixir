# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskManager.Repo.insert!(%TaskManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_01@example.com",
  first_name: "Example 01",
  last_name: "Example 01",
  role: "ADMIN",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_02@example.com",
  first_name: "Example 02",
  last_name: "Example 02",
  role: "MANAGER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_03@example.com",
  first_name: "Example 03",
  last_name: "Example 03",
  role: "DEVELOPER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_04@example.com",
  first_name: "Example 04",
  last_name: "Example 04",
  role: "ADMIN",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_05@example.com",
  first_name: "Example 05",
  last_name: "Example 05",
  role: "MANAGER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_06@example.com",
  first_name: "Example 06",
  last_name: "Example 06",
  role: "DEVELOPER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_07@example.com",
  first_name: "Example 07",
  last_name: "Example 07",
  role: "ADMIN",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_08@example.com",
  first_name: "Example 08",
  last_name: "Example 08",
  role: "MANAGER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_09@example.com",
  first_name: "Example 09",
  last_name: "Example 09",
  role: "DEVELOPER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_10@example.com",
  first_name: "Example 10",
  last_name: "Example 10",
  role: "ADMIN",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_11@example.com",
  first_name: "Example 11",
  last_name: "Example 11",
  role: "MANAGER",
  hashed_password: "f00bar"
})

TaskManager.Repo.insert!(%TaskManager.Users.User{
  email: "email_12@example.com",
  first_name: "Example 12",
  last_name: "Example 12",
  role: "DEVELOPER",
  hashed_password: "f00bar"
})

defmodule TaskManager.Repo do
  use Ecto.Repo,
    otp_app: :task_manager,
    adapter: Ecto.Adapters.Postgres

  use TaskManager.Core.OffsetPaginator,
    page_size: 10,
    maximum_page_size: 100
end

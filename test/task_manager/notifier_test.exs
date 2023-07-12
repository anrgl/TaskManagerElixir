defmodule TaskManager.NotifierTest do
  use TaskManager.DataCase
  use TaskManager.Factory

  import Swoosh.TestAssertions

  alias TaskManager.Tasks
  alias TaskManager.Tasks.Task
  alias TaskManager.Notifiers.UserNotifier

  @moduletag :notifier_unittests

  describe "notifier" do
    test "performer notification" do
      task_params = params_with_assocs(:new_task)

      assert {:ok, %Task{} = task} = Tasks.create_task(task_params)
      assert_email_sent(UserNotifier.notification(task))
    end
  end
end

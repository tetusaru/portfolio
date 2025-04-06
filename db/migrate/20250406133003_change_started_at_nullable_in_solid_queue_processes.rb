class ChangeStartedAtNullableInSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def change
    change_column_null :solid_queue_processes, :started_at, true
  end
end


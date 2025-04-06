class AddPriorityToSolidQueueReadyExecutions < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:solid_queue_ready_executions, :priority)
      add_column :solid_queue_ready_executions, :priority, :integer, default: 0, null: false
    end
  end
end

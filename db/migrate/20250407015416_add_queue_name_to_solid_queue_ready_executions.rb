class AddQueueNameToSolidQueueReadyExecutions < ActiveRecord::Migration[7.1]
  def change
    add_column :solid_queue_ready_executions, :queue_name, :string, null: false, default: "default"
  end
end

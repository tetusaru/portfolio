class AddPriorityAndIndexesToSolidQueueReadyExecutions < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:solid_queue_ready_executions, :priority)
      add_column :solid_queue_ready_executions, :priority, :integer, default: 0, null: false
    end

    add_index :solid_queue_ready_executions, [ :priority, :job_id ], name: "index_solid_queue_poll_all" unless index_exists?(:solid_queue_ready_executions, [ :priority, :job_id ])
    add_index :solid_queue_ready_executions, [ :queue_name, :priority, :job_id ], name: "index_solid_queue_poll_by_queue" unless index_exists?(:solid_queue_ready_executions, [ :queue_name, :priority, :job_id ])
  end
end

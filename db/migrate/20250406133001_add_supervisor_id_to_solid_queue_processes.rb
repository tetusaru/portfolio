class AddSupervisorIdToSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def change
    add_column :solid_queue_processes, :supervisor_id, :bigint unless column_exists?(:solid_queue_processes, :supervisor_id)
    add_index  :solid_queue_processes, :supervisor_id unless index_exists?(:solid_queue_processes, :supervisor_id)
  end
end

class AddMissingColumnsToSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def change
    add_column :solid_queue_processes, :pid, :integer, null: false unless column_exists?(:solid_queue_processes, :pid)
    add_column :solid_queue_processes, :hostname, :string unless column_exists?(:solid_queue_processes, :hostname)
    add_column :solid_queue_processes, :metadata, :text unless column_exists?(:solid_queue_processes, :metadata)
  end
end

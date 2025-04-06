class AddMissingColumnsToSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def change
    add_column :solid_queue_processes, :pid, :integer, null: false
    add_column :solid_queue_processes, :hostname, :string
    add_column :solid_queue_processes, :metadata, :text
  end
end

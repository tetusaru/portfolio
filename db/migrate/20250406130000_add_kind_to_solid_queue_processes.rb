class AddKindToSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def change
    add_column :solid_queue_processes, :kind, :string, null: false
  end
end

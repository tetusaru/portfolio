class AddStartedAtToSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def change
    add_column :solid_queue_processes, :started_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' } unless column_exists?(:solid_queue_processes, :started_at)
  end
end

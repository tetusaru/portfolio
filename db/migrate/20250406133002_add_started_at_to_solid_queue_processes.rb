class AddStartedAtToSolidQueueProcesses < ActiveRecord::Migration[7.1]
  def up
    unless column_exists?(:solid_queue_processes, :started_at)
      execute <<~SQL
        ALTER TABLE solid_queue_processes
        ADD COLUMN started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
      SQL
    end
  end

  def down
    if column_exists?(:solid_queue_processes, :started_at)
      remove_column :solid_queue_processes, :started_at
    end
  end
end

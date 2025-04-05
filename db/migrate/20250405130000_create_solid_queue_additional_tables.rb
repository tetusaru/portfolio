class CreateSolidQueueAdditionalTables < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queue_ready_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.timestamps
    end

    create_table :solid_queue_failed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.text :error
      t.datetime :failed_at
      t.timestamps
    end

    create_table :solid_queue_completed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.datetime :completed_at
      t.timestamps
    end
  end
end

class CreateSolidQueueReadyExecutions < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queue_ready_executions, if_not_exists: true do |t|
      t.bigint :job_id, null: false
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false
      t.datetime :created_at, null: false

      t.index :job_id, unique: true
      t.index [ :priority, :job_id ], name: "index_solid_queue_poll_all"
      t.index [ :queue_name, :priority, :job_id ], name: "index_solid_queue_poll_by_queue"
    end
  end
end

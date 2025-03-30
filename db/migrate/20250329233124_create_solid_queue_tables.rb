class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string   :queue_name,    null: false
      t.string   :class_name,    null: false
      t.text     :arguments
      t.integer  :priority,      default: 0, null: false
      t.string   :active_job_id
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.string   :concurrency_key
      t.datetime :created_at,    null: false
      t.datetime :updated_at,    null: false
    end

    add_index :solid_queue_jobs, :active_job_id
    add_index :solid_queue_jobs, :class_name
    add_index :solid_queue_jobs, :finished_at
    add_index :solid_queue_jobs, [:queue_name, :finished_at], name: "index_solid_queue_jobs_for_filtering"
    add_index :solid_queue_jobs, [:scheduled_at, :finished_at], name: "index_solid_queue_jobs_for_alerting"
  end
end
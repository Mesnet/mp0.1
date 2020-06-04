json.extract! task, :id, :title, :description, :date, :done_at, :done_by, :parent_id, :activ, :position, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)

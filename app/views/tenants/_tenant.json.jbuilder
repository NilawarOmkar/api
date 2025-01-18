json.extract! tenant, :id, :name, :user_id, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)

json.extract! product, :id, :name, :description, :tenant_id, :created_at, :updated_at
json.url product_url(product, format: :json)

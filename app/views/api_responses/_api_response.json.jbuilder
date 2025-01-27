json.extract! api_response, :id, :data, :created_at, :updated_at
json.url api_response_url(api_response, format: :json)

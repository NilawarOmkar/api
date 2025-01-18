class ApiDataController < ApplicationController
  require "httparty"

  def store
    token = "eyJraWQiOiJNT2d0Yk9rQm9kWFdwdUJ5K28yOTc3Z0NEVXdsc01zS08wM0pXVUxORmk4PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI5YmZhY2YyMC04OTgxLTQ3MjYtOTcxZi1kZmNjYzhjYjcxNGUiLCJsYXN0X2xvZ2luIjoiMjAyNS0wMS0xOFQxMDowMzowMC4xODYyNTIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV90dXJERTBwdWwiLCJjb2duaXRvOnVzZXJuYW1lIjoiOWJmYWNmMjAtODk4MS00NzI2LTk3MWYtZGZjY2M4Y2I3MTRlIiwiYXBwczpkZWZhdWx0IjoiYjRjIiwibWZhX2NvbXBsZXRlIjoidHJ1ZSIsImN1c3RvbTptZmFUeXBlIjoiaW5pdCIsImF1ZCI6IjNqMTdwbm9qaTNudTkwcWhpcG5qdnJoNTdrIiwiZXZlbnRfaWQiOiIzZjZiMjE1My0xNmEzLTRlN2QtYWIwNy1mYzhjMmNkNmI3ZjAiLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTczNzE5NjgwNSwibWZhX3JlcXVpcmVkIjoiZmFsc2UiLCJleHAiOjE3MzcyMDA0MDUsImlhdCI6MTczNzE5NjgwNSwiZW1haWwiOiJzYXhlbmEuYW5zaHVsQGdtYWlsLmNvbSJ9.ay7qIz0h9Wh_z9mE8_GDV2UuTJuS1YRhYcOxD593M6Xj3NguWbomkxQMMb27CXzhxBlbe5xCVC7W-4-KtX-CwRChd673exyJ1Wc6JcIqcN-SKg42uZQ-2Ae9QhtPLW4TrHym-Wkhjg0Vz0cCXYwIp6pRCnIKvZXbW-eAvdM0bTn5nSKx3lwbpNdim8nHY7gAkNvRYz2R0vSy4wTwET5wUm50csjqqfqgpF5Fx_7fqS_ft1x2df2tS1Eo-e1i17TIYM8b-E6Tvu1yauao2qyIjPjLMyITpBGblS06TkKCWHMdyBn42Fgcbw85wLNH5-xOfUdG1WbW1IdQGFXbqpslAQ" # Replace this with your actual token
    api_url = "https://api.getbuilt.com/user-management-product-api/graphql" # Replace with your API endpoint
    graphql_query = <<-GRAPHQL
      query {
        me {
          id
          firstName
          lastName
          email
          tenantId
          currentTenant {
            id
            name
            products {
              id
              name
              description
            }
          }
          tenants {
            id
          }
        }
      }
    GRAPHQL

    # Prepare the payload for the POST request
    payload = {
      query: graphql_query
    }
    # Make the API call
    response = HTTParty.post(api_url,
      headers: {
        "Authorization" => "Bearer #{token}",
        "Content-Type" => "application/json"
      },
      body: payload.to_json  # Convert the payload to JSON
    )

    if response.success?
      save_data(response.parsed_response)
      render json: { message: "Data fetched and stored successfully" }, status: :ok
    else
      render json: { error: "Failed to fetch data from API: #{response.message}" }, status: :unprocessable_entity
    end
  end

  private

  def save_data(response)
    user_data = response["data"]["me"]

    # Save User
    user = User.find_or_initialize_by(id: user_data["id"])
    user.update(
      first_name: user_data["firstName"],
      last_name: user_data["lastName"],
      email: user_data["email"],
      tenant_id: user_data["tenantId"],
      current_tenant_id: user_data["currentTenant"]["id"]
    )

    # Save Current Tenant
    tenant_data = user_data["currentTenant"]
    tenant = Tenant.find_or_initialize_by(id: tenant_data["id"])
    tenant.update(
      name: tenant_data["name"],
      user_id: user.id
    )

    # Save Products
    tenant_data["products"].each do |product_data|
      product = Product.find_or_initialize_by(id: product_data["id"])
      product.update(
        name: product_data["name"],
        description: product_data["description"],
        tenant_id: tenant.id
      )
    end
  end
end

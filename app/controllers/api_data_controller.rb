class ApiDataController < ApplicationController
  require "httparty"

  def store
    token = "eyJraWQiOiJNT2d0Yk9rQm9kWFdwdUJ5K28yOTc3Z0NEVXdsc01zS08wM0pXVUxORmk4PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI5YmZhY2YyMC04OTgxLTQ3MjYtOTcxZi1kZmNjYzhjYjcxNGUiLCJsYXN0X2xvZ2luIjoiMjAyNS0wMS0yN1QwNToyMzo0NC4xNTM3NTciLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV90dXJERTBwdWwiLCJjb2duaXRvOnVzZXJuYW1lIjoiOWJmYWNmMjAtODk4MS00NzI2LTk3MWYtZGZjY2M4Y2I3MTRlIiwiYXBwczpkZWZhdWx0IjoiYjRjIiwibWZhX2NvbXBsZXRlIjoidHJ1ZSIsImN1c3RvbTptZmFUeXBlIjoiaW5pdCIsImF1ZCI6IjNqMTdwbm9qaTNudTkwcWhpcG5qdnJoNTdrIiwiZXZlbnRfaWQiOiJkOTU1NWMzNS0zOWEzLTRmNGYtYmQ4Yy1iMjZhYTI2NGEzOWMiLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTczNzk1NzI2OCwibWZhX3JlcXVpcmVkIjoiZmFsc2UiLCJleHAiOjE3Mzc5NjA4NjcsImlhdCI6MTczNzk1NzI2OCwiZW1haWwiOiJzYXhlbmEuYW5zaHVsQGdtYWlsLmNvbSJ9.g-w6764TzwsQLCPvKqff0MnwPSIMaBBad-hmCPfvdyKaxSOYJqrCaDrgv-aT6sRyNsCn8lLMFDzqF7dXVYNImt8EjK7xiNw-Q3H43SniDT-h3_Kpd2WxpNJnGeVG3lb59TjWEYUO8ehLUisO9ECT0EjgpnVXruEswIfV3gbKXTScqh1PpKxBRYxIYuCc6yUtPcccaZSL3Hj-a_7HNzaqwB-vKTs1wCxCi8l5NL1hMS99i1cjqO40Q9mrVrpcdyAoCziDS8WdCy8k8aLq2rsIE8IyU___um7ex-9GOnEKPVF3TSNtfDocY39WAxnVfEpMySvCvdlL6jowESRl21D-Aw" # Replace this with your actual token
    api_url = "https://api.getbuilt.com/user-management-product-api/graphql"
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


    payload = {
      query: graphql_query
    }

    response = HTTParty.post(api_url,
      headers: {
        "Authorization" => "Bearer #{token}",
        "Content-Type" => "application/json"
      },
      body: payload.to_json
    )

    if response.success?
      save_api_response(response.body)
      render json: { message: "Data fetched and stored successfully" }, status: :ok
    else
      render json: { error: "Failed to fetch data from API: #{response.message}" }, status: :unprocessable_entity
    end
  end

  def index
    @data = ApiResponse.all
    @parsed_responses = @data.map do |response|
      JSON.parse(response.data)
    end
  end

  private

  def save_api_response(response_body)
    ApiResponse.create!(data: response_body)
  end
end

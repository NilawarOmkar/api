class User < ApplicationRecord
  belongs_to :current_tenant, class_name: "Tenant", optional: true
  has_many :tenants
end

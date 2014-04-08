class RolesUsers < ActiveRecord::Base
  validates_uniqueness_of :role_id, scope: :user_id
end

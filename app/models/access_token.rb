# == Schema Information
#
# Table name: access_tokens
#
#  id         :bigint           not null, primary key
#  owner_type :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint
#
# Indexes
#
#  index_access_tokens_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_access_tokens_on_token                    (token) UNIQUE
#

# AccessToken represents a secure token that can be used to authenticate
# a user or an application. It has a polymorphic owner, meaning it can
# belong to different types of models (e.g., User, PlatformApp).
class AccessToken < ApplicationRecord
  has_secure_token :token
  belongs_to :owner, polymorphic: true
end

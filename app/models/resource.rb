# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  amount        :integer
#  availability  :boolean
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  categories_id :bigint
#
# Indexes
#
#  index_resources_on_categories_id  (categories_id)
#
# Foreign Keys
#
#  fk_rails_...  (categories_id => categories.id)
#
class Resource < ApplicationRecord
end

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
#  category_id   :bigint
#
# Indexes
#
#  index_resources_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Resource < ApplicationRecord
  belongs_to :category

  def available?
    availability && amount > 0
  end
end

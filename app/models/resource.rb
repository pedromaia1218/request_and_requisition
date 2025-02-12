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
#
class Resource < ApplicationRecord
end

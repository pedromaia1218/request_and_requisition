# == Schema Information
#
# Table name: requests
#
#  id             :bigint           not null, primary key
#  description    :text
#  priority       :string
#  status         :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  assigned_to_id :bigint
#  resource_id    :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_requests_on_assigned_to_id  (assigned_to_id)
#  index_requests_on_resource_id     (resource_id)
#  index_requests_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (assigned_to_id => users.id)
#  fk_rails_...  (resource_id => resources.id)
#  fk_rails_...  (user_id => users.id)
#
class Request < ApplicationRecord
  belongs_to :resource
  belongs_to :user
  belongs_to :assigned_to, class_name: 'User', optional: true

  validates :resource, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { low: 'low', medium: 'medium', high: 'high' }
  enum status: { open: 'open', accepted: 'accepted', rejected: 'rejected', closed: 'closed' }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= 'open'
  end
end

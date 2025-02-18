class NotificationObserver
  def initialize(user)
    @user = user
  end

  def update(request)
    Notification.create!(
      user: @user,
      request: request,
      message: "O status da solicitação '#{request.title}' foi alterado para '#{request.status}'."
    )
  end
end

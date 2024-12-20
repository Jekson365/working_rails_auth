class HardJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(user, post, notification)
    Notification.create(user_id: user.id, post_id: post.id, notification:)
    # NotificationChannel.broadcast_to(
    #   user,
    #   notification: "",
    #   post_id: post.id,
    #   timestamp: Time.current
    # )
  end
end

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def button_clicked(data)
    notification = Notification.create(post_id: Post.first.id,user_id: User.first.id,notification: data['message'])
    ActionCable.server.broadcast("chat_channel", notification)
  end
end

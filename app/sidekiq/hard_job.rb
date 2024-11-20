class HardJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(name = nil)
    if name == nil
      name = 'Jeko'
    end
    p "hello world #{name}"
  end
end

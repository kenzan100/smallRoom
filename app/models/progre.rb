class Progre < ActiveRecord::Base
  belongs_to :user
  belongs_to :hack_tag
  
  def self.done_today
    self.where('done_at > ?', Time.now.beginning_of_day)
  end
  
end

class User < ActiveRecord::Base
  has_many :friendships, :dependent => :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_many :customs
  has_many :hack_tags, through: :customs
  
  has_many :progres
  
  belongs_to :room, counter_cache: true
  validates_associated :room
  
  before_save :update_users_count_for_room
    
  def self.from_omniauth(auth, options={})
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth, options)
  end
  
  def self.create_with_omniauth(auth, options={})
    user = create! do |user|
      user.provider = auth["provider"]
      user.uid      = auth["uid"]
      user.name     = auth["info"]["name"]
      user.email    = auth["info"]["email"]
    end
    if options
      entering_room = Room.find(options[:room_id]) if options[:room_id].present?
      user.room_id = entering_room.id if entering_room
      user.save!
      if options[:my_custom]
        hack_tag = HackTag.find_or_create_by_name(options[:my_custom])
        user.customs.create(hack_tag: hack_tag)
      end
    end
    user
  end
  
  private
  def update_users_count_for_room
    return unless self.room_id_changed?
    Room.decrement_counter(:users_count, self.room_id_was)
    Room.increment_counter(:users_count, self.room_id)
  end  
end

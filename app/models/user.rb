class User < ActiveRecord::Base
  has_many :friendships, :dependent => :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_many :customs
  has_many :hack_tags, through: :customs
  
  has_many :progres
  
  def same_room_with
    friend = self.friends.first || self.inverse_friends.last
    friend_friend = self.inverse_friends.last unless friend == self.inverse_friends.last
    if friend_friend
      [friend, friend_friend]
    elsif friend
      [friend]
    else
      []
    end
  end
  
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
      friend = User.find(options[:first_friend_id]) if options[:first_friend_id].present?
      user.friendships.create(friend: friend) if friend
      if friend && friend.friends.present?
        friend_friend = friend.friends.first
        friend_friend.friendships.create(friend: user)
      end
      if options[:my_custom]
        hack_tag = HackTag.find_or_create_by_name(options[:my_custom])
        user.customs.create(hack_tag: hack_tag)
      end
    end
    user
  end
end

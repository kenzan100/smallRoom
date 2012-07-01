class HackTag < ActiveRecord::Base
  has_many :customs, :dependent => :destroy
  has_many :users, through: :customs
  
  has_many :progres
  
  validates_length_of :name, maximum: 30
  
  def self.find_2man_cells
    two_man_cells = Array.new
    HackTag.all.each do |hack_tag|
      two_man_cells << hack_tag if hack_tag.users.size == 2
    end
    two_man_cells
  end
end

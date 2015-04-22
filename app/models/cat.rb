class Cat < ActiveRecord::Base
  
  require 'date'
  
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id", :primary_key => :id
  has_many :cat_rental_requests, :dependent => :destroy
  
  validates :color, :sex, :owner_id, :presence => :true

  
  def age
    today = Date.today
    crude_age = today.year - self.birth_date.year 
    if today.month >= self.birth_date.month && 
      today.day >= self.birth_date.day
      age = crude_age
    else
      age = crude_age - 1
    end
    age
  end
  
  def self.colors 
    ["black", "brown", "orange", "Siamese", "white", "other"]
  end
  
  def self.sexes
    ["M", "F", "Other"]
  end
  
  validates :sex, :inclusion => { :in => self.sexes }
  validates :color, :inclusion => { :in => self.colors }
  
  
end

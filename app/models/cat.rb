class Cat < ActiveRecord::Base
  
  require 'date'
  
  validates: :color, :sex, :presence => :true
  
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
    ["black", "brown", "tabby", "Siamese", "white"]
  end
  
  def self.sexes
    ["M", "F", "Other"]
  end
  
  validates: :sex, :inclusion { :in => self.sexes }
  validates: :color, :inclusion { :in => self.colors }
  
end
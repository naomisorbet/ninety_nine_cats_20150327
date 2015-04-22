class CatRentalRequest < ActiveRecord::Base
  
  require 'date'
  
  validates :renter_id, :cat_id, :start_date, :end_date, :status, :presence => :true
  after_initialize :assign_pending_status
  
  belongs_to :cat
  belongs_to :renter, :class_name => "User", :foreign_key => "renter_id", :primary_key => :id
  
  
  def self.status_options
    %w(approved denied pending)
  end
  
  validates :status, :inclusion => { :in => self.status_options }

  def approve!
    raise "not pending" unless self.status == "pending"
    raise "overlaps an already-approved request" if 
          overlapping_approved_requests.any?
    transaction do
      self.status = "approved"
      self.save!
      overlapping_pending_requests.each do |request|
        request.update_aattribute(status: "denied")
      end
    end
  end

  def approved?
    self.status == "approved"
  end
  
  def deny!
    self.status = "denied"
    self.save!
  end
  
  def denied?
    self.status == "denied"
  end
  
  def pending?
    self.status == "pending"
  end
  
  private
  
  
  def assign_pending_status
    self.status ||= "pending"
  end
  
  def overlapping_requests
    this_cat_requests = self.cat.cat_rental_requests
    overlapping_requests = []
    this_cat_requests.each do |request|
      unless # no overlap
              (self.start_date > request.end_date ||
              self.end_date < request.start_date)              
        overlapping_requests << request if request != self
      end
    end
    overlapping_requests
  end
    
  def overlapping_approved_requests
    overlapping_approved_requests = []
    overlapping_requests.each do |request|
      if request.status == 'approved'
        overlapping_approved_requests << request
      end
    end
    overlapping_approved_requests
  end
  
  def overlapping_pending_requests
    overlapping_pending_requests = []
    overlapping_requests.each do |request|
      if request.status == 'pending'
        overlapping_pending_requests << request
      end
    end
    overlapping_pending_requests
  end
  
end



































class Testimonial < ActiveRecord::Base
  scope :clients, :conditions => {:is_client => true}, :order => "updated_at DESC"
  scope :partners, :conditions => {:is_client => false}, :order => "updated_at DESC"
end

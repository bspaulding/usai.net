class Testimonial < ActiveRecord::Base
  named_scope :clients, :conditions => {:is_client => true}, :order => "updated_at DESC"
  named_scope :partners, :conditions => {:is_client => false}, :order => "updated_at DESC"
end

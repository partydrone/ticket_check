class Ticket < ActiveRecord::Base
  validates_numericality_of :order_id, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99999
  validates_uniqueness_of :order_id
  
  def check
    # check the database for the current order_id
    # if there is a record, increase count by 1
    # if not save the current ticket
    return true
  end
end

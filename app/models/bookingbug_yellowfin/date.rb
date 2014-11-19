module BookingbugYellowfin
  class Date < ActiveRecord::Base
    validates_uniqueness_of :date
    attr_accessible :date
  end
end

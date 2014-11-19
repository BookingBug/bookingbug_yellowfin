module BookingbugYellowfin
  class Dates < ActiveRecord::Base
    validates_uniqueness_of :date
    attr_accessible :date
  end
end

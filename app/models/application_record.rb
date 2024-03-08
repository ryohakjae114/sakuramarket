class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  TAX_RATE = 0.1
end

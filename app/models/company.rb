class Company < ActiveRecord::Base
	has_many :contacts, :dependent => :destroy
	has_one :company_account
	has_many :remarks, :as => :notes, :dependent => :destroy

	accepts_nested_attributes_for :contacts,
  	:reject_if => proc { |attributes| attributes['full_name'].blank? }
end

class Agent < ActiveRecord::Base
	has_many :contacts, :class_name => 'UserInfo',  :as => :user_data, :dependent => :destroy
	has_one :agent_account
	has_many :remarks, :as => :notes, :dependent => :destroy

	accepts_nested_attributes_for :contacts,
  	:reject_if => proc { |attributes| attributes['full_name'].blank? }
end

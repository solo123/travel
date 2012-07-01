class Contact < ActiveRecord::Base
	belongs_to :agents
  has_many :emails, :as => :email_data, :dependent => :destroy
end

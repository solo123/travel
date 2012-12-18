class Contact < ActiveRecord::Base
	belongs_to :company
  has_many :emails, :as => :email_data, :dependent => :destroy
end

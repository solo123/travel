class UserInfo < ActiveRecord::Base
	belongs_to :user
	has_many :addresses, :as => :address_data, :dependent => :destroy
  has_many :emails, :as => :email_data, :dependent => :destroy
  has_many :telephones, :as => :tel_number, :dependent => :destroy

	accepts_nested_attributes_for :telephones,
  	:reject_if => proc { |attributes| attributes['tel'].blank? }
  def to_s
  	"#{self.full_name}"
  end
end
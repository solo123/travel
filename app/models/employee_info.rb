class EmployeeInfo < ActiveRecord::Base
  belongs_to :employee
  belongs_to :company
  has_many :emails, :as => :email_data
  has_many :addresses, :as => :address_data
  has_many :telephones, :as => :tel_number

  def default_telephone
    if self.telephones.empty?
      ''
    else
      self.telephones.order('updated_at desc').first.tel
    end
  end
end

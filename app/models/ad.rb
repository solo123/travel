class Ad < ActiveRecord::Base
	scope :all_ads, where(:image_type => 'page_ads')
	scope :ads, where(:image_type => 'page_ads', :status => 1)
	scope :all_banners, where(:image_type => 'page_banners')
	scope :banners, where(:image_type => 'page_banners', :status => 1)
	def self.photos(image_type, all_image = false)
		if all_image
			self.where(:image_type => image_type)
		else
			self.where(:image_type => image_type, :status => 1)
		end
	end
	def self.reset(image_type)
		self.where(:image_type => image_type, :status => 1).each do |img|
			img.status = 0
		end
	end
end
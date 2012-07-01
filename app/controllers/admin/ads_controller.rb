require 'flickraw'
class Admin::AdsController < Admin::BaseController
  def index
    @ads = Operates::Ad.photos('page_ads', true)
    @banners = Operates::Ad.photos('page_banners', true)
    @gallery = Operates::Ad.photos('page_gallery', true)
  end

  def show
  	if params[:id] == 'refresh'
	  	FlickRaw.api_key = '1e45d3cbe81db329e29dbbf8c966540b'
			FlickRaw.shared_secret = 'cf4894b1ad14d5e5'
	    ph = flickr.photosets.getPhotos(:photoset_id => '72157628106287811')
	    Operates::Ad.reset('page_ads')
	    ph.photo.each do |photo|
	    	info = flickr.photos.getInfo(:photo_id => photo.id)
	    	ad = Operates::Ad.where(:flickr_photo_id => photo.id).first
	    	ad ||= Operates::Ad.new
	    	ad.flickr_photo_id = photo.id
	    	ad.image_url = FlickRaw.url(info)
	    	ad.image_type = 'page_ads'
	    	ad.status = 1
	    	ad.save!
	    end
	    #banners
	    ph = flickr.photosets.getPhotos(:photoset_id => '72157628186430213')
	    Operates::Ad.reset('page_banners')
	    ph.photo.each do |photo|
	    	info = flickr.photos.getInfo(:photo_id => photo.id)
	    	ad = Operates::Ad.where(:flickr_photo_id => photo.id).first
	    	ad ||= Operates::Ad.new
	    	ad.flickr_photo_id = photo.id
	    	ad.image_url = FlickRaw.url_o(info)
	    	ad.image_type = 'page_banners'
	    	ad.status = 1
	    	ad.save!
	    end	    
	    #gallery
	    ph = flickr.photosets.getPhotos(:photoset_id => '72157628188227587')
	    Operates::Ad.reset('page_gallery')
	    ph.photo.each do |photo|
	    	info = flickr.photos.getInfo(:photo_id => photo.id)
	    	ad = Operates::Ad.where(:flickr_photo_id => photo.id).first
	    	ad ||= Operates::Ad.new
	    	ad.flickr_photo_id = photo.id
	    	ad.image_url = FlickRaw.url_o(info)
	    	ad.image_type = 'page_gallery'
	    	ad.status = 1
	    	ad.save!
	    end	 
	  end
    redirect_to :action => :index
  end

 	def edit
 		@ad = Operates::Ad.find(params[:id])
 		if params[:hide]
 			@ad.status = [1,0][@ad.status]
 			@ad.save
 		end
 	end
 	def update
 		@ad = Operates::Ad.find(params[:id])
 		@ad.update_attributes(params[:operates_ad])
 	end

  
end
# http://hanklords.github.com/flickraw/README_rdoc.html
require 'flickraw'

module Admin
	class DestinationsController < ResourceController
		new_action.after :add_description
    edit.after :add_description

		def photos
	    FlickRaw.api_key = '1e45d3cbe81db329e29dbbf8c966540b'
	    FlickRaw.shared_secret = 'cf4894b1ad14d5e5'
	    if params[:dest_id]
	        d = Destination.find(params[:dest_id])
	        d.build_photo if !d.photo
	        ph = d.photo
	        ph.photoset = params[:photoset]
	        s = flickr.photosets.getInfo(:photoset_id => ph.photoset)
	        i = flickr.photos.getInfo(:photo_id => s.primary)
	        ph.photo_s = FlickRaw.url_s(i)
	        ph.photo_t = FlickRaw.url_t(i)
	        ph.photo_m = FlickRaw.url_m(i)
	        d.save!

	      render :text => 'OK:' + d.id.to_s
	      return
	    end
	    @photo_set = flickr.photosets.getList(:user_id => '65483249@N05')
		end
    def create_photoset
      FlickRaw.api_key = '1e45d3cbe81db329e29dbbf8c966540b'
	    FlickRaw.shared_secret = 'cf4894b1ad14d5e5'
	    flickr.access_token = "72157628534789647-6b42dcbcaef680d7"
	    flickr.access_secret = "c880327b3e43526c"

	    d = Destination.find(params[:id])
      d.build_photo if !d.photo
      ph = d.photo
      s = flickr.photosets.create(:title => "#{d.id}_#{d.title}", :primary_photo_id => 6028270808)
      i = flickr.photos.getInfo(:photo_id => 6028270808)
      ph.photoset = s.id
      ph.photo_s = FlickRaw.url_s(i)
      ph.photo_t = FlickRaw.url_t(i)
      ph.photo_m = FlickRaw.url_m(i)
      d.save
      redirect_to :action => :show
    end
		def save_photos
	    if params[:photo]
	      params[:photo].each do |para|
	        d = Infos::Destination.find(para[:dest_id])
	        d.build_photo if !d.photo
	        ph = d.photo
	        ph.photoset = para[:photo_id]
	        s = flickr.photosets.getInfo(:photoset_id => ph.photoset)
	        i = flickr.photos.getInfo(:photo_id => s.primary)
	        ph.photo_s = FlickRaw.url_s(i)
	        ph.photo_t = FlickRaw.url_t(i)
	        ph.photo_m = FlickRaw.url_m(i)
	        d.save!
	      end
	    end	  
		end
		def photos_reset
		  Destination.where('photoset is not null').each do |d|
		    if d.photo
	  	    d.photo.photoset = nil
	  	    d.save
	  	  end
		  end
		  redirect_to :action => :photos
		end
		
	  def show
	    load_object
	    if params[:photo_id]
	      @object.build_photo if !@object.photo
	      ph = @object.photo      
	      FlickRaw.api_key = '1e45d3cbe81db329e29dbbf8c966540b'
	      FlickRaw.shared_secret = 'cf4894b1ad14d5e5'
	      info = flickr.photos.getInfo(:photo_id => params[:photo_id])
	      ph.photo_s = FlickRaw.url_s(info)
	      ph.photo_t = FlickRaw.url_t(info)
	      ph.photo_m = FlickRaw.url_m(info)
	      ph.save
	      flickr.access_token = "72157628534789647-6b42dcbcaef680d7"
	      flickr.access_secret = "c880327b3e43526c"
	      flickr.photosets.setPrimaryPhoto(:photoset_id => ph.photoset, :photo_id => params[:photo_id])

	      render 'set_icon.js', :content_type => 'text/javascript', :layout => nil
	      return
	    end
	  end

		protected
      def load_collection
        params[:search] ||= {}
        @search = Destination.metasearch(params[:search])
        @collection = @search.page(params[:page]).includes([:city]).per_page(AppConfig[:admin_list_per_page])
      end

	    def add_description
	    	unless @object.description
	    		@object.build_description
	    	end
	    end

	end
end

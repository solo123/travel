class Admin::ImagesController < Admin::BaseController
	def index
		upload_root = "#{Rails.root}/public/upload"
		@pages_root = "#{upload_root}/pages"
		Dir.mkdir(upload_root) unless Dir[upload_root].count > 0
		Dir.mkdir(@pages_root) unless Dir[@pages_root].count > 0
		@dir = {:name => @pages_root, :dirs => [], :files => []}
		Dir.foreach(@pages_root) do |entry|
			next if entry == '.' || entry == '..'
			full_path = File.join(@pages_root, entry)
			if File.directory?(full_path)
				@dir[:dirs] << entry
			else
				@dir[:files] << entry
			end
		end
	end
	def create
		upload_root = "#{Rails.root}/public/upload"
		@pages_root = "#{upload_root}/pages"		
		if params[:commit] == 'new_dir'
			path = "#{@pages_root}/#{params[:dir_name]}"
			Dir.mkdir(path) unless Dir[path].count > 0
		elsif params[:commit] == 'upload'
			DataFile.save(params[:upload], params[:name])
		end
		redirect_to :action => :index
	end
end
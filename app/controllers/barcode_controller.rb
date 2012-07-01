require 'barby'
require 'barby/outputter/png_outputter'
class BarcodeController < ApplicationController
	def gen
		send_data Barby::Code128B.new(params[:str]).to_png(:height => 20, :margin => 5),
			:filename => "barcode_#{params[:str]}.png",
			:type => 'image/png'
	end
end
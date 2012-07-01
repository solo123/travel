class Remark < ActiveRecord::Base
	belongs_to :notes, :polymorphic => true
end
class MicropostsController < ApplicationController
	before_action :logged_in?, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		if (logged_in?)
			@micropost = current_user.microposts.build(micropost_params)
			@feed_items = current_user.feed.paginate(page: params[:page])
			if @micropost.save
				flash[:success] = "Micropost created!"
				redirect_to root_url
			else
				render "static_pages/home"	
			end
		end
	end

	def destroy
		if (logged_in?) 
			@micropost.destroy
			flash[:success] = "Micropost deleted"
			redirect_to request.referrer || root_url
		end
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :picture)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id]) if current_user
			redirect_to root_url if @micropost.nil?
		end
end

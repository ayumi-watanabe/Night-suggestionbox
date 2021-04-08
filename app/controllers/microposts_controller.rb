class MicropostsController < ApplicationController
    before_action :only_loggedin_users, only: [:create, :destroy]

    def create
        @micropost = current_user.microposts.build(micropost_parms)

        if @micropost.save
            flash[:success] = "Successfully save!"
            redirect_to root_url                
        else 
                flash[:danger] = "Invalid content. Try again"
                redirect_to root_url
        end   
    end

    def destroy
        Micropost.find(params[:id].destroy)
        redirect_to root_urlp
    end

    private
    def microposts_parms
        params.require(:microposts_parms).permit(:content)
    end
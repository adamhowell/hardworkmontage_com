class MembersController < ApplicationController
    def show
        @user = User.friendly.find(params[:id])
    end

    def index
      @users = User.all.order(created_at: :asc)
    end
  end
  
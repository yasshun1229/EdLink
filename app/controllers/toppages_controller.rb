class ToppagesController < ApplicationController
  def index
    
    @projects = Project.all
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
    
    if logged_in?
      @project = current_user.projects.build  # form_with 用
      @pagy, @projects = pagy(current_user.projects.order(id: :desc))
    end
  end
end

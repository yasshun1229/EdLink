class ToppagesController < ApplicationController
  def index
    @projects = Project.all
    @pagy, @users = pagy(User.order(id: :desc), items: 5)
  end
end

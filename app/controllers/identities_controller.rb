class IdentitiesController < ApplicationController
  def new
    @hack_tag = HackTag.find_by_name(params[:my_custom])
    @identity = env["omniauth.identity"]
  end

end

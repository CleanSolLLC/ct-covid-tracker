class ErrorsController < ApplicationController

  before_action :page_with_errors
 
  def not_found
  	render status: 404
  end

  def unprocessable_entity
  	render status: 422
  end

  def server_error 
  	render status: 500
  end

  
  private

    def page_with_errors
    	@page_with_errors = true
    end


end

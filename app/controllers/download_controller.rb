class DownloadController < ApplicationController
  def index
    # ticket number comes in with the posted form data
    # if there is no form data/ticket number, redirect to the root page
    @ticket = Ticket.find_by_order_id(params[:order_id])
    
    # check the database for an existing record
  end
end

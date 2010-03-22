class RootController < ApplicationController
  def index
    @ticket = Ticket.new
  end

end

class DashboardsController < ApplicationController

  # GET /dashboard
  def dashboard1
    @scan = current_user.scans.last
  end

    # GET /dashboard
  def dashboard2
    @scan = current_user.scans.last
    @twitter_detail = current_user.twitter_detail
    puts "||||" + @twitter_detail.inspect
  end

    # GET /dashboard
  def dashboard3
    @scan = current_user.scans.last
  end

end

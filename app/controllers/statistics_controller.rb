class StatisticsController < ApplicationController
  def show
  	@merits = Merit.all
  end
end

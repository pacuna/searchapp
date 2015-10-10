class PagesController < ApplicationController
  def healthcheck
    render nothing: true, status: 200
  end
end

class PagesController < ApplicationController
  skip_before_action :require_login, only: [ :maintenance ]

  def maintenance
  end
end

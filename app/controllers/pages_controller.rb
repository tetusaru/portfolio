class PagesController < ApplicationController
  skip_before_action :require_login, only: [ :maintenance, :privacy, :terms, :contact ]

  def maintenance; end
  def privacy; end
  def terms; end
  def contact; end
end

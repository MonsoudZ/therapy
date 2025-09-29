class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin_layout

  private

  def set_admin_layout
    self.class.layout "admin"
  end
end

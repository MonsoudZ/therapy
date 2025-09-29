class Admin::BaseController < ApplicationController
  include AdminAuthentication
  layout 'admin'
end

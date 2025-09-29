class PagesController < ApplicationController
  include SiteDataConcern

  def home
    load_home_services
  end

  def about
  end

  def services
    load_services
  end

  def service_detail
    @service = ::SiteDataService.find_service(params[:id])
    redirect_to services_path unless @service
  end

  def faqs
    load_faqs
  end
end

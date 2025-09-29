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
    unless @service
      redirect_to services_path and return
    end

    if turbo_frame_request?
      render partial: "service_detail", locals: { service: @service }, layout: false and return
    end
  end

  # Turbo helper to clear a frame
  def service_detail_close
    @service = { id: params[:id] }
    render inline: view_context.turbo_frame_tag("service-detail-#{params[:id]}", ""), layout: false
  end

  def faqs
    load_faqs
  end
end

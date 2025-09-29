module AdminSearch
  extend ActiveSupport::Concern

  private

  def search_contact_requests
    @search_term = params[:search]
    @contact_requests = ContactRequest.recent
    
    if @search_term.present?
      @contact_requests = @contact_requests.search_by(@search_term, :first_name, :last_name, :email, :subject, :message)
    end
    
    @contact_requests = @contact_requests.page(params[:page]).per(20)
  end

  def search_site_contents
    @search_term = params[:search]
    @site_contents = SiteContent.recent
    
    if @search_term.present?
      @site_contents = @site_contents.search_by(@search_term, :key, :title, :content)
    end
    
    @site_contents = @site_contents.page(params[:page]).per(20)
  end

  def filter_by_date_range
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    
    if @start_date.present? || @end_date.present?
      @contact_requests = @contact_requests.search_by_date_range(@start_date, @end_date)
    end
  end

  def filter_by_content_type
    @content_type = params[:content_type]
    
    if @content_type.present?
      @site_contents = @site_contents.by_content_type(@content_type)
    end
  end
end

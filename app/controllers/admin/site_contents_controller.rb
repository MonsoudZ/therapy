class Admin::SiteContentsController < Admin::BaseController
  before_action :set_site_content, only: [:show, :edit, :update, :destroy]

  def index
    @site_contents = SiteContent.recent
  end

  def show
  end

  def new
    @site_content = SiteContent.new
  end

  def create
    @site_content = SiteContent.new(site_content_params)
    if @site_content.save
      SiteDataService.clear_cache! if defined?(SiteDataService)
      redirect_to admin_site_content_path(@site_content), notice: 'Site content was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @site_content.update(site_content_params)
      SiteDataService.clear_cache! if defined?(SiteDataService)
      redirect_to admin_site_content_path(@site_content), notice: 'Site content was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @site_content.destroy
    SiteDataService.clear_cache! if defined?(SiteDataService)
    redirect_to admin_site_contents_path, notice: 'Site content was successfully deleted.'
  end

  private

  def set_site_content
    @site_content = SiteContent.find(params[:id])
  end

  def site_content_params
    params.require(:site_content).permit(:key, :title, :content, :content_type)
  end
end

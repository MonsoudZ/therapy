class AboutsController < ApplicationController
  def show
    # Any data you want to show on the page can be set here.
    # Example: testimonials, training list, licenses, etc.
    @training = [
      "Licensed Professional Counselor (LPC)",
      "EMDR Trained (Relational focus)",
      "Psychodynamic & CBT/ACT informed"
    ]

    # Optional: set a page title (works with helper below)
    @page_title = "About"
  end
end

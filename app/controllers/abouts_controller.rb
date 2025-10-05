class AboutsController < ApplicationController
  def show
    @training = [
      "Licensed Professional Counselor (LPC)",
      "EMDR Trained (Relational focus)",
      "Psychodynamic & CBT/ACT informed"
    ]
    @page_title = "About"
  end
end

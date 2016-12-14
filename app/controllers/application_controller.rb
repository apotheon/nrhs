class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_help_text, only: [:new, :edit]

  private

  def get_help_text
    @help_doc_text = (HelpDoc.first or HelpDoc.new).help_text
  end
end

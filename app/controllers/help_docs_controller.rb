class HelpDocsController < ApplicationController
  include UserHelper

  before_action :redirect_non_admin

  def edit
    get_help_content
  end

  def update
    get_help_content
    @help_doc.attributes = help_doc_params.merge(id: HelpDoc.first.id)

    if @help_doc.save
      redirect_to root_path, notice: 'Help Text Updated'
    else
      flash[:alert] = @help_doc.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private

  def get_help_content
    unless HelpDoc.first
      HelpDoc.new.save
    end

    @help_doc = HelpDoc.first
  end

  def help_doc_params
    params.require(:help_doc).permit :help_text
  end
end

class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def index
    redirect_to new_contact_path(type: params[:type])
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:success] = 'Message sent!'
      redirect_to contacts_success_path_url
    else
      flash.now[:error] = 'Could not send message'
      redirect_to new_contact_path, notice: 'There was an error'
    end
  end

  def show; end
end

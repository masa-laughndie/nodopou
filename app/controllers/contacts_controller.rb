class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def sub_create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render 'confirm'
    else
      render 'new'
    end
  end

  def confirm
    if params[:contact].blank?
      redirect_to new_contact_path
    else
      @contact = Contact.new(contact_params)
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if params[:back]
      render 'new'
    elsif @contact.save
      redirect_to thanks_contact_path
    else
      flash.now[:danger] = "送信できませんでした。<br>通信環境などをご確認ください。"
      render 'new'
    end
      
  end

  def thanks
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :content)
    end
end

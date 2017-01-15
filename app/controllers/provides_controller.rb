class ProvidesController < ApplicationController
  def prov
    @prov = Provide.where('book_id = ?', params[:b_id]).first
    @prov.delivered = 1
    if @prov.save
      redirect_to books_path, notice: _('Requested book delivered!')
    else
      redirect_to books_path, alert: _('The operation isn\'t successful!')
    end
  end
end

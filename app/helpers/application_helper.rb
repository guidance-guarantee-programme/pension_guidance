module ApplicationHelper
  def format_currency(amount)
    number_to_currency(amount).sub(/\.00$/, '')
  end

  def page_id
    params[:id]
  end
end

module ApplicationHelper

  def parent_layout(layout)
    layout = layout.to_s
    layout = "layouts/#{layout}" unless layout.include?('/')

    @view_flow.set(:layout, output_buffer)

    output = render(file: layout)

    self.output_buffer = ActionView::OutputBuffer.new(output)
  end

  def modal_for(modal_id, modal_title, &block)
    render partial: 'common/modal', locals: {modal_id: modal_id, modal_title: modal_title, &block}
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end

module ApplicationHelper

  def parent_layout(layout)
    layout = layout.to_s
    layout = "layouts/#{layout}" unless layout.include?('/')

    @view_flow.set(:layout, output_buffer)

    output = render file: layout

    self.output_buffer = ActionView::OutputBuffer.new(output)
  end

  def modal_for(id, modal_title = nil, &block)
    modal_id = id + '-modal'
    modal_body = capture(&block)
    render partial: 'common/modal', locals: {modal_id: modal_id,
                                             modal_title: modal_title,
                                             modal_body: modal_body}
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def icon_tag(name)
    content_tag :i, nil, class: "icon icon-#{name}"
  end

  def close_button_tag(options)
    options.reverse_merge!({type: 'button', class: 'btn-close', aria: {label: 'Close'}})
    content_tag :button, options do
      content_tag :span, aria: {hidden: 'true'} do
        '&times;'.html_safe
      end
    end
  end

end

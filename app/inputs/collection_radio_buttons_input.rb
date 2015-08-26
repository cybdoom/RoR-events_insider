class CollectionRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    collection_builder.radio_button + custom_checkbox_span + collection_builder.text
  end

  def custom_checkbox_span
    content_tag(:span, nil, class: 'control-indicator').html_safe
  end

end

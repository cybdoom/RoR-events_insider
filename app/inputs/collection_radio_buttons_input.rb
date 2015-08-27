class CollectionRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    collection_builder.radio_button +
      custom_checkbox_span +
      content_tag(:span, collection_builder.text, class: 'label-text')
  end

  def custom_checkbox_span
    content_tag(:span, nil, class: 'control-indicator').html_safe
  end

  def apply_default_collection_options!(options)
    super(options)
    options[:item_label_class] == 'radio' if input_type == :radio_buttons
  end

end

# frozen_string_literal: true
#
# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers configration
  config.wrappers :default, class: "field" do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: :label
    b.use :input, class: "input", wrap_with: { tag: :div, class: :control }, error_class: "is-danger"
    b.use :error, wrap_with: { tag: :p, class: 'help is-danger' }
  end

  # Default configuration
  config.generate_additional_classes_for = []
  config.default_wrapper                 = :default
  config.button_class                    = "btn"
  config.label_text                      = lambda { |label, _, _| label }
  config.error_notification_tag          = :div
  config.error_notification_class        = "error_notification"
  config.browser_validations             = false
  config.boolean_style                   = :nested
  config.boolean_label_class             = "form__checkbox-label"
end

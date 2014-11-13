require 'action_view/template/handlers/govspeak'

ActionView::Template.register_template_handler(:md, ActionView::Template::Handlers::Govspeak.new)

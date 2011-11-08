# encoding: utf-8
require 'jqgrid/helpers/form_helper' if defined?(::Rails)
require 'jqgrid/json' if defined?(::Rails)

module Jqgrid
end

Array.send :include, Jqgrid::Json
ActionView::Base.send :include, Jqgrid::Helpers::FormHelper

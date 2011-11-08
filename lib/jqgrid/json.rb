module Jqgrid
  module Json
    include ActionView::Helpers::JavaScriptHelper

    def to_jqgrid_json(attributes, current_page, per_page, total)
      json = %Q({"page":"#{current_page}","total":#{total/per_page.to_i+1},"records":"#{total}")
      if total > 0
        json << %Q(,"rows":[)
        each do |elem|
          elem.id ||= index(elem)
          json << %Q({"id":"#{elem.id}","cell":[)
          couples = elem.attributes.symbolize_keys
          attributes.each do |atr|
            value = get_atr_value(elem, atr, couples)
            value = escape_javascript(value) if value and value.is_a? String
            json << %Q("#{value}",)
          end
          json.chop! << "]},"
        end
        json.chop! << "]}"
      else
        json << "}"
      end
    end

    private

    def get_atr_value(elem, atr, couples)
      if atr.to_s.include?('.')
        value = get_nested_atr_value(elem, atr.to_s.split('.').reverse) 
      else
        value = couples[atr]
        value = elem.send(atr.to_sym) if value.blank? && elem.respond_to?(atr) # Required for virtual attributes
      end
      value
    end

    def get_nested_atr_value(elem, hierarchy)
      return nil if hierarchy.size == 0
      atr = hierarchy.pop
      raise ArgumentError, "#{atr} doesn't exist on #{elem.inspect}" unless elem.respond_to?(atr)
      nested_elem = elem.send(atr)
      return "" if nested_elem.nil?
      value = get_nested_atr_value(nested_elem, hierarchy)
      value.nil? ? nested_elem : value
    end
  end

  def to_jqgrid_json(attributes, current_page, per_page, total)
    json = %Q({"page":"#{current_page}","total":#{total/per_page.to_i+1},"records":"#{total}")
    if total > 0
      json << %Q(,"rows":[)
      each do |elem|
        elem.id ||= index(elem)
        json << %Q({"id":"#{elem.id}","cell":[)
        couples = elem.attributes.symbolize_keys
        attributes.each do |atr|
          value = get_atr_value(elem, atr, couples)
          value = escape_javascript(value) if value and value.is_a? String
          json << %Q("#{value}",)
        end
        json.chop! << "]},"
      end
      json.chop! << "]}"
    else
      json << "}"
    end
  end

  private

  def get_atr_value(elem, atr, couples)
    if atr.to_s.include?('.')
      value = get_nested_atr_value(elem, atr.to_s.split('.').reverse) 
    else
      value = couples[atr]
      value = elem.send(atr.to_sym) if value.blank? && elem.respond_to?(atr) # Required for virtual attributes
    end
    value
  end

  def get_nested_atr_value(elem, hierarchy)
    return nil if hierarchy.size == 0
    atr = hierarchy.pop
    raise ArgumentError, "#{atr} doesn't exist on #{elem.inspect}" unless elem.respond_to?(atr)
    nested_elem = elem.send(atr)
    return "" if nested_elem.nil?
    value = get_nested_atr_value(nested_elem, hierarchy)
    value.nil? ? nested_elem : value
  end
end

require 'test_helper'

class ThunkTest < Test::Unit::TestCase
  include Liquid

  def test_simple_case
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    assert_equal '{{foo}}', t.parse("{{foo}}").render
    assert_equal '{{ foo }}', t.parse("{{ foo }}").render
  end

  def test_simple_with_filters
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    assert_equal '{{foo | omg}}', t.parse("{{foo | omg}}").render
  end

end # TemplateTest


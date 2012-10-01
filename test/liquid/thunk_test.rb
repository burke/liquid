require 'test_helper'

class ThunkTest < Test::Unit::TestCase
  include Liquid

  def test_simple_case
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    assert_equal '{{foo}}', t.parse("{{foo}}").render
    assert_equal '{{ foo }}', t.parse("{{ foo }}").render
    assert_equal 'asdf {{ foo }}zxcv', t.parse("asdf {{ foo }}zxcv").render
  end

  def test_simple_with_filters
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    assert_equal 'asdf{{foo | omg}}zxcv', t.parse("asdf{{foo | omg}}zxcv").render
  end

  def test_mixed_with_real_values
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    t.assigns['num'] = 42
    assert_equal '42asdf{{foo}}zxcv', t.parse("{{num}}asdf{{foo}}zxcv").render
  end

  def test_with_if
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    assert_equal '{{foo}}', t.parse("{% if true %}{{foo}}{% else %}{{foo | false}}{% endif %}").render
  end

  def test_as_condition
    t = Template.new
    t.assigns['foo'] = Liquid::Thunk
    tpl = "{% if foo > 3 %}{{foo}}{% else %}{{foo | false}}{% endif %}"
    assert_equal tpl, t.parse(tpl).render
  end

  def test_evaluates_both_sides_of_conditions
    t = Template.new
    t.assigns['inventory'] = Liquid::Thunk
    t.assigns['title'] = "Awesome thing"
    t.assigns['soldout'] = "Sold out :("
    tpl = "{% if inventory > 0 %}{{title}}{% else %}{{soldout}}{% endif %}"
    res = "{% if inventory > 0 %}Awesome thing{% else %}Sold out :({% endif %}"
    assert_equal res, t.parse(tpl).render
  end

end # TemplateTest


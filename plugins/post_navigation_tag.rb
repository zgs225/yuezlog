# encoding: utf-8
module Jekyll
  class PostNavigationTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      "<h1>Hello world</h1>"
    end
  end
end

Liquid::Template.register_tag('post_navigation', Jekyll::PostNavigationTag)

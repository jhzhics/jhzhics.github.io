module Jekyll
    class MarkdownInclude < Liquid::Tag
      def initialize(tag_name, markup, tokens)
        super
        @markup = markup
      end
  
      def render(context)
        site = context.registers[:site]
        rendered_markup = Liquid::Template.parse(@markup).render(context)
        file_path = File.join(site.source, rendered_markup.strip)
        content = File.read(file_path)
        converter = site.find_converter_instance(Jekyll::Converters::Markdown)
        converter.convert(content)
      end
    end
  end
  
  Liquid::Template.register_tag('include_markdown', Jekyll::MarkdownInclude)
  
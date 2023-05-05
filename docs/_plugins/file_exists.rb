module Jekyll
  class FileExistsTag < Liquid::Tag

    def initialize(tag_name, path, tokens)
      super
      @path = path
    end

    def render(context)
      site_source = context.registers[:site].config['source']
      file_path = site_source + '/' + @path
      "#{File.exist?(file_path.strip!)}"
    end
  end
end

Liquid::Template.register_tag('file_exists', Jekyll::FileExistsTag)


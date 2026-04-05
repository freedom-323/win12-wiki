module Jekyll
  class GitBookEmbedTag < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      # Extract the URL from the tag {% embed url="..." %}
      url = @input.match(/url="([^"]+)"/)[1] rescue nil
      return "" unless url

      # Convert standard URL to an iframe-compatible embed URL
      if url.include? "youtube.com"
        video_id = url.split('v=').last
        embed_url = "https://youtube.com{video_id}"
      elsif url.include? "vimeo.com"
        video_id = url.split('/').last
        embed_url = "https://vimeo.com{video_id}"
      else
        embed_url = url
      end

      <<~HTML
        <div class="gem-video-container">
          <iframe src="#{embed_url}" frameborder="0" allowfullscreen></iframe>
        </div>
      HTML
    end
  end
end

Liquid::Template.register_tag('embed', Jekyll::GitBookEmbedTag)

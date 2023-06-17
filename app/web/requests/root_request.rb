class RootRequest < Request

  def self.call env
    new.call env
  end

  attr_reader :env, :request, :action, :format

  def call env
    @env = env
    @request = env["LIZA_REQUEST"].to_sym
    @action  = env["LIZA_ACTION"].to_sym
    @format  = env["LIZA_FORMAT"].to_sym


    @breadcrumbs = get_breadcrumbs.find { _1.first[:selected] }

    @breadcrumbs = []


    status = 200
    headers = {
      "Framework" => "Liza #{Lizarb::VERSION}"
    }
    body = render "#{format}.#{format}", "body.#{format}", "#{action}.#{format}"

    log status
    [status, headers, [body]]
  end

  def hotjar_tag
    <<-STR
    <!-- Hotjar Tracking Code for https://lizarb.org/ -->
<script>
    (function(h,o,t,j,a,r){
        h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
        h._hjSettings={hjid:3509884,hjsv:6};
        a=o.getElementsByTagName('head')[0];
        r=o.createElement('script');r.async=1;
        r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
        a.appendChild(r);
    })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
</script>
    STR
  end

  def youtube_tag id, w = 450
    h = (315 * w) / 560
    # %|<iframe width="#{w}" height="#{h}" src="https://www.youtube.com/embed/#{id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>|
    # http://i3.ytimg.com/vi/erLk59H86ww/hqdefault.jpg
    # http://i3.ytimg.com/vi/erLk59H86ww/maxresdefault.jpg
    # 
    %|<a href="https://www.youtube.com/v/#{id}" target="_blank"><img width="#{w}" height="#{h}" src="https://i3.ytimg.com/vi/#{id}/hqdefault.jpg"/></a>|
  end

  def get_breadcrumbs
    [
      [
        {
          # char: %|案 - This character (pronounced "an") can mean "guide" or "guidance" in Japanese. It is often used in words related to guiding or leading, such as 案内 (annai) which means "guide" or "guidance," as mentioned earlier.|,
          name: "Guia",
          path: "/root/guide.html",
        }
      ],
      [
        {
          # char: %|案 - This character (pronounced "an") can mean "guide" or "guidance" in Japanese. It is often used in words related to guiding or leading, such as 案内 (annai) which means "guide" or "guidance," as mentioned earlier.|,
          name: "Guia",
          path: "/root/guide.html",
        },
        {
          name: "/ Ruby",
          path: "/guide/ruby.html",
        },
        {
          name: "/ Install",
          path: "/guide_ruby/installation.html",
        }
      ],
      [
        {
          # char: %|共 - This character (pronounced "kyō") carries the meaning of "together" or "shared." It can be used to convey the idea of community or a sense of togetherness. While it doesn't exclusively mean "safe space," it can imply a sense of belonging and inclusiveness within a community.|,
          name: "Comunidade",
          path: "/root/community.html",
        },
        {
          name: "/ Brasil",
          path: "/community/lizarb.html",
        },
        {
          name: "/ Fabio Akita",
          path: "/community/fabio-akita.html",
        }
      ],
      [
        {
          # char: %|文 - This character (pronounced "bun") means "text," "writing," or "document" in Japanese. It can be used to refer to any form of written or documented information. It can encompass a broad range of written materials, including official documents, literature, or sacred texts.|,
          name: "Docs",
          path: "/root/docs.html",
        },
        {
          name: "/ Ruby",
          path: "/docs/ruby.html",
        },
        {
          name: "/ 1 Iniciante",
          path: "/docs_ruby/installation.html",
        }
      ]

    ].each do |crumbs|
      crumbs.each do |crumb|
        crumb[:selected] = env["LIZA_PATH"] == crumb[:path].gsub(".html", "")
        crumb
      end
    end

  end

end

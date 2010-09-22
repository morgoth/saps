module Rack
  class GoogleAnalytics
    TRACKING_CODE = <<-EOCODE
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '{{ID}}']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
EOCODE

    def initialize(app, id)
      @app = app
      @id = id
    end

    def call(env)
      status, headers, body = @app.call(env)

      body.each do |part|
        if part =~ /<\/body>/
          part.sub!(/<\/body>/, "#{tracking_code}</body>")

          if headers['Content-Length']
            headers['Content-Length'] = (headers['Content-Length'].to_i + tracking_code.length).to_s
          end

          break
        end
      end

      [status, headers, body]
    end

  private
    def tracking_code
      TRACKING_CODE.sub(/\{\{ID\}\}/, @id)
    end
  end
end

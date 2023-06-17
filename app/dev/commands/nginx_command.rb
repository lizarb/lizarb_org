class NginxCommand < Liza::Command

  def self.call args
    log "args = #{args.inspect}"
    new.call args
  end

  def call args
    log "@args = #{args.inspect}"
    @args = args

    # log "puts render inline.txt"
    # puts render "inline.txt"

    # log "puts render text.txt"
    # puts render "text.txt"

    log "Time.now #{Time.now}"
  end

end

__END__

The default view can be rendered by calling `render "inline.txt`"

Self is the instance of the class that called `render`:
  self: <%= self %>

# view text.txt.erb

This named view can be rendered by calling `render "text.txt`"

Instance variables are accessible from the view:
  @args: <%= @args %>

Written at <%= Time.now %>

# view lalala.txt.erb.ignored

This named view will be ignored.

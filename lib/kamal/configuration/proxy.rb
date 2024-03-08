class Kamal::Configuration::Proxy
  DEFAULT_HTTP_PORT = 80
  DEFAULT_HTTPS_PORT = 443
  DEFAULT_IMAGE = "basecamp/kamal-proxy:latest"

  delegate :argumentize, :optionize, to: Kamal::Utils

  def initialize(config:)
    @options = config.raw_config.proxy || {}
  end

  def image
    options.fetch("image", DEFAULT_IMAGE)
  end

  def debug?
    !!options[:debug]
  end

  def http_port
    options.fetch(:http_port, DEFAULT_HTTP_PORT)
  end

  def https_port
    options.fetch(:http_port, DEFAULT_HTTPS_PORT)
  end

  def container_name
    "kamal-proxy"
  end

  def docker_options_args
    optionize(options.fetch("options", {}))
  end

  def publish_args
    argumentize "--publish", [ *("#{http_port}:#{DEFAULT_HTTP_PORT}" if http_port), *("#{https_port}:#{DEFAULT_HTTPS_PORT}" if https_port) ]
  end

  def deploy_options
    options.fetch(:deploy, {})
  end

  def deploy_command_args
    optionize deploy_options
  end

  private
    attr_accessor :options
end
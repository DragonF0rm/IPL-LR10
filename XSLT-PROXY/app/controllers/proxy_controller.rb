require 'nokogiri'
require 'open-uri'

class ProxyController < ApplicationController
  before_action :parse_params, only: :output
  before_action :prepare_url, only: :output

  def index
  end

  def output
  # Делаем запрос и получаем ответ от другого сервера в виде XML-документа.
    begin
      api_response = open(@url)
    rescue OpenURI::HTTPError
      redirect_to :index
      return
    end

    # Если делать XML -> HTML на сервере.
    if @parse_method == 'server'
      # will be rendered in view
      render inline: xslt_transform(api_response).to_html
      # Если делать XML -> HTML в браузере.
    elsif @parse_method == 'browser'
      render xml: insert_browser_xslt(api_response).to_xml
      # Если вообще ничего не делать.
    else
      render xml: api_response
    end
  end

  private

  BASE_API_URL = 'http://localhost:3000/?format=xml'.freeze
  XSLT_SERVER_TRANSFORM  = "#{Rails.root}/public/transform.xslt".freeze
  XSLT_BROWSER_TRANSFORM = '/transform.xslt'.freeze

  def parse_params
    @max = params[:max]
    @parse_method = params[:parse]
  end

  def prepare_url
    @url = BASE_API_URL + "&max=#{@max}"
  end

  # Преобразование XSLT на сервере
  def xslt_transform(data, transform: XSLT_SERVER_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

  def insert_browser_xslt(data, transform: XSLT_BROWSER_TRANSFORM)
    doc = Nokogiri::XML(data)
    # Готовим ссылку на XSLT
    xslt = Nokogiri::XML::ProcessingInstruction.new(doc,
                                                    'xml-stylesheet',
                                                    'type="text/xsl" href="' + transform + '"')
    doc.root.add_previous_sibling(xslt)
    # Возвращаем doc, так как предыдущая операция возвращает не XML-документ.
    doc
  end
end

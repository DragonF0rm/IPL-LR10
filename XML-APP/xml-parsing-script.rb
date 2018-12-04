#!/usr/bin/ruby
require 'nokogiri'

doc = Nokogiri::XML(File.read('xml-response.xml'))
xslt = Nokogiri::XSLT(File.read('transform.xslt'))

puts xslt.transform(doc)

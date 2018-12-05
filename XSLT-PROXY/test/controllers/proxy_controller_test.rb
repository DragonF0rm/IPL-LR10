require 'test_helper'

class ProxyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_path
    assert_response :success
  end

  test "should_get_output_without_xml_parsing" do
    get output_path(max: nil, parse: 'none')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 'some_str', parse: 'none')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: -1, parse: 'none')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 0, parse: 'none')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'

    get output_path(max: 3, parse: 'none')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'

    get output_path(max: 10, parse: 'none')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'

    get output_path(max: 180, parse: 'none')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'
  end

  test "should_get_output_with_xml_parsing_by_server" do
    get output_path(max: nil, parse: 'server')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 'some_str', parse: 'server')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: -1, parse: 'server')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 0, parse: 'server')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 3, parse: 'server')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 10, parse: 'server')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 180, parse: 'server')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'text/html'
  end

  test "should_get_output_with_xml_parsing_by_browser" do
    get output_path(max: nil, parse: 'browser')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 'some_str', parse: 'browser')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: -1, parse: 'browser')
    assert_response :found
    assert_includes @response.headers['Content-type'], 'text/html'

    get output_path(max: 0, parse: 'browser')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'

    get output_path(max: 3, parse: 'browser')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'

    get output_path(max: 10, parse: 'browser')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'

    get output_path(max: 180, parse: 'browser')
    assert_response :success
    assert_includes @response.headers['Content-type'], 'application/xml'
  end

end

require 'test_helper'

class FtpServersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ftp_server = ftp_servers(:one)
  end

  test "should get index" do
    get ftp_servers_url
    assert_response :success
  end

  test "should get new" do
    get new_ftp_server_url
    assert_response :success
  end

  test "should create ftp_server" do
    assert_difference('FtpServer.count') do
      post ftp_servers_url, params: { ftp_server: { brand_id: @ftp_server.brand_id, password: @ftp_server.password, port: @ftp_server.port, url: @ftp_server.url, username: @ftp_server.username } }
    end

    assert_redirected_to ftp_server_url(FtpServer.last)
  end

  test "should show ftp_server" do
    get ftp_server_url(@ftp_server)
    assert_response :success
  end

  test "should get edit" do
    get edit_ftp_server_url(@ftp_server)
    assert_response :success
  end

  test "should update ftp_server" do
    patch ftp_server_url(@ftp_server), params: { ftp_server: { brand_id: @ftp_server.brand_id, password: @ftp_server.password, port: @ftp_server.port, url: @ftp_server.url, username: @ftp_server.username } }
    assert_redirected_to ftp_server_url(@ftp_server)
  end

  test "should destroy ftp_server" do
    assert_difference('FtpServer.count', -1) do
      delete ftp_server_url(@ftp_server)
    end

    assert_redirected_to ftp_servers_url
  end
end

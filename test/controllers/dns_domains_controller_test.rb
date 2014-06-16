require 'test_helper'

class DnsDomainsControllerTest < ActionController::TestCase
  setup do
    @dns_domain = dns_domains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dns_domains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dns_domain" do
    assert_difference('DnsDomain.count') do
      post :create, dns_domain: { account: @dns_domain.account, last_check: @dns_domain.last_check, master: @dns_domain.master, name: @dns_domain.name, notified_serial: @dns_domain.notified_serial, type: @dns_domain.type }
    end

    assert_redirected_to dns_domain_path(assigns(:dns_domain))
  end

  test "should show dns_domain" do
    get :show, id: @dns_domain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dns_domain
    assert_response :success
  end

  test "should update dns_domain" do
    patch :update, id: @dns_domain, dns_domain: { account: @dns_domain.account, last_check: @dns_domain.last_check, master: @dns_domain.master, name: @dns_domain.name, notified_serial: @dns_domain.notified_serial, type: @dns_domain.type }
    assert_redirected_to dns_domain_path(assigns(:dns_domain))
  end

  test "should destroy dns_domain" do
    assert_difference('DnsDomain.count', -1) do
      delete :destroy, id: @dns_domain
    end

    assert_redirected_to dns_domains_path
  end
end

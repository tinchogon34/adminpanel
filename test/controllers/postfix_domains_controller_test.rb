require 'test_helper'

class PostfixDomainsControllerTest < ActionController::TestCase
  setup do
    @postfix_domain = postfix_domains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:postfix_domains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create postfix_domain" do
    assert_difference('PostfixDomain.count') do
      post :create, postfix_domain: { active: @postfix_domain.active, aliases: @postfix_domain.aliases, backupmx: @postfix_domain.backupmx, created: @postfix_domain.created, description: @postfix_domain.description, domain: @postfix_domain.domain, mailboxes: @postfix_domain.mailboxes, maxquota: @postfix_domain.maxquota, modified: @postfix_domain.modified, quota: @postfix_domain.quota, transport: @postfix_domain.transport }
    end

    assert_redirected_to postfix_domain_path(assigns(:postfix_domain))
  end

  test "should show postfix_domain" do
    get :show, id: @postfix_domain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @postfix_domain
    assert_response :success
  end

  test "should update postfix_domain" do
    patch :update, id: @postfix_domain, postfix_domain: { active: @postfix_domain.active, aliases: @postfix_domain.aliases, backupmx: @postfix_domain.backupmx, created: @postfix_domain.created, description: @postfix_domain.description, domain: @postfix_domain.domain, mailboxes: @postfix_domain.mailboxes, maxquota: @postfix_domain.maxquota, modified: @postfix_domain.modified, quota: @postfix_domain.quota, transport: @postfix_domain.transport }
    assert_redirected_to postfix_domain_path(assigns(:postfix_domain))
  end

  test "should destroy postfix_domain" do
    assert_difference('PostfixDomain.count', -1) do
      delete :destroy, id: @postfix_domain
    end

    assert_redirected_to postfix_domains_path
  end
end

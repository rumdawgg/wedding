require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", story_path
    assert_select "a[href=?]", us_path
    assert_select "a[href=?]", cats_path
    assert_select "a[href=?]", event_path
    assert_select "a[href=?]", lodging_path
    assert_select "a[href=?]", transportation_path
    assert_select "a[href=?]", parking_path
    assert_select "a[href=?]", activities_path
    assert_select "a[href=?]", registries_path
    assert_select "a[href=?]", rsvp_path

    # assert_select "a[href=?]", admin_photos_path
    # assert_select "a[href=?]", new_photo_path
    # assert_select "a[href=?]", admin_albums_path
    # assert_select "a[href=?]", new_album_path
    # assert_select "a[href=?]", admin_users_path
    # assert_select "a[href=?]", destroy_user_session_path

  end
end
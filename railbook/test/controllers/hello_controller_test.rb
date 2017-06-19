require 'test_helper'

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "list action" do
    get '/hello/list'
    assert_equal 10, assigns(:books).length, 'found rows is wrong.'
    assert_response :success, 'list action failed.'
    assert_template 'hello/list'
  end

  test "diff check" do
    assert_difference 'Book.count', 1 do
      post books_url,
        params: {
          book: {
            isbn: '978-4-7741-4223-0',
            title: 'Rubyポケットリファレンス',
            price: 3000,
            publish: '技術評論社'
          }
        }
    end
  end
end

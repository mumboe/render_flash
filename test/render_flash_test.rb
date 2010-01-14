require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/render_flash'

class RenderFlash::MockController
  include RenderFlash

  attr_accessor :flash
  
  def initialize
    @flash = {}
  end
  
  def controller_name
    "mock_controller"
  end
  
  def render_to_string(options)
    
  end
  
end


class RenderFlashTest < ActiveSupport::TestCase
  test "flash key is set according to the name of the template given" do
    mock_controller = RenderFlash::MockController.new
    mock_controller.stubs(:render_to_string).returns "rendered text"
    
    mock_controller.render_flash "error_create"
    
    assert_equal "rendered text", mock_controller.flash[:error]
  end
  
  test "flash.now is used if :now option is true" do
    mock_controller = RenderFlash::MockController.new
    mock_controller.stubs(:render_to_string).returns "rendered text"
    mock_controller.flash.expects(:now).returns(flash_now = {})
    
    mock_controller.render_flash "error_create", :now => true
    
    assert_equal "rendered text", flash_now[:error]
  end
  
  test "template is selected according to the controller name, the flashes directory and the name of the template given" do
    mock_controller = RenderFlash::MockController.new
    mock_controller.expects(:render_to_string).with(has_entry(:template => "mock_controller/flashes/error_create")).returns "rendered text"
    
    mock_controller.render_flash "error_create"
    
    assert_equal "rendered text", mock_controller.flash[:error]
  end
  
  test "rendering is done without a layout" do
    mock_controller = RenderFlash::MockController.new
    mock_controller.expects(:render_to_string).with(has_entry(:layout => false))
    
    mock_controller.render_flash "error_create"
  end
  
end

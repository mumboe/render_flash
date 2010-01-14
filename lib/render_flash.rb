module RenderFlash
  def render_flash(template, options={})
    template_path = "#{controller_name}/flashes/#{template}"
    index = template.split("_").first.to_sym
    flash_contents = render_to_string :template => template_path, :layout => false
    if options[:now]
      flash.now[index] = flash_contents
    else
      flash[index] = flash_contents
    end
  end
end

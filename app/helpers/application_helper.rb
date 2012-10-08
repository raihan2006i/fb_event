module ApplicationHelper
  # to access devise forms from other pages
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  #  def devise_error_messages!
  #    return "" if resource.errors.empty?
  #    messages = resource.errors.full_messages.map { |msg| "#{msg}<br />" }.join
  #    ("<p><span class='highlight'>" + messages + "</span></p>").html_safe
  #  end

  def setup_user(user)
    user.social_accounts.build({:account_name => user.social_account_name, :account_type => user.social_account_type}) if user.social_accounts.empty?
    user
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :id => "social_account")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

end

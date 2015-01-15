if defined?(ChefSpec)
  def create_netrc(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:netrc, :create, resource_name)
  end

  def modify_netrc(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:netrc, :modify, resource_name)
  end

  def remove_netrc(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:netrc, :remove, resource_name)
  end
end

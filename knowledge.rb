class Module
  def attribute(name, &block)
    if name.is_a? Hash
      name.each do |a, default|
        define_method(attr_name) do
          if instance_variables.include?("@#{a}")
            instance_variable_get("@#{a}")
          else
            default
          end
        end

        method_for_set(a)
        method_for_send(a) 
      end
    else
      if block
        define_method(name) do
          if instance_variables.include?("@#{name}")
            instance_variable_get("@#{name}")
          else
            instance_eval(&block)
          end
        end
      end

      define_method(name) do
        instance_variable_get("@#{name}")
      end

      method_for_set(name)
      method_for_send(name)
    end
  end

  private

  def method_for_set(var)
    define_method("#{var}=") do |value|
      instance_variable_set("@#{var}", value)
    end
  end

  def method_for_send(var)
    define_method("#{var}?") do
      send(var) ? true : false
    end
  end
  
end

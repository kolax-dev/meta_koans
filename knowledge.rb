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

	         define_method("#{a}=") do |value|
	           instance_variable_set("@#{a}", value)
	         end

	         define_method("#{a}?") do
	           send(a) ? true : false
	         end
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

	       define_method("#{name}=") do |value|
	         instance_variable_set("@#{name}", value)
	       end

	       define_method("#{name}?") do
	         send(name) ? true : false
	       end
	 	 
     end
   end
end


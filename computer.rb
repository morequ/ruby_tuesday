require_relative 'ds'

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end
  
  private def get_component_info(name)
    begin
      info = @data_source.send("get_#{name.to_s}_info", @id)
      price = @data_source.send("get_#{name.to_s}_price", @id)
    rescue NoMethodError
      raise ArgumentError, "name should be one of the [:mouse, :cpu, :keyboard]"
    end

    result = "#{name.to_s.capitalize} #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  # Define new methods for each component. 
  [:mouse, :cpu, :keyboard].each do |attribute|
    define_method(attribute) { get_component_info(attribute) }
  end
end

ds = DS.new
workstation1 = Computer.new(1, ds)
p workstation1.mouse
p workstation1.cpu
p workstation1.keyboard

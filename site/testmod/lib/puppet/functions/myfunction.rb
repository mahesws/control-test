Puppet::Functions.create_function(:myfunction) do
  dispatch :mystring do
    param 'String', :input_string
    return_type 'String' # optional
  end

  def mystring(value)
    value + " mystring"
  end

end

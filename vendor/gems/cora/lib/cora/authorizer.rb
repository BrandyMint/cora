class Cora::Authorizer

  def authorized? _binding
    eval Cora.janitor, _binding
  end

end

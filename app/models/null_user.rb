class NullUser < User
  def email
    ''
  end

  def owns?(post)
    false
  end

  def posts
    []
  end

  def comments
    []
  end

  def authenticate
    false
  end

  def authenticated?
    false
  end
end

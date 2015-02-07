module ObjectCreation
  def counter
    @counter ||= 0
    @counter += 1
  end

  def create_user(params={})
    defaults = {
        email: "user#{counter}@example.com",
        password: 'password',
        password_confirmation: 'password',
    }
    User.create!(defaults.merge(params))
  end
end

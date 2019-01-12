if user_signed_in?
  json.user do
    json.(current_user, :id, :email, :username)
  end
end
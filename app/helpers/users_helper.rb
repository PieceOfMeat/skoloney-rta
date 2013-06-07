module UsersHelper

  def birthday_for(user)
    format_date(user.birthday)
  end


  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end


  def map_marker_for(user)
    @json = user.to_gmaps4rails do |user, marker|
      marker.json :id => user.id,
                  :title => "Location of user #{user.login}"
    end
  end

end

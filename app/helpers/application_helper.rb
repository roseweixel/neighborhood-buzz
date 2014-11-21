module ApplicationHelper
  def sluggify(string)
    string.gsub(" ", "-").downcase
  end
end

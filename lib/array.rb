class Array
  def count(e)
    return self.length - (self - [e]).length
  end
end
class EMConstants
  
  def self.gray_text_color
    UIColor.colorWithRed( 124/255.0, green:124/255.0, blue:124/255.0, alpha:1.0 )
  end
  
  def self.email_regex
    /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/
  end
  
end
class EMUserModel
  
  def self.instance
    puts "EMUserModel::instance"
    
    if @user_defaults.nil?
      @user_defaults = NSUserDefaults.standardUserDefaults
    else
      @user_defaults
    end
  end
  
  def self.userLoggedIn?
    puts "EMUserModel::userLoggedIn?"
    instance.objectForKey('id').nil? ? false : true
  end
  
end
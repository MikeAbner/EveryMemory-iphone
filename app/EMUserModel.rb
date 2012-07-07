class EMUserModel
  
  @@user_defaults = nil
  
  def self.instance
    puts "EMUserModel::instance"

    if @@user_defaults.nil?
      @@user_defaults = NSUserDefaults.standardUserDefaults
    end

    @@user_defaults
  end
  
  def self.sync
    #instance.synchronize
  end
  
  def self.get( key )
    puts "EMUserModel::get"
    instance.objectForKey( key )
  end
  
  def self.set( key, val )
    puts "EMUserModel::set"
    instance.setObject( val, forKey:key )
  end
  
  def self.userLoggedIn?
    puts "EMUserModel::userLoggedIn?"
    user_id.nil? ? false : true
  end
  
  def self.set_user_id_and_email( id, email )
    puts "EMUserModel::set_user_id_and_email"
    set( id, 'user_id' )
    set( email, 'email' )
    sync
  end
  
  def self.set_name( name )
    puts "EMUserModel::set_name"
    set( name, 'name' )
    sync
  end
  
  def self.user_id
    get( 'user_id' )
  end
  
  def self.email
    get( 'email' )
  end
  
  def self.name
    get( 'name' )
  end
  
end
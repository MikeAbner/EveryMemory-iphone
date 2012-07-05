class EMIntroController < UIViewController
  
  # UIViewController Lifecycle
  def viewDidLoad
    puts "EMIntroController::viewDidLoad"
  end
  
  def viewWillAppear animated
    puts "EMIntroController::viewWillAppear:#{animated}"
    
    if EMUserModel.userLoggedIn?
      self.performSelector( 'loadApp', withObject:nil, afterDelay:0.5 )
    else
      self.performSelector( 'loadSignup', withObject:nil, afterDelay:0.5 )
    end
  end
  
  def viewDidAppear animated
    puts "EMIntroController::viewDidAppear:#{animated}"
  end
  
  def viewDidUnload
    puts "EMIntroController::viewDidUnload"
  end
  
  # Private
  
  def loadSignup
    puts "EMIntroController::loadSignup"
    
    sign_up = NSBundle.mainBundle.loadNibNamed( 'EMSignUpControllerView', owner:self, options:nil ).first
    self.presentModalViewController( sign_up, animated:true )
  end
  
  def loadApp
    puts "EMIntrocontroller::loadApp"
  end
end
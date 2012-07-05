class EMSignUpController < UIViewController
  
  # User enters in email address and password
  # 1.) If they are a new user, they are taken to a screen
  # where they enter in their name and confirm their password.
  # once they enter that information they are taken through a quick
  # walkthrough of the app which they can skip if they'd like.
  # 2.) If they are an existing user, they are taken to a welcome back
  # screen, which they can skip through.
  
  LOGIN_BACKGROUN_IMAGE_VIEW  = 5
  EMAIL_TAG                   = 10
  PASSWORD_TAG                = 20
  
  def initialize
    @login_bg = nil
    @email    = nil
    @password = nil
  end
  
  # UIViewController Lifecycle
  def viewDidLoad
    puts "EMSignUpController::viewDidLoad"
    
    # link UI elements
    @login_bg = self.view.viewWithTag( LOGIN_BACKGROUN_IMAGE_VIEW )
    @email    = self.view.viewWithTag( EMAIL_TAG )
    @password = self.view.viewWithTag( PASSWORD_TAG )
    
    @email.delegate    = self
    @password.delegate = self
  end
  
  def viewWillAppear animated
    puts "EMSignUpController::viewWillAppear:#{animated}"

    @login_bg.setImage( UIImage.imageNamed( "login-form" ) )
    
    @email.becomeFirstResponder
  end
  
  def viewDidAppear animated
    puts "EMSignUpController::viewDidAppear:#{animated}"
  end
  
  def viewDidUnload
    puts "EMSignUpController::viewDidUnload"
  end
  
  # UITextField Delegate
  def textField textField, shouldChangeCharactersInRange:range, replacementString:string
    if textField.tag == EMAIL_TAG
      if string == '\n'
        @email.resignFirstResponder
        @password.becomeFirstResponder
      end
    else
      
    end

    true
  end
  
  # Actions
  def didPressSignUpButton sender
    puts "EMSignUpController::didPressSignUpButton:#{sender}"
  end
  
end
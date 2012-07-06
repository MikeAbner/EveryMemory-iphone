class EMSignUpController < UIViewController
  
  # User enters in email address and password
  # 1.) If they are a new user, they are taken to a screen
  # where they enter in their name and confirm their password.
  # once they enter that information they are taken through a quick
  # walkthrough of the app which they can skip if they'd like.
  # 2.) If they are an existing user, they are taken to a welcome back
  # screen, which they can skip through.
  
  FORM_BACKGROUND_IMAGE_VIEW  = 5
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
    @login_bg = self.view.viewWithTag( FORM_BACKGROUND_IMAGE_VIEW )
    @email    = self.view.viewWithTag( EMAIL_TAG )
    @password = self.view.viewWithTag( PASSWORD_TAG )
    
    # set the delegates
    @email.delegate    = self
    @password.delegate = self
  end
  
  def viewWillAppear animated
    puts "EMSignUpController::viewWillAppear:#{animated}"

    # configure the view
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
      if string == "\n"
        @email.resignFirstResponder
        @password.becomeFirstResponder
      end
    else
      if string == "\n"
        if validate_form
          sign_up_user
        end
      end
    end

    true
  end

  # helper methods
  def validate_form
    puts "EMSignUpController::validate_form"
    msg   = ''
    valid = true;
    
    if @email.text.length == 0
      msg = 'You must enter an email address to sign up.'
      valid = false
    end
    
#    if !EMConstants.email_regex.match(@email.text)
#      msg = 'You must enter a valid email address to sign up.'
#      valid = false
#    end
    
    if @password.text.length < 6
      msg = 'You must enter a password of at least 6 characters to sign up.'
      valid = false
    end
    
    if !valid
      av = UIAlertView.alloc.initWithTitle( 'Oops!', message:msg, delegate:self, cancelButtonTitle:'Ok', otherButtonTitles:nil )
      av.show
    end
    
    valid
  end
  
  def sign_up_user
    puts "EMSignUpController::sign_up_user"
    extra_info = EMSignUpExtraInfoController.new.initWithNibName( 'EMSignUpExtraInfoControllerView', bundle:NSBundle.mainBundle )
    extra_info.pw = @password.text
    self.navigationController.pushViewController( extra_info, animated:true )
  end
  
end
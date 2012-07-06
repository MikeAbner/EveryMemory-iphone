class EMSignUpExtraInfoController < UIViewController
  
  FORM_BACKGROUND_IMAGE_VIEW  = 5
  NAME_TAG                    = 10
  PASSWORD_TAG                = 20
  
  attr_writer :pw
  
  def initialize
    @form_bg  = nil
    @name     = nil
    @password = nil
  end
  
  # UIViewController Lifecycle
  def viewDidLoad
    puts "EMSignUpExtraInfoController::viewDidLoad"
    
    # link UI elements
    @form_bg  = self.view.viewWithTag( FORM_BACKGROUND_IMAGE_VIEW )
    @name     = self.view.viewWithTag( NAME_TAG )
    @password = self.view.viewWithTag( PASSWORD_TAG )
    
    # set the delegates
    @name.delegate     = self
    @password.delegate = self
  end
  
  def viewWillAppear animated
    puts "EMSignUpExtraInfoController::viewWillAppear:#{animated}"

    # configure the view
    @form_bg.setImage( UIImage.imageNamed( "login-form" ) )
    
    @name.becomeFirstResponder
  end
  
  def viewDidAppear animated
    puts "EMSignUpExtraInfoController::viewDidAppear:#{animated}"
  end
  
  def viewDidUnload
    puts "EMSignUpExtraInfoController::viewDidUnload"
  end
  
  # UITextField Delegate
  def textField textField, shouldChangeCharactersInRange:range, replacementString:string
    if textField.tag == NAME_TAG
      if string == "\n"
        @name.resignFirstResponder
        @password.becomeFirstResponder
      end
    else
      if string == "\n"
        if validate_form
          add_user_info
        end
      end
    end

    true
  end

  # helper methods
  def validate_form
    puts "EMSignUpExtraInfoController::validate_form"
    msg   = ''
    valid = true;
    
    if @password.text.length != @pw
      msg = 'The passwords do not match.'
      valid = false
    end
    
    if @name.text.length == 0
      msg = 'You must enter a name to sign up.'
      valid = false
    end
    
    if !valid
      av = UIAlertView.alloc.initWithTitle( 'Oops!', message:msg, delegate:self, cancelButtonTitle:'Ok', otherButtonTitles:nil )
      av.show
    end
    
    valid
  end
  
  def add_user_info
    puts "EMSignUpExtraInfoController::add_user_info"
  end
  
end

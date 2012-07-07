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
    
    if @password.text.length < 6
      msg = 'You must enter a password of at least 6 characters to sign up.'
      valid = false
    end
    
    if @email.text.length == 0
      msg = 'You must enter an email address to sign up.'
      valid = false
    end
    
#    if !EMConstants.email_regex.match(@email.text)
#      msg = 'You must enter a valid email address to sign up.'
#      valid = false
#    end
    
    if !valid
      av = UIAlertView.alloc.initWithTitle( 'Oops!', message:msg, delegate:self, cancelButtonTitle:'Ok', otherButtonTitles:nil )
      av.show
    end
    
    valid
  end
  
  def sign_up_user
    puts "EMSignUpController::sign_up_user"
    
    url = "http://every-memory.herokuapp.com/api/#{EMServer::API_VERSION}/user/sign_in"
    params = { :email => @email.text, :password => @password.text }
    
    EMServer.get_json( url, params, self, :sign_up_success, :sign_up_failure )
  end
  
  def sign_up_success request, response, json
    puts "EMSignUpController::sign_up_success"

    is_new_user = json['is_new_user']
    user_id     = json['user_id']
    email       = json['email']

    if ( is_new_user )
      EMUserModel.set_user_id_and_email( user_id, email )
      
      extra_info    = NSBundle.mainBundle.loadNibNamed( 'EMSignUpExtraInfoControllerView', owner:self, options:nil ).first
      extra_info.pw = @password.text

      navigationController.pushViewController( extra_info, animated:true )
    else
      
    end
  end
  
  def sign_up_failure request, response, error, json
    puts "EMSignUpController::sign_up_failure"
    
    msg = "Looks like something went wrong on our end. We're sorry about that.  Please try again and let us know if it keeps happening." 
    av  = UIAlertView.alloc.initWithTitle( 'Oops!', message:msg, delegate:self, cancelButtonTitle:'Ok', otherButtonTitles:nil )
    av.show
  end
  
end
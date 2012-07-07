class EMServer
  
  API_VERSION = '1-0-0'
  
  def self.get_json( url, params, delegate, success_method, failure_method)
    nsurl     = NSURL.URLWithString( url )
    request   = NSURLRequest.requestWithURL( nsurl )
    operation = AFJSONRequestOperation.JSONRequestOperationWithRequest( request, success:lambda {
      |request, response, json|
      delegate.send( success_method, request, response, json )
    }, failure:lambda {
      |request, response, error, json|
      delegate.send( failure_method, request, response, error, json )
    })
    operation.start
  end
  
  def self.post_json( url, params, delegate, success_method, failure_method )
    
  end
end
////////////////////////////////////////////////////////////////////////////////
//
//  CODE11.COM
//  Copyright 2011
//  licenced under GPU
//
//  @author		Romeo Copaciu romeo.copaciu@code11.com
//  @date		24 May 2011
//  @version	1.0
//  @site		code11.com
//
////////////////////////////////////////////////////////////////////////////////

package com.code11.google.login
{
	import com.code11.google.login.events.LoginEvent;
	import com.code11.util.LogUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="success", type="com.code11.google.login.events.LoginEvent")]
	[Event(name="failed", type="com.code11.google.login.events.LoginEvent")]
	public class ClientLogin  extends EventDispatcher {
		
		private var _applicationId:String;
		private var _userName:String;
		private var _userPassword:String;
		private var _authenticationToken:String = null;
		
		private var log:ILogger = LogUtil.getLogger(this);
		
		private var httpService:HTTPService;
		public function ClientLogin() {
			httpService = new HTTPService();
		}
		
		public function authenticateUser(userName:String,userPassword:String,service:String,applicationId:String = "sample-application"):void {	
			_applicationId = applicationId;
			_userName = userName != null?userName:"";
			_userPassword = userPassword != null?userPassword:"";
			_authenticationToken = null;
			if(userName == null || _userPassword == null) {
				log.fatal("Needs an username and password to login");
			}
			httpService.url = "https://www.google.com/accounts/ClientLogin";
			httpService.method = "POST";
			var params:Object = {source:applicationId,service:service,Email:userName,Passwd:userPassword};
			
			var token:AsyncToken = httpService.send(params);
			token.addResponder(new Responder(handleAuthenticationResult, handleAuthenticationFault));
			
			log.debug("authenticateUser " + userName);		
		}
		
		private function handleAuthenticationResult(event:ResultEvent):void
		{
			log.debug("Authenticated " + _userName);
			
			if(event.result != null && event.result is String) {
				_authenticationToken = String(event.result).match(/Auth=([A-z0-9\-_]+)/)[1];
			} else {
				return;
			}
			
			var authenticatedUser:AuthenticatedUser = new AuthenticatedUser();
			authenticatedUser.email = _userName;
			authenticatedUser.password = _userPassword;
			authenticatedUser.token = _authenticationToken;
			authenticatedUser.loggedInTime = new Date();
			
			var loginEvent:LoginEvent = new LoginEvent(LoginEvent.SUCCESS,authenticatedUser);
			dispatchEvent(loginEvent);
		} 
		
		private function handleAuthenticationFault(event:FaultEvent):void
		{
			log.debug("Login Failed");
			
			var authenticatedUser:AuthenticatedUser = new AuthenticatedUser();
			authenticatedUser.email = _userName;
			authenticatedUser.password = _userPassword;
			authenticatedUser.token = _authenticationToken;
			authenticatedUser.loggedInTime = new Date();			
			authenticatedUser.authenticated = false;
			
			var loginEvent:LoginEvent = new LoginEvent(LoginEvent.FAILED,authenticatedUser);
			dispatchEvent(loginEvent);
			
		}
		
	}
}
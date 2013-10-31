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

package com.code11.google.calendar.services {
	
	import flash.net.URLRequest;
	
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	
	use namespace mx_internal;
	
	public class AuthDirectHTTPChannel extends DirectHTTPChannel {
		
		private var log:ILogger = Log.getLogger("AuthDirectHTTPChannel");
		public function AuthDirectHTTPChannel(id:String=null, uri:String="") {
			super(id, uri);
			log.debug("Instantiated");
		}
		
		
		override mx_internal function createURLRequest(message:IMessage):URLRequest {
			var req:URLRequest = super.createURLRequest(message);
			var httpMsg:HTTPRequestMessage = HTTPRequestMessage(message);
			req.method = httpMsg.method;
			
			if (!req.data && req.method != HTTPRequestMessage.GET_METHOD) req.data = httpMsg.body;
			return req;
		}
		
	}
}
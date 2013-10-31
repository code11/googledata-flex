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

package com.code11.google.calendar.valueObjects
{
	import mx.collections.ArrayCollection;

	public class EventListVO
	{
		
		public var kind:String;
		public var etag:String;
		public var id:String;
		public var updated:String;
		public var details:String;
		public var author:AuthorVO;
		public var feedLink:String;
		public var selfLink:String;
		public var canPost:Boolean;
		
		public var totalResults:int;
		public var startIndex:int;
		public var itemsPerPage:int;
		
		public var timeZone:String;
		public var timesCleaned:int;
		
		[ArrayElementType('com.code11.google.calendar.valueObjects.EventVO')]
		public var items:ArrayCollection;
	}
}
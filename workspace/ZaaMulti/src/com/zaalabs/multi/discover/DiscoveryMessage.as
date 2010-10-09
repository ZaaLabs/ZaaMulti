package com.zaalabs.multi.discover
{
	public dynamic class DiscoveryMessage
	{
		public static const TYPE_SERVER_INFO:String = "heresMyDigits";
		public static const TYPE_FIND_SERVERS:String = "callingAllServers";
		public static const TYPE_NAME_COLLISION:String = "heyThatsMyName!";
		public static const TYPE_NEW_SERVER_ANNOUNCE:String = "helloWorldMyNameIs...";
		
		// Define what type of message this is
		public var type:String;
		
		// The fields that a server will report
		public var name:String;
		public var application:String;
		public var ipAddress:String;
		public var port:Number;
		
		// A field that will make this unique
		public var time:Number;
	}
}
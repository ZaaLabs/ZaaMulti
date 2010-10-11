/*******************************************************************************
 * ZaaMulti
 * Copyright (c) 2010 ZaaLabs, Ltd.
 * For more information see http://www.zaalabs.com
 *
 * This file is licensed under the terms of the MIT license, which is included
 * in the license.txt file at the root directory of this library.
 ******************************************************************************/
package com.zaalabs.multi.discover
{
	public dynamic class DiscoveryMessage
	{
		public static const TYPE_FIND_SERVERS:String = "lookingForServers";
		public static const TYPE_SERVER_INFO:String = "reportingServerInfo";
		
		// Define what type of message this is
		public var type:String;
		
		// The fields that a server will report to clients
		public var name:String;
		public var application:String;
		public var ipAddress:String;
		public var port:Number;
		
		// A field that will make this unique
		public var time:Number;
	}
}
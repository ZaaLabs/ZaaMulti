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
	import flash.events.Event;
	
	public class SearchingSocketEvent extends Event
	{
		
		public static const SERVER_FOUND:String = "DiscoverableServerFound";
		
		public function SearchingSocketEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
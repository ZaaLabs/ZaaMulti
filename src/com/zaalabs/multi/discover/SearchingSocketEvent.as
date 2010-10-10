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
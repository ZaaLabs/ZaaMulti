package com.zaalabs.multi.discover
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.events.TimerEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.ServerSocket;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class DiscoverableServerSocket extends ServerSocket
	{
		public static const SERVER_FULL_MESSAGE:String = "ServerFull";

		protected var _connection:NetConnection;
		protected var _group:NetGroup;
		
		protected var _currentConnections:Number;
		protected var _application:String;
		protected var _name:String;
		
		public var maxConnections:Number;
		
		
		
		public function DiscoverableServerSocket(application:String, name:String, maxNumConnections:Number = 0)
		{
			super();
			
			init(application, name, maxNumConnections);
		}
		
		protected function init(application:String, name:String, maxNumConnections:Number):void
		{
			maxConnections = maxNumConnections;
			_application = application;
			_currentConnections = 0;
			_name = name;
			
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_connection.connect("rtmfp:");
			
			addEventListener(ServerSocketConnectEvent.CONNECT, onSocketConnect);
		}
		
		
		
		
		protected function setupGroup():void
		{
			var groupSpec:GroupSpecifier = new GroupSpecifier("ZaaSearch/SearchingGroup");
			groupSpec.postingEnabled = true;
			groupSpec.ipMulticastMemberUpdatesEnabled = true;
			groupSpec.addIPMulticastAddress("224.0.0.49:30315");
			
			_group = new NetGroup(_connection, groupSpec.groupspecWithAuthorizations());
			_group.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		protected function handleMessage(message:Object):void
		{
			if (message.type == DiscoveryMessage.TYPE_FIND_SERVERS)
			{
				dispatchServerInfo();
			}
		}
		
		protected function dispatchServerInfo():void
		{
			var info:DiscoveryMessage = new DiscoveryMessage();
			info.type = DiscoveryMessage.TYPE_SERVER_INFO;
			info.application = _application;
			info.name = _name;
			info.ipAddress = localAddress;
			info.port = localPort;
			info.time = getTimer();
			
			_group.post(info);
		}
		
		
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				case NetStatusCodes.NETCONNECTION_CONNECT_SUCCESS:
					setupGroup();
					break;
				
				case NetStatusCodes.NETGROUP_POSTING_NOTIFY:
					handleMessage(event.info.message);
					break;
			}
		}
		
		
		protected function onSocketConnect(event:ServerSocketConnectEvent):void
		{
			if (maxConnections > 0 && _currentConnections >= maxConnections)
			{
				event.socket.writeUTFBytes(SERVER_FULL_MESSAGE);
				event.socket.close();
				event.stopImmediatePropagation();
				event.stopPropagation();
			}
			else
			{
				_currentConnections++;
				event.socket.addEventListener(Event.CLOSE, onSocketClose, false, 0, true);
			}
		}
		
		protected function onSocketClose(event:Event):void
		{
			if (_currentConnections > 0)
				_currentConnections--;
			
			event.target.removeEventListener(Event.CLOSE, onSocketClose);
		}
		
		
		
		public function get currentConnections():Number
		{
			return _currentConnections;
		}
		
	}
}
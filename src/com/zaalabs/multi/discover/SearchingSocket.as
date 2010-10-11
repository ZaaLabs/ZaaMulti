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
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.Socket;
	import flash.utils.getTimer;
	
	public class SearchingSocket extends Socket
	{
		
		protected var _servers:Array;
		
		protected var _application:String;
		
		protected var _connection:NetConnection;
		protected var _group:NetGroup;
		
		public function SearchingSocket(application:String)
		{
			super();
			
			search(application);
		}
		
		public function search(application:String):void
		{
			if (!_connection)
			{
				_connection = new NetConnection();
				_connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			}
			
			if (!_connection.connected)
				_connection.connect("rtmfp:");
			
			_servers = [];
			_application = application;
		}
		
		public function connectToServer(server:DiscoveredServerVO):void
		{
			super.connect(server.ipAddress, int(server.port));
			
			_group.close();
			_connection.close();
		}
		
		public function hasServerInfo(info:DiscoveredServerVO):Boolean
		{
			var server:DiscoveredServerVO;
			
			for (var i:int = 0; i < _servers.length; i++)
			{
				server = _servers[i] as DiscoveredServerVO;
				
				if (server.name == info.name && server.ipAddress == info.ipAddress && server.port == info.port)
					return true;
			}
			
			return false;
		}
		
		protected function setupGroup():void
		{
			var groupSpec:GroupSpecifier = new GroupSpecifier("ZaaSearch/SearchingGroup");
			groupSpec.postingEnabled = true;
			groupSpec.ipMulticastMemberUpdatesEnabled = true;
			groupSpec.addIPMulticastAddress("224.0.0.49:30315");

			if (_group)
			{
				_group.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			}
			
			_group = new NetGroup(_connection, groupSpec.groupspecWithAuthorizations());
			_group.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		
		protected function handleMessage(message:Object):void
		{
			if (message.type == DiscoveryMessage.TYPE_SERVER_INFO && message.application == _application)
			{
				var serverInfo:DiscoveredServerVO = new DiscoveredServerVO();
				serverInfo.application = message.application;
				serverInfo.ipAddress = message.ipAddress;
				serverInfo.port = message.port;
				serverInfo.name = message.name;
				
				if (!hasServerInfo(serverInfo))
				{
					_servers.push(serverInfo);
					dispatchEvent(new SearchingSocketEvent(SearchingSocketEvent.SERVER_FOUND));
				}
			}
		}
		
		protected function searchForServers():void
		{
			var info:DiscoveryMessage = new DiscoveryMessage();
			info.type = DiscoveryMessage.TYPE_FIND_SERVERS;
			info.time = getTimer();
			
			_group.post(info);
		}
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
            trace(event.info.code);
			switch(event.info.code)
			{
				case NetStatusCodes.NETCONNECTION_CONNECT_SUCCESS:
					setupGroup();
					break;
				
				case NetStatusCodes.NETGROUP_NEIGHBOUR_CONNECT:
					searchForServers();
					break;
				
				case NetStatusCodes.NETGROUP_POSTING_NOTIFY:
					handleMessage(event.info.message);
					break;
			}
		}
		
		public function get servers():Array
		{
			return _servers;
		}
		
	}
}
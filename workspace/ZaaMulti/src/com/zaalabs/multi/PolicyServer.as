package com.zaalabs.multi
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.ServerSocketConnectEvent;
    import flash.net.ServerSocket;
    import flash.net.Socket;
    import flash.system.Security;
    
    public class PolicyServer
    {
        public static const POLICY_PORT:int = 8083;
        
        private var serverSocket:ServerSocket;
        private var socket:Socket;
        
        private var mainPort:int = 0;
        
        public function PolicyServer( mainPort:int )
        {
            try
            {
                this.mainPort = mainPort;
                
                serverSocket = new ServerSocket();
                serverSocket.addEventListener( Event.CONNECT, connectHandler );
                serverSocket.bind(POLICY_PORT);
                serverSocket.listen();
                trace( "Listening for policy requests" );
            }
            catch(e:SecurityError)
            {
                trace(e);
            }
        }
        public function connectHandler(event:ServerSocketConnectEvent):void
        {
            
            //Store the incoming socket
            socket = event.socket;
            socket.addEventListener( ProgressEvent.SOCKET_DATA, socketDataHandler);
            socket.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
        }
        
        public function socketDataHandler(event:ProgressEvent):void
        {
            //Read the message from the socket
            var message:String = socket.readUTFBytes( socket.bytesAvailable );
            trace( "Received: " + message);
            if( message == "<policy-file-request/>" )
            {
                var policy:String = '<cross-domain-policy><allow-access-from domain="*" to-ports="' + mainPort + '" /></cross-domain-policy>';
                socket.writeUTFBytes(policy);
                socket.writeByte(0);
                socket.flush();
                trace("Sending: " + policy);
            }
        }
        
        private function onIOError( errorEvent:IOErrorEvent ):void
        {
            trace( "IOError: " + errorEvent.text );
        }
        
        public static function loadPolicy(ip:String="127.0.0.1"):void
        {
            Security.loadPolicyFile("xmlsocket://"+ip+":"+POLICY_PORT);
        }
        
    }
}
/*******************************************************************************
 * ZaaMulti
 * Copyright (c) 2010 ZaaLabs, Ltd.
 * For more information see http://www.zaalabs.com
 *
 * This file is licensed under the terms of the MIT license, which is included
 * in the license.txt file at the root directory of this library.
 ******************************************************************************/
package
{
    import com.zaalabs.multi.discover.SearchingSocket;
    import com.zaalabs.multi.discover.SearchingSocketEvent;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.text.TextField;
    
    public class ExampleASClient extends Sprite
    {
        protected var _output:TextField;
        protected var _socket:SearchingSocket;
        
        public function ExampleASClient()
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            addEventListener(Event.ADDED_TO_STAGE, onReady);
        }
        
        protected function onReady(event:Event):void
        {
            setup();
        }
        
        protected function setup():void
        {
            setupOutput();
            setupConnection();
        }
        
        protected function setupOutput():void
        {
            _output = new TextField();
            _output.width = stage.stageWidth;
            _output.height = stage.stageHeight;
            
            addChild(_output);
        }
        
        protected function setupConnection():void
        {
            log("setting up connection");
            
            _socket = new SearchingSocket("TestApplication");
            _socket.addEventListener(SearchingSocketEvent.SERVER_FOUND, onServerFound);
        }
        
        protected function onServerFound(event:SearchingSocketEvent):void
        {
            log("Server Found");
            log(_socket.servers);
        }
        
        protected function log(msg:Object):void
        {
            trace(msg);
            _output.appendText(msg.toString());   
        }
    }
}
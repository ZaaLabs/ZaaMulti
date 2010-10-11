/*******************************************************************************
 * ZaaMulti
 * Copyright (c) 2010 ZaaLabs, Ltd.
 * For more information see http://www.zaalabs.com
 *
 * This file is licensed under the terms of the MIT license, which is included
 * in the License.txt file at the root directory of this library.
 ******************************************************************************/
package com.zaalabs.utils
{
    import flash.net.InterfaceAddress;
    import flash.net.NetworkInterface;
    
    public class NetworkUtil
    {
        
        /**
         * Method to grab the current machine's ip address 
         * @param interfaces usually... NetworkInfo.networkInfo.findInterfaces()
         * @return The machine's ip address, or null
         */        
        public static function getIpAddress(interfaces:Vector.<NetworkInterface>):String
        {
            for each (var netf:NetworkInterface in interfaces)
            {
                if(netf.active)
                {
                    var addresses:Vector.<InterfaceAddress> = netf.addresses;
                    if(addresses.length > 0)
                    {
                        return InterfaceAddress(addresses[0]).address;
                    }
                }
            }
            
            return null;
        }
    }
}
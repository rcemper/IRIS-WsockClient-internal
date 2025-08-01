/// Trial to use "native" WebSocket Client
Class WSCI.Client [ Abstract ]
{

/// Simple test from Terminal
/// enter your msg (fast) at prompt 
/// stop with *
/// to=n  sets the server timeout to n (>4)
ClassMethod Try(
	url,
	%b = 0)
{
	kill %ct
	set m=$SYSTEM.CSP.GetGatewayRegistry().GetGatewayMgrs()
		,msg="hallo WS demo server"
 		,evl=##class(WSCI.EVL).%New()
 		,port=$s(m.Size:m.GetAt(1).Port,1:52773)
 	set:'$d(url) url="http://localhost:"_port_"/csp/"_$namespace_"/WSCI.EchoServer.cls"
#; init connection 	
 	set ws=##class(%Net.WebSocket.Client).%New(url,,evl)
#; check reply every 5 sec
 	while ws.Next(5) { 
 		write "--------------- next ---------------",! 
 		if $e(msg="*") set msg="exit"  
 		do:$l(msg) ws.Send(msg)
 		if msg="exit" quit 
 		read "new message (*=exit):",msg:8 w:$l(msg) ! 
 		}
 	do ws.Next(15)  ; final wait for sever exit
 	kill ws      ;close
}

}


/// Trial to use "native" WebSocket Client
Class rcc.WS.Client [ Abstract ]
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
	set csp=$SYSTEM.CSP.GetGatewayRegistry().GetGatewayMgrs()
	if 'csp.Count() {
		write !,"SORRY: No CSP Gateway Manager found",!
		,"Open System Management Portal and retry after",! 
		quit
		}
	set port=csp.GetAt(1).Port	
		,msg="hallo WS demo server"
 		,evl=##class(rcc.WS.EVL).%New()
 	set:'$d(url) url="http://localhost:"_port_"/csp/"_$namespace_"/rcc.EchoServer.cls"
#; init connection 	
 	set ws=##class(%Net.WebSocket.Client).%New(url,,evl)
#; check reply every 4 sec
 	while ws.Next(4) { 
 		write "--------------- next ---------------",! 
 		if $e(msg="*") set msg="exit"  
 		do:$l(msg) ws.Send(msg)
 		if msg="exit" quit 
 		read "new message (*=exit):",msg:3 w:$l(msg) ! 
 		}
 	do ws.Next(15)  ; final wait for sever exit
 	kill ws      ;close
}

}

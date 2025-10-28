/// added SSL for wss://echo.websocket.org/
Class WSCI.CRE Extends (%RegisteredObject, %Net.WebSocket.ICredentials)
{

/// Returns the username to use for authentication with the web socket
/// @API.Overrideable
Method GetUsername() As %String
{
	quit "_system"
}

/// Returns the password to use for authentication with the web socket
/// @API.Overrideable
Method GetPassword() As %String
{
	quit "SYS"
}

/// Returns the SSL configuration name to use for secure web socket connections
/// @API.Overrideable
Method GetSSLConfiguration() As %String
{
	Quit "websocket"
}

}

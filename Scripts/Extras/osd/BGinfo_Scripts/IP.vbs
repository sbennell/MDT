' RETURN IPv4 ONLY
' ################################################
    Function getIPAddress(passedInt)
        On Error Resume Next
        Dim hostIPAddress, SQLQuery, strComputer, objWMIService, colItems
        SQLQuery = "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE MACAddress > '' AND IPEnabled = 'True'"
        strComputer = "."
        Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
        Set colItems = objWMIService.ExecQuery(SQLQuery)
        For Each objItem In colItems
            If IsArray( objItem.IPAddress ) Then
                If UBound( objItem.IPAddress ) = 0 Then
                    hostIPAddress = objItem.IPAddress(0)
                Else
                    hostIPAddress = "" & Join( objItem.IPAddress, "," )
                End If
            End If
        Next
        temp = split(hostIPAddress, ",")
        getIPAddress = temp(passedInt) ' temp(0) returns IPv4 Only, temp(1) retunrs IPv6 Only
    End function

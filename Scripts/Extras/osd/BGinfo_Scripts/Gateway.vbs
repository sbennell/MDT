strMsg = ""
strComputer = "."

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set IPConfigSet = objWMIService.ExecQuery("Select DefaultIPGateway from Win32_NetworkAdapterConfiguration WHERE IPEnabled = 'True'")

For Each IPConfig in IPConfigSet
  If Not IsNull(IPConfig.DefaultIPGateway) Then
    For i = LBound(IPConfig.DefaultIPGateway) to UBound(IPConfig.DefaultIPGateway)
     If Not Instr(IPConfig.DefaultIPGateway(i),":") > 0 Then
        strMsg = strMsg & IPConfig.DefaultIPGateway(i) & vbcrlf
      End If
    Next
  End If
Next

Echo strMsg

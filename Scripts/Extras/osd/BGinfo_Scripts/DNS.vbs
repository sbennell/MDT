strMsg = ""
strComputer = "."

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set IPConfigSet = objWMIService.ExecQuery("Select DNSServerSearchOrder from Win32_NetworkAdapterConfiguration WHERE IPEnabled = 'True'")

For Each IPConfig in IPConfigSet
  If Not IsNull(IPConfig.DNSServerSearchOrder) Then
    For i = LBound(IPConfig.DNSServerSearchOrder) to UBound(IPConfig.DNSServerSearchOrder)
      If i = 0 Then
        strMsg = strMsg & IPConfig.DNSServerSearchOrder(i)
      ElseIf i > 0 Then
        strMsg = strMsg & vbcrlf & vbtab & IPConfig.DNSServerSearchOrder(i)
      End If
    Next
  End If
Next

Echo strMsg
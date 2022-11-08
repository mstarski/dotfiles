function toast
   powershell.exe -command New-BurntToastNotification "-Text '$argv'"
end

#path of the wallpapers
$wallpaper1 = "C:\Wallpapers\wallpaper1.jpg" 
$wallpaper2 = "C:\Wallpapers\wallpaper2.jpg"

# Get current wallpaper path
$currentWallpaper = (Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper).WallPaper

if ($currentWallpaper -eq $wallpaper1) {
    $newWallpaper = $wallpaper2
} else {
    $newWallpaper = $wallpaper1
}

# Set wallpaper registry keys
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper -Value $newWallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 10 # Fill
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -Value 0

# Apply the wallpaper immediately
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

[Wallpaper]::SystemParametersInfo(20, 0, $newWallpaper, 3)

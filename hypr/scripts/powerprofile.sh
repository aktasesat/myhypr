#!/bin/bash

# Dosya yollarını otomatik bul
ASUS_PATH=$(grep -l "asus" /sys/class/hwmon/hwmon*/name | sed 's/\/name//')
STATE_FILE="$HOME/.cache/power_profile_state"

# Mevcut modu oku (yoksa Normal'den başla)
if [ ! -f "$STATE_FILE" ]; then echo "normal" > "$STATE_FILE"; fi
CURRENT_MODE=$(cat "$STATE_FILE")

case $CURRENT_MODE in
    "normal")
        # --- PERFORMANS MODUNA GEÇİŞ ---
        pkexec cpupower frequency-set -g performance
        echo "high" | pkexec tee /sys/class/drm/card0/device/power_dpm_force_performance_level
        if [ -f "$ASUS_PATH/fan_boost_mode" ]; then echo 1 | pkexec tee "$ASUS_PATH/fan_boost_mode"; fi
        
        # Hyprland Görsellerini Kapat (FPS için)
        hyprctl --batch "keyword animations:enabled 0; keyword decoration:blur:enabled 0"
        
        echo "performance" > "$STATE_FILE"
        notify-send -u critical "Güç Modu" "PERFORMANS: Görseller Kapalı | Donanım MAX" -i "speedometer"
        ;;
        
    "performance")
        # --- SESSİZ MODA GEÇİŞ ---
        pkexec cpupower frequency-set -g powersave
        echo "low" | pkexec tee /sys/class/drm/card0/device/power_dpm_force_performance_level
        if [ -f "$ASUS_PATH/fan_boost_mode" ]; then echo 2 | pkexec tee "$ASUS_PATH/fan_boost_mode"; fi
        
        # Görselleri Aç
        hyprctl reload
        
        echo "silent" > "$STATE_FILE"
        notify-send -u low "Güç Modu" "SESSİZ: Enerji Tasarrufu ve Minimum Fan" -i "audio-volume-low"
        ;;
        
    "silent")
        # --- NORMAL MODA GEÇİŞ ---
        pkexec cpupower frequency-set -g schedutil
        echo "auto" | pkexec tee /sys/class/drm/card0/device/power_dpm_force_performance_level
        if [ -f "$ASUS_PATH/fan_boost_mode" ]; then echo 0 | pkexec tee "$ASUS_PATH/fan_boost_mode"; fi
        
        hyprctl reload
        
        echo "normal" > "$STATE_FILE"
        notify-send -u low "Güç Modu" "NORMAL: Dengeli Kullanım" -i "battery"
        ;;
esac

# Waybar'ı güncellemek için sinyal gönder (opsiyonel)
# pkill -RTMIN+8 waybar

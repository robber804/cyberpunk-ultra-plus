-- variables.lua

local var = {
    mode = {
        VANILLA = "Vanilla##Mode",
        PT20 = "PT20",
        PT21 = "PT21",
        PTNEXT = "PTNext",
        RT_PT = "RTPT",
        RT_ONLY = "RTOnly",
        RASTER = "Raster",
    },
    quality = {
        VANILLA = "Vanilla##Quality",
        LOW = "Low",
        MEDIUM = "Medium",
        HIGH = "High",
        INSANE = "Insane",
    },
    vram = {
        OFF = "Off",
        GB4 = "4 GB",
        GB6 = "6 GB",
        GB8 = "8 GB",
        GB10 = "10 GB",
        GB12 = "12 GB",
        GB16 = "16 GB",
        GB20 = "20 GB",
        GB24 = "24 GB",
    },
    dlss = {
        AUTO = "Auto",
        DYNAMIC = "Dynamic",
        DLAA = "DLAA",
        QUALITY = "Quality",
        BALANCED = "Balanced",
        PERFORMANCE = "Performance",
        ULTRA_PERFORMANCE = "Ultra Performance",
    },
    settings = {
        uiScale = 0.9,
        mode = "Unknown",
        quality = "Unknown",
        streaming = "Unknown",
        indoors = nil,
        rain = nil,
        nrdEnabled = nil,
    },
}

return var

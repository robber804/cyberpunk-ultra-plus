--ui.lua

local options = require("options")
local var = require("variables")
local config = {
    SetSamples = require("setsamples").SetSamples,
    SetMode = require("setmode").SetMode,
    SetQuality = require("setquality").SetQuality,
    SetStreaming = require("setstreaming").SetStreaming,
    DEBUG = false,
    reGIR = false,
    --	turboHack = false,
}

local toggled


local ui = {

    line = function()
        ImGui.Spacing()
        ImGui.Separator()
        ImGui.Spacing()
    end,

    space = function()
        ImGui.Spacing()
    end,

    align = function()
        ImGui.SameLine()
    end,

    text = function(text)
        ImGui.Text(text)
    end,

    section = function(text)
        ImGui.Spacing()
        ImGui.Separator()
        ImGui.TextWrapped(text)
        ImGui.Spacing()
    end,

    heading = function(text)
        ImGui.Spacing()
        ImGui.Text("Skin/Hair")
        ImGui.Spacing()
    end,

    tooltip = function(text)
        if ImGui.IsItemHovered() and text ~= "" then
            ImGui.BeginTooltip()
            ImGui.SetTooltip(text)
            ImGui.EndTooltip()
        end
    end,
}

local function renderTabEngineDrawer()
    ui.text("NOTE: Wait for FPS to stabilise after changing settings.")

    if ImGui.CollapsingHeader("Rendering Mode", ImGuiTreeNodeFlags.DefaultOpen) then
        --[[
		if ImGui.RadioButton( "Raster (no ray tracing or path tracing)", var.settings.mode == var.mode.RASTER ) then
			var.settings.mode = var.mode.RASTER
			config.SetMode( var.settings.mode )
			config.SetSamples( var.settings.samples )
		end
]]
        if ImGui.RadioButton("RT Only", var.settings.mode == var.mode.RT_ONLY) then
            var.settings.mode = var.mode.RT_ONLY
            config.SetMode(var.settings.mode)
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("RT+PT", var.settings.mode == var.mode.RT_PT) then
            var.settings.mode = var.mode.RT_PT
            config.SetMode(var.settings.mode)
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("PT20", var.settings.mode == var.mode.PT20) then
            var.settings.mode = var.mode.PT20
            config.SetMode(var.settings.mode)
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("PT21", var.settings.mode == var.mode.PT21) then
            var.settings.mode = var.mode.PT21
            config.SetMode(var.settings.mode)
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end
    end

    ui.space()
    if ImGui.CollapsingHeader("RTXDI and ReGIR Quality", ImGuiTreeNodeFlags.DefaultOpen) then
        ui.tooltip("RTXDI is path traced direct illumination.")

        if ImGui.RadioButton("Vanilla##SamplesVanilla", var.settings.samples == var.samples.VANILLA) then
            var.settings.samples = var.samples.VANILLA
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Low##SamplesLow", var.settings.samples == var.samples.LOW) then
            var.settings.samples = var.samples.LOW
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Medium##SamplesMedium", var.settings.samples == var.samples.MEDIUM) then
            var.settings.samples = var.samples.MEDIUM
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("High##SamplesHigh", var.settings.samples == var.samples.HIGH) then
            var.settings.samples = var.samples.HIGH
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Insane##SamplesInsane", var.settings.samples == var.samples.INSANE) then
            var.settings.samples = var.samples.INSANE
            config.SetSamples(var.settings.samples)
            SaveSettings()
        end
    end

    ui.space()
    if ImGui.CollapsingHeader(var.settings.mode .. " Indirect Illumination Sampling", ImGuiTreeNodeFlags.DefaultOpen) then
        if ImGui.RadioButton("Vanilla##QualityVanilla", var.settings.quality == var.quality.VANILLA) then
            var.settings.quality = var.quality.VANILLA
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Low##QualityLow", var.settings.quality == var.quality.LOW) then
            var.settings.quality = var.quality.LOW
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Medium##QualityMedium", var.settings.quality == var.quality.MEDIUM) then
            var.settings.quality = var.quality.MEDIUM
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("High##QualityHigh", var.settings.quality == var.quality.HIGH) then
            var.settings.quality = var.quality.HIGH
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("Insane##QualityInsane", var.settings.quality == var.quality.INSANE) then
            var.settings.quality = var.quality.INSANE
            config.SetQuality(var.settings.quality)
            SaveSettings()
        end
    end

    ui.space()
    if ImGui.CollapsingHeader("Streaming Boost", ImGuiTreeNodeFlags.DefaultOpen) then
        if ImGui.RadioButton("20 metres##StreamingLow", var.settings.streaming == var.streaming.LOW) then
            var.settings.streaming = var.streaming.LOW
            config.SetStreaming(var.settings.streaming)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("40 metres##StreamingMedium", var.settings.streaming == var.streaming.MEDIUM) then
            var.settings.streaming = var.streaming.MEDIUM
            config.SetStreaming(var.settings.streaming)
            SaveSettings()
        end

        ui.align()
        if ImGui.RadioButton("80 metres##StreamingHigh", var.settings.streaming == var.streaming.HIGH) then
            var.settings.streaming = var.streaming.HIGH
            config.SetStreaming(var.settings.streaming)
            SaveSettings()
        end
    end

    ui.space()
    if ImGui.CollapsingHeader("Tweaks", ImGuiTreeNodeFlags.DefaultOpen) then
        for _, setting in pairs(options.Tweaks) do
            setting.value = GetOption(setting.category, setting.item)
            setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
            ui.tooltip(setting.tooltip)

            if toggled then
                SetOption(setting.category, setting.item, setting.value)
                setting.value = setting.value
                SaveSettings()
            end
        end
    end
end

local function renderRenderingFeaturesDrawer()
    ui.space()
    for _, setting in pairs(options.Features) do
        setting.value = GetOption(setting.category, setting.item)
        setting.value, toggled = ImGui.Checkbox(setting.name, setting.value)
        ui.tooltip(setting.tooltip)

        if toggled then
            SetOption(setting.category, setting.item, setting.value)
            setting.value = setting.value

            SaveSettings()
        end
    end
end

local function renderTabs()
    if ImGui.BeginTabBar("Tabs") then
        if ImGui.BeginTabItem("Engine Config") then
            renderTabEngineDrawer()
            ImGui.EndTabItem()
        end

        if ImGui.BeginTabItem("Rendering Features") then
            renderRenderingFeaturesDrawer()
            ImGui.EndTabItem()
        end

        ImGui.EndTabBar()
    end
end


ui.renderControlPanel = function()
    -- SET DEFAULTS
    ImGui.SetWindowFontScale(0.9)
    ImGui.SetNextWindowPos(200, 200, ImGuiCond.FirstUseEver)
    ImGui.SetNextWindowSize(436, 615, ImGuiCond.Appearing)

    -- BEGIN ACTUAL RENDER
    if ImGui.Begin("Ultra+ Control v" .. Ultraplus.__VERSION, true) then
        renderTabs()
        ImGui.End()
    end
end


return ui

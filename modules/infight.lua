pfUI:RegisterModule("infight", "vanilla:tbc", function ()
  local function OnUpdate()
    if this.mode == 0 then return end
    if ( this.tick or 1) > GetTime() then return else this.tick = GetTime() + .1 end

    if not this.fadeValue then  this.fadeValue = 1 end
    if this.fadeValue >= 0.3 then
      this.fadeModifier = -0.1
    end
    if this.fadeValue <= 0 then
      this.fadeModifier = 0.1
    end
    this.fadeValue = this.fadeValue + this.fadeModifier

    if C.appearance.infight.screen == "1" and this.screen then
      if UnitAffectingCombat("player") then
        this.screen:Show()
        this.screen:SetBackdropBorderColor(1,0.2+this.fadeValue, this.fadeValue, 1-this.fadeValue);
      else
        this.screen:Hide()
      end
    end
  end

  pfUI.infight = CreateFrame("Frame", "pfUICombat", UIParent)
  pfUI.infight:SetScript("OnUpdate", OnUpdate)

  pfUI.infight.screen = CreateFrame("Frame", "pfUICombatScreen", UIParent)
  pfUI.infight.screen:SetFrameStrata("BACKGROUND")
  pfUI.infight.screen:SetAllPoints(WorldFrame)
  pfUI.infight.screen:SetBackdrop({
    edgeFile = pfUI.media["img:glow"], edgeSize = 8,
    insets = {left = 0, right = 0, top = 0, bottom = 0},
  })
  pfUI.infight.screen:Hide()

  pfUI.infight.UpdateConfig = function(self)
    pfUI.infight.mode = tonumber(C.appearance.infight.screen)
  end

  pfUI.infight.UpdateConfig()
end)

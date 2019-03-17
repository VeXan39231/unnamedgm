local ang = 0
timer.Simple( 10, function()
    local ang = LocalPlayer():GetAimVector():Angle().y
end )

function drawCompass()

    local dirs = surface.GetTextureID( "vexan/vcompass/dirs.vtf" )
    local ring = surface.GetTextureID( "vexan/vcompass/ring.vtf" )
    local x, y = ScrW() / 1.1, ScrH() / 20
    local xx, yy = ScrW() / 15, ScrH() / 8.4375

    surface.SetDrawColor(255,255,255,255)
    surface.SetTexture(dirs)
    
    --From here to line 31 is almost all thanks to Vortix#6077 :)
    local oldAngle = ang
    local newAngle = LocalPlayer():GetAimVector():Angle().y
    local increaseDistance = math.max(oldAngle, newAngle) - math.min(oldAngle, newAngle)
    --local decreaseDistance = math.m

    if (newAngle > oldAngle) then
        increaseDistance = newAngle - oldAngle
        decreaseDistance = 360 - newAngle + oldAngle
    else
        increaseDistance = 360 - oldAngle + newAngle
        decreaseDistance = oldAngle - newAngle
    end

    if (increaseDistance < decreaseDistance) then
        ang = Lerp( FrameTime() * 7, ang, ang + increaseDistance) % 360
    else
        ang = Lerp( FrameTime() * 7, ang, ang - decreaseDistance) % 360
    end
    
    surface.DrawTexturedRectRotated( x + x / 27, y / 0.45, xx, yy, ang )
    surface.SetTexture(ring)
    surface.DrawTexturedRect( x, y, xx + 2, yy + 2 )

    draw.DrawText( math.Round( ang, 0 ), "HudHintTextLarge", x + ( yy / 2 ), y + yy, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
    
end

hook.Add("HUDPaint", "DrawCompass", drawCompass )
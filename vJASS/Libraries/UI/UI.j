library UI requires RegisterPlayerUnitEvent, TimerUtils
    private struct UI
        private static framehandle handle = null
        private static framehandle UI = null
        private static framehandle HealthBar = null
        private static framehandle ManaBar = null
        private static framehandle HeroCheck = null
        private static framehandle HPText = null
        private static framehandle MPText = null
        private static framehandle Gold = null
        private static framehandle Lumber = null
        private static trigger herotrigger = CreateTrigger()
        private static trigger trigger = CreateTrigger()
        private static timer timer = CreateTimer()
        private static integer key = -1
        private static thistype array array
        private static thistype array struct
        private static real array x1
        private static real array x2
        private static real array y01
        private static real array y02
        private static real array y11
        private static real array y12
        private static real array y21
        private static real array y22
        private static real array y31
        private static real array y32
        private static real array y41
        private static real array y42
        private static real array y51
        private static real array y52
        private static real array y61
        private static real array y62

        unit unit
        player player
        group group
        integer id
        real health
        real mana
        string hp
        string mp

        method remove takes integer i returns integer
            call DestroyGroup(group)

            set array[i] = array[key]
            set key = key - 1
            set struct[id] = 0
            set unit = null
            set group = null
            set player = null

            if key == -1 then
                call PauseTimer(timer)
            endif

            call deallocate()

            return i - 1
        endmethod

        private static method onCommandButtons takes nothing returns nothing
            // Removes the Move command button
            //call BlzFrameSetVisible(BlzGetFrameByName("CommandButton_0", 0), false)

            // Removes the Stop command button
            //call BlzFrameSetVisible(BlzGetFrameByName("CommandButton_1", 0), false)
            
            // Removes the Hold command button
            //call BlzFrameSetVisible(BlzGetFrameByName("CommandButton_2", 0), false)

            // Removes the Attack command button
            //call BlzFrameSetVisible(BlzGetFrameByName("CommandButton_3", 0), false)

            // Removes the Patrol command button
            //call BlzFrameSetVisible(BlzGetFrameByName("CommandButton_4", 0), false)

            // Reposition the D command button
            set handle = BlzGetFrameByName("CommandButton_5", 0) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.186900, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.216900, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the F command button
            set handle = BlzGetFrameByName("CommandButton_6", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.223700, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.254200, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the + command button
            set handle = BlzGetFrameByName("CommandButton_7", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.00242900, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.0342090, 0.0150000)
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the Q command button
            set handle = BlzGetFrameByName("CommandButton_8", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.0399070, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.0716870, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the W command button
            set handle = BlzGetFrameByName("CommandButton_9", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.0765555, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.1095555, 0.0150000)
            call BlzFrameSetSize(handle, 0.03178, 0.03178) 
            
            // Reposition the E command button
            set handle = BlzGetFrameByName("CommandButton_10", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.113070, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.144850, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178) 
            
            // Reposition the R command button
            set handle = BlzGetFrameByName("CommandButton_11", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.150070, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.181850, 0.0150000)
            call BlzFrameSetSize(handle, 0.03178, 0.03178)

            set handle = null
        endmethod

        private static method onInventoryButtons takes nothing returns nothing
            // Reposition the 0 inventory button
            set handle = BlzGetFrameByName("InventoryButton_0", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.552700, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.584480, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the 1 inventory button
            set handle = BlzGetFrameByName("InventoryButton_1", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.589100, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.621900, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the 2 inventory button
            set handle = BlzGetFrameByName("InventoryButton_2", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.625750, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.657530, 0.0150000)
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the 3 inventory button
            set handle = BlzGetFrameByName("InventoryButton_3", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.662999, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.694999, 0.0150000)
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the 4 inventory button
            set handle = BlzGetFrameByName("InventoryButton_4", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.699700, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.731480, 0.0150000) 
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            // Reposition the 5 inventory button
            set handle = BlzGetFrameByName("InventoryButton_5", 0) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.736555, 0.0467700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.768555, 0.0150000)
            call BlzFrameSetSize(handle, 0.03178, 0.03178)
            
            set handle = null
        endmethod

        private static method onInfoPanel takes nothing returns nothing
            // Reposition the Buff bar
            set handle = BlzGetOriginFrame(ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR, 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.364600, 0.0280800) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.476200, 0.0147800)  
            call BlzFrameSetScale(handle, 0.9)
            
            //Remove the Status text
            call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL, 0), 0.00001)
            
            // Remove Names and Descriptions
            call BlzFrameSetScale(BlzGetFrameByName("SimpleNameValue", 0), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleClassValue", 0), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleBuildingNameValue", 1), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleBuildingActionLabel", 1), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleHoldNameValue", 2), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleHoldDescriptionNameValue", 2), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleItemNameValue", 3), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleItemDescriptionValue", 3), 0.00001)
            call BlzFrameSetScale(BlzGetFrameByName("SimpleDestructableNameValue", 4), 0.00001)
            
            // Reposition the Hero Main Stat
            set handle = BlzGetFrameByName("InfoPanelIconHeroIcon", 6)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.449800, 0.0581100) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.474930, 0.0329900)

            // Reposition the Strength label and value
            set handle = BlzGetFrameByName("InfoPanelIconHeroStrengthLabel", 6)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.476900, 0.0757800) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.530850, 0.0624800) 
            set handle = BlzGetFrameByName("InfoPanelIconHeroStrengthValue", 6) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.480000, 0.0657200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.499950, 0.0553800) 

            // Reposition the Agility label and value
            set handle = BlzGetFrameByName("InfoPanelIconHeroAgilityLabel", 6)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.477400, 0.0559200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.532090, 0.0426200) 
            set handle = BlzGetFrameByName("InfoPanelIconHeroAgilityValue", 6) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.480300, 0.0445700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.500250, 0.0342300) 

            // Reposition the Intelligence label and value
            set handle = BlzGetFrameByName("InfoPanelIconHeroIntellectLabel", 6)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.476900, 0.0346500) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.531590, 0.0213500) 
            set handle = BlzGetFrameByName("InfoPanelIconHeroIntellectValue", 6) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.480600, 0.0240700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.500550, 0.0137300)  

            // Reposition the Timed Life bar
            set handle = BlzGetFrameByName("SimpleProgressIndicator", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.00000, 0.0100000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.770000, 0.00000)
            call BlzFrameSetSize(handle, 0.77000, 0.01000)
            
            // Reposition the XP bar
            set handle = BlzGetFrameByName("SimpleHeroLevelBar", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.00000, 0.0100000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.770000, 0.00000)
            call BlzFrameSetSize(handle, 0.77000, 0.01000)

            // Reposition the Training bar
            set handle = BlzGetFrameByName("SimpleBuildTimeIndicator", 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.00000, 0.0100000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.770000, 0.00000)
            call BlzFrameSetSize(handle, 0.77000, 0.01000)

            // Reposition the Attack 1 block
            set handle = BlzGetFrameByName("InfoPanelIconBackdrop", 0)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.261800, 0.0723200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.289140, 0.0449800) 
            call BlzFrameSetSize(handle, 0.02734, 0.02734)
            
            // Reposition the Armor block
            set handle = BlzGetFrameByName("InfoPanelIconBackdrop", 2)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.261100, 0.0439700) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.288440, 0.0166300) 
            call BlzFrameSetSize(handle, 0.02734, 0.02734)
            
            set handle = null
        endmethod

        private static method onPortrait takes nothing returns nothing
            set handle = BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0)

            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.373500, 0.0977600) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.431555, 0.0157400)

            set handle = null
        endmethod

        private static method onHeroCheck takes nothing returns nothing
            local integer i = GetPlayerId(GetLocalPlayer())

            if BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
                if GetLocalPlayer() == GetTriggerPlayer() then
                    set x1[i] = -0.131300
                    set x2[i] = -0.103220 
                    set y01[i] = 0.581980
                    set y02[i] = 0.553900
                    set y11[i] = 0.544980
                    set y12[i] = 0.516900
                    set y21[i] = 0.510680
                    set y22[i] = 0.482600
                    set y31[i] = 0.474280
                    set y32[i] = 0.446200
                    set y41[i] = 0.437880
                    set y42[i] = 0.409800
                    set y51[i] = 0.401480
                    set y52[i] = 0.373400
                    set y61[i] = 0.365080
                    set y62[i] = 0.337000
                endif

                // Reposition the hero button 0
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 0)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y01[i])
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y02[i])
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 0), 0.71)

                // Reposition the hero button 1
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 1)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y11[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y12[i])
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 1), 0.71)

                // Reposition the hero button 2
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 2)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y21[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y22[i])  
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 2), 0.71)

                // Reposition the hero button 3
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 3)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y31[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y32[i]) 
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 3), 0.71)

                // Reposition the hero button 4
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 4)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y41[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y42[i]) 
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 4), 0.71)

                // Reposition the hero button 5
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 5)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y51[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y52[i])  
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 5), 0.71)

                // Reposition the hero button 6
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 6)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y61[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y62[i]) 
                call BlzFrameSetScale(handle, 0.7)
                call BlzFrameSetScale(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR, 6), 0.71)

                set handle = null
            else
                if GetLocalPlayer() == GetTriggerPlayer() then
                    set x1[i] = 999.0
                    set x2[i] = 999.0
                    set y01[i] = 999.0
                    set y02[i] = 999.0
                    set y11[i] = 999.0
                    set y12[i] = 999.0
                    set y21[i] = 999.0
                    set y22[i] = 999.0
                    set y31[i] = 999.0
                    set y32[i] = 999.0
                    set y41[i] = 999.0
                    set y42[i] = 999.0
                    set y51[i] = 999.0
                    set y52[i] = 999.0
                    set y61[i] = 999.0
                    set y62[i] = 999.0
                endif

                // Hides the hero button 0
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 0)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y01[i])
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y02[i])

                // Hides the hero button 1
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 1)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y11[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y12[i])

                // Hides the hero button 2
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 2)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y21[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y22[i])

                // Hides the hero button 3
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 3)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y31[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y32[i]) 

                // Hides the hero button 4
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 4)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y41[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y42[i]) 

                // Hides the hero button 5
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 5)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y51[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y52[i])

                // Hides the hero button 6
                set handle = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 6)
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, x1[i], y61[i]) 
                call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, x2[i], y62[i])

                set handle = null
            endif
        endmethod

        private static method onGroupSelection takes nothing returns nothing
            // Reposistion the Group selection button 0
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 0), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.262600, 0.0776200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.285600, 0.0546200) 

            // Reposistion the Group selection button 1
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 1), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.295800, 0.0731200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.318800, 0.0501200)

            // Reposistion the Group selection button 2
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 2), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.328300, 0.0731200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.351300, 0.0501200)  

            // Reposistion the Group selection button 3
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 3), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.262600, 0.0414100) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.285600, 0.0184100)
            
            // Reposistion the Group selection button 4
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 4), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.295800, 0.0414000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.318800, 0.0184000) 

            // Reposistion the Group selection button 5
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 5), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.329100, 0.0414000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.352100, 0.0184000) 

            // Reposistion the Group selection button 6
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 6), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.449300, 0.0731200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.472300, 0.0501200) 

            // Reposistion the Group selection button 7
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 7), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.483500, 0.0731200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.506500, 0.0501200)  

            // Reposistion the Group selection button 8
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 8), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.516800, 0.0731200) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.539800, 0.0501200) 

            // Reposistion the Group selection button 9
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 9), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.450300, 0.0414000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.473300, 0.0184000)

            // Reposistion the Group selection button 10
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 10), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.483500, 0.0414000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.506500, 0.0184000)  

            // Reposistion the Group selection button 11
            set handle = BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetChild(BlzFrameGetParent(BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)), 5), 0), 11), 1)
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_TOPLEFT, 0.516800, 0.0414000) 
            call BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMRIGHT, 0.539800, 0.0184000)  

            set handle = null
        endmethod

        private static method onResources takes nothing returns nothing
            call BlzFrameSetText(Gold, "|cffffcc00" + I2S(GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD)) + "|r")
            call BlzFrameSetText(Lumber, "|cff00ff00" + I2S(GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER)) + "|r")
        endmethod

        private static method onPeriod takes nothing returns nothing
            local integer i = 0
            local real newHP
            local real newMP
            local string newHptext
            local string newMptext
            local thistype this

            loop
                exitwhen i > key
                    set this = array[i]

                    if GetPlayerSlotState(player) != PLAYER_SLOT_STATE_LEFT then
                        set health = BlzFrameGetValue(HealthBar) 
                        set mana = BlzFrameGetValue(ManaBar)
                        set newHP = GetUnitLifePercent(unit)
                        set newMP = GetUnitManaPercent(unit)
                        set hp = BlzFrameGetText(HPText)
                        set mp = BlzFrameGetText(MPText)
                        set newHptext = I2S(R2I(GetWidgetLife(unit))) + " / " + I2S(BlzGetUnitMaxHP(unit))
                        set newMptext = I2S(R2I(GetUnitState(unit,  UNIT_STATE_MANA))) + " / " + I2S(BlzGetUnitMaxMana(unit))

                        if GetLocalPlayer() == player then
                            set health = newHP
                            set mana = newMP
                            set hp = newHptext
                            set mp = newMptext
                        endif

                        call BlzFrameSetValue(HealthBar, health)
                        call BlzFrameSetValue(ManaBar, mana)
                        call BlzFrameSetText(HPText, "|cffFFFFFF" + hp + "|r")
                        call BlzFrameSetText(MPText, "|cffFFFFFF" + mp + "|r")
                    else
                        set i = remove(i)
                    endif
                set i = i + 1
            endloop
        endmethod

        private static method onSelect takes nothing returns nothing
            local integer id = GetPlayerId(GetTriggerPlayer())
            local thistype this
            
            if struct[id] != 0 then
                set this = struct[id]
            else
                set this = thistype.allocate()
                set .id = id
                set player = GetTriggerPlayer()
                set group = CreateGroup()
                set health = 0
                set mana = 0
                set hp = "0 / 0"
                set mp = "0 / 0"
                set key = key + 1
                set array[key] = this
                set struct[id] = this
                
                if key == 0 then
                    call TimerStart(timer, 0.05, true, function thistype.onPeriod)
                endif
            endif
            
            if not IsUnitInGroup(GetTriggerUnit(), group) then
                call GroupAddUnit(group, GetTriggerUnit())
            endif

            set unit = FirstOfGroup(group)
        endmethod

        private static method onDeselect takes nothing returns nothing
            local integer id = GetPlayerId(GetTriggerPlayer())
            local thistype this
            
            if struct[id] != 0 then
                set this = struct[id]
                
                if IsUnitInGroup(GetTriggerUnit(), group) then
                    call GroupRemoveUnit(group, GetTriggerUnit())
                endif

                set unit = FirstOfGroup(group)
            endif
        endmethod

        private static method onDeath takes nothing returns nothing
            local unit u = GetTriggerUnit()
            local integer id = GetPlayerId(GetOwningPlayer(u))
            local thistype this

            if struct[id] != 0 then
                set this = struct[id]
                call GroupRemoveUnit(group, u)
                set unit = FirstOfGroup(group)
            endif

            set u = null
        endmethod

        private static method onInit takes nothing returns nothing
            local integer i = 0

            call BlzFrameSetAlpha(BlzGetFrameByName("SimpleInventoryCover", 0), 0)
            call BlzFrameSetScale(BlzGetFrameByName("InventoryText", 0), 0.0001)
            call BlzFrameSetAbsPoint(BlzGetFrameByName("ConsoleUI", 0), FRAMEPOINT_TOPLEFT, 0.0, 0.633)
            call BlzFrameSetVisible(BlzGetFrameByName("ResourceBarFrame", 0), false)
            call BlzFrameSetVisible(BlzGetFrameByName("UpperButtonBarFrame", 0), false)
            call BlzFrameSetVisible(BlzFrameGetChild(BlzGetFrameByName("ConsoleUI", 0), 7), false)
            call BlzFrameSetVisible(BlzFrameGetChild(BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 5),0), false)

            set UI = BlzCreateFrameByType("BACKDROP", "UI", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 1) 
            call BlzFrameSetAbsPoint(UI, FRAMEPOINT_TOPLEFT, 0.00000, 0.100000) 
            call BlzFrameSetAbsPoint(UI, FRAMEPOINT_BOTTOMRIGHT, 0.770000, 0.00000) 
            call BlzFrameSetTexture(UI, "UI.blp", 0, true) 

            set HealthBar = BlzCreateFrameByType("SIMPLESTATUSBAR", "", UI, "", 0) 
            call BlzFrameSetTexture(HealthBar, "replaceabletextures\\teamcolor\\teamcolor00", 0, true) 
            call BlzFrameSetAbsPoint(HealthBar, FRAMEPOINT_TOPLEFT, 0.0386400, 0.0778900) 
            call BlzFrameSetAbsPoint(HealthBar, FRAMEPOINT_BOTTOMRIGHT, 0.255140, 0.0535100) 
            call BlzFrameSetValue(HealthBar, 0) 

            set ManaBar = BlzCreateFrameByType("SIMPLESTATUSBAR", "", UI, "", 0) 
            call BlzFrameSetTexture(ManaBar, "replaceabletextures\\teamcolor\\teamcolor01", 0, true) 
            call BlzFrameSetAbsPoint(ManaBar, FRAMEPOINT_TOPLEFT, 0.551500, 0.0778000) 
            call BlzFrameSetAbsPoint(ManaBar, FRAMEPOINT_BOTTOMRIGHT, 0.768000, 0.0534200)
            call BlzFrameSetValue(ManaBar, 0)  

            set HeroCheck = BlzCreateFrame("QuestCheckBox", UI, 0, 0) 
            call BlzFrameSetAbsPoint(HeroCheck, FRAMEPOINT_TOPLEFT, -0.131300, 0.600240) 
            call BlzFrameSetAbsPoint(HeroCheck, FRAMEPOINT_BOTTOMRIGHT, -0.117260, 0.586200)

            set HPText = BlzCreateFrameByType("TEXT", "HPTEXT", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0) 
            call BlzFrameSetAbsPoint(HPText, FRAMEPOINT_TOPLEFT, 0.108100, 0.0726300) 
            call BlzFrameSetAbsPoint(HPText, FRAMEPOINT_BOTTOMRIGHT, 0.184960, 0.0585900) 
            call BlzFrameSetText(HPText, "|cffFFFFFF|r") 
            call BlzFrameSetEnable(HPText, false) 
            call BlzFrameSetScale(HPText, 1.00) 
            call BlzFrameSetTextAlignment(HPText, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE) 

            set MPText = BlzCreateFrameByType("TEXT", "MPTEXT", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0) 
            call BlzFrameSetAbsPoint(MPText, FRAMEPOINT_TOPLEFT, 0.622500, 0.0726000) 
            call BlzFrameSetAbsPoint(MPText, FRAMEPOINT_BOTTOMRIGHT, 0.699360, 0.0585600) 
            call BlzFrameSetText(MPText, "|cffFFFFFF|r") 
            call BlzFrameSetEnable(MPText, false) 
            call BlzFrameSetScale(MPText, 1.00) 
            call BlzFrameSetTextAlignment(MPText, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE) 

            set Lumber = BlzCreateFrameByType("TEXT", "GOLD", UI, "", 0) 
            call BlzFrameSetAbsPoint(Lumber, FRAMEPOINT_TOPLEFT, 0.291100, 0.0970200) 
            call BlzFrameSetAbsPoint(Lumber, FRAMEPOINT_BOTTOMRIGHT, 0.346530, 0.0815000) 
            call BlzFrameSetText(Lumber, "|cff00ff00|r") 
            call BlzFrameSetEnable(Lumber, false) 
            call BlzFrameSetScale(Lumber, 1.00) 
            call BlzFrameSetTextAlignment(Lumber, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_RIGHT) 

            set Gold = BlzCreateFrameByType("TEXT", "LUMBER", UI, "", 0) 
            call BlzFrameSetAbsPoint(Gold, FRAMEPOINT_TOPLEFT, 0.460600, 0.0972500) 
            call BlzFrameSetAbsPoint(Gold, FRAMEPOINT_BOTTOMRIGHT, 0.516030, 0.0817300) 
            call BlzFrameSetText(Gold, "|cffffcc00|r") 
            call BlzFrameSetEnable(Gold, false) 
            call BlzFrameSetScale(Gold, 1.00) 
            call BlzFrameSetTextAlignment(Gold, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT) 
            
            call onCommandButtons()
            call onInventoryButtons()
            call onInfoPanel()
            call onPortrait()
            call onGroupSelection()

            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_SELECTED, function thistype.onSelect)
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_DESELECTED, function thistype.onDeselect)
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_DEATH, function thistype.onDeath)
            call BlzTriggerRegisterFrameEvent(herotrigger, HeroCheck, FRAMEEVENT_CHECKBOX_CHECKED) 
            call BlzTriggerRegisterFrameEvent(herotrigger, HeroCheck, FRAMEEVENT_CHECKBOX_UNCHECKED) 
            call TriggerAddAction(herotrigger, function thistype.onHeroCheck)
            call TimerStart(CreateTimer(), 0.2, true, function thistype.onResources) 

            loop
                exitwhen i > 24
                    set x1[i] = 999.0
                    set x2[i] = 999.0
                    set y01[i] = 999.0
                    set y02[i] = 999.0
                    set y11[i] = 999.0
                    set y12[i] = 999.0
                    set y21[i] = 999.0
                    set y22[i] = 999.0
                    set y31[i] = 999.0
                    set y32[i] = 999.0
                    set y41[i] = 999.0
                    set y42[i] = 999.0
                    set y51[i] = 999.0
                    set y52[i] = 999.0
                    set y61[i] = 999.0
                    set y62[i] = 999.0
                set i = i + 1
            endloop
        endmethod
    endstruct
endlibrary

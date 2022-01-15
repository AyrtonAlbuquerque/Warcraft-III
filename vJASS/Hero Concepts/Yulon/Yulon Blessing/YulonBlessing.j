library YulonBlessing requires RegisterPlayerUnitEvent, Utilities
    /* -------------------- Yulon Blessing v1.1 by Chopinski -------------------- */
    // Credits:
    //     Magtheridon96  - RegisterPlayerUnitEvent
    //     Palaslayer     - icon
    //     AZ             - Model
    /* ----------------------------------- END ---------------------------------- */
    
    /* -------------------------------------------------------------------------- */
    /*                                Configuration                               */
    /* -------------------------------------------------------------------------- */
    globals
        // The raw code of the Ability
        private constant integer ABILITY          = 'A004'
        // The Model
        private constant string  MODEL            = "DragonBless.mdl"
        // The model in the caster
        private constant string  CASTER_MODEL     = "Abilities\\Spells\\Undead\\ReplenishMana\\ReplenishManaCaster.mdl"
        // The attachment point
        private constant string  ATTACH_POINT     = "origin"
    endglobals

    // The AOE
    private function GetAoE takes unit source, integer level returns real
         return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, ABILITY), ABILITY_RLF_AREA_OF_EFFECT, level - 1)
    endfunction
    
    // The percentage of health converted per level
    private function GetPercentage takes integer level returns real
        return 0.02 + 0.*level
    endfunction
    
    // The minimum health percentage allowed for a conversion to occur
    private function GetMinHealthPercentage takes integer level returns real
        return 10. + 0.*level
    endfunction
    
    // The ability period
    private function GetPeriod takes unit source, integer level returns real
        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, ABILITY), ABILITY_RLF_COOLDOWN, level - 1)
    endfunction

    // The Unit Filter.
    private function UnitFilter takes player p, unit u returns boolean
        return UnitAlive(u) and IsUnitAlly(u, p) and not IsUnitType(u, UNIT_TYPE_STRUCTURE)
    endfunction

    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    private struct YulonBlessing
        private static integer array array
        private static boolean array active
    
        timer timer
        unit unit
        group group
        player player
        integer id
    
        private method execute takes nothing returns nothing
            local integer level = GetUnitAbilityLevel(unit, ABILITY)
            local real amount
            local unit u
            
            if GetUnitLifePercent(unit) >= GetMinHealthPercentage(level) and UnitAlive(unit) then
                set amount = BlzGetUnitMaxHP(unit)*GetPercentage(level)
                
                call DestroyEffectTimed(AddSpecialEffectTarget(CASTER_MODEL, unit, ATTACH_POINT), 1)
                call SetWidgetLife(unit, GetWidgetLife(unit) - amount)
                call AddUnitMana(unit, amount)
                call GroupEnumUnitsInRange(group, GetUnitX(unit), GetUnitY(unit), GetAoE(unit, level), null)
                call GroupRemoveUnit(group, unit)
                loop
                    set u = FirstOfGroup(group)
                    exitwhen u == null
                        if UnitFilter(player, u) then
                            call DestroyEffect(AddSpecialEffectTarget(MODEL, u, ATTACH_POINT))
                            call SetWidgetLife(u, GetWidgetLife(u) + amount)
                            call AddUnitMana(u, amount)
                        endif
                    call GroupRemoveUnit(group, u)
                endloop
            else
                call IssueImmediateOrderById(unit, 852544)
            endif
        endmethod
    
        private static method onPeriod takes nothing returns nothing
            local thistype this = GetTimerData(GetExpiredTimer())
            local integer level = GetUnitAbilityLevel(unit, ABILITY)
            
            if level > 0 then
                if active[id] then
                    call execute()
                endif
            else
                call ReleaseTimer(timer)
                call DestroyGroup(group)
                call deallocate()
                
                set array[id] = 0
                set unit = null
                set timer = null
                set group = null
                set player = null
            endif
        endmethod
        
        private static method onOrder takes nothing returns nothing
            local integer order = GetIssuedOrderId()
            local integer id
            local unit source
            local thistype this
        
            if order == 852543 or order == 852544 then
                set source = GetOrderedUnit()
                set id = GetUnitUserData(source)
                set active[id] = order == 852543
                
                if array[id] != 0 then
                    set this = array[id]
                else
                    set this = thistype.allocate()
                    set timer = NewTimerEx(this)
                    set unit = source
                    set group = CreateGroup()
                    set player = GetOwningPlayer(source)
                    set .id = id
                    set array[id] = this
                endif
                
                if active[id] then
                    call TimerStart(timer, GetPeriod(source, GetUnitAbilityLevel(source, ABILITY)), true, function thistype.onPeriod)
                else
                    call PauseTimer(timer)
                endif
            endif

            set source = null
        endmethod
        
        private static method onCast takes nothing returns nothing
            local thistype this
            
            if array[Spell.source.id] != 0 then
                set this = array[Spell.source.id]
            else
                set this = thistype.allocate()
                set timer = NewTimerEx(this)
                set unit = Spell.source.unit
                set group = CreateGroup()
                set player = Spell.source.player
                set id = Spell.source.id
                set array[id] = this
            endif
            call execute()
        endmethod
        
        private static method onLevel takes nothing returns nothing
            local unit source
        
            if GetLearnedSkill() == ABILITY then
                set source = GetTriggerUnit()

                if active[GetUnitUserData(source)] then
                    call IssueImmediateOrderById(source, 852544)
                    call IssueImmediateOrderById(source, 852543)
                endif
            endif
            
            set source = null
        endmethod

        private static method onInit takes nothing returns nothing
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, function thistype.onOrder)
            call RegisterSpellEffectEvent(ABILITY, function thistype.onCast)
            call RegisterPlayerUnitEvent(EVENT_PLAYER_HERO_SKILL, function thistype.onLevel)
        endmethod
    endstruct
endlibrary
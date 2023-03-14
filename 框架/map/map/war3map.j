globals
//globals from BzAPI:
constant boolean LIBRARY_BzAPI=true
//endglobals from BzAPI
//globals from DzAPI:
constant boolean LIBRARY_DzAPI=true
//endglobals from DzAPI
//globals from XmAPI:
constant boolean LIBRARY_XmAPI=true
trigger xm_DamageEventTrigger= null
integer XmAPI__DamageEventNumber= 0
trigger array XmAPI__DamageEventQueue
	
integer xm_DebugUI= 0
integer xm_DebugUITimer= 0
//endglobals from XmAPI
//globals from XmUI:
constant boolean LIBRARY_XmUI=true
//endglobals from XmUI
//globals from YDTriggerSaveLoadSystem:
constant boolean LIBRARY_YDTriggerSaveLoadSystem=true
hashtable YDHT
hashtable YDLOC
//endglobals from YDTriggerSaveLoadSystem
//globals from YDWEYDWEJapiScript:
constant boolean LIBRARY_YDWEYDWEJapiScript=true
constant integer YDWE_OBJECT_TYPE_ABILITY= 0
constant integer YDWE_OBJECT_TYPE_BUFF= 1
constant integer YDWE_OBJECT_TYPE_UNIT= 2
constant integer YDWE_OBJECT_TYPE_ITEM= 3
constant integer YDWE_OBJECT_TYPE_UPGRADE= 4
constant integer YDWE_OBJECT_TYPE_DOODAD= 5
constant integer YDWE_OBJECT_TYPE_DESTRUCTABLE= 6
//endglobals from YDWEYDWEJapiScript
rect gg_rct_1= null
rect gg_rct______________001awefawefawef1234= null
rect gg_rct______________002_______123456= null
rect gg_rct______________002_______123456_______u= null
trigger gg_trg_4___________________u= null
trigger gg_trg_4_1___________________u= null
trigger gg_trg_1________________u= null
trigger gg_trg_1_______ui= null
trigger gg_trg_1_______ui2= null
trigger gg_trg_2___________________u= null
trigger gg_trg_3________________u= null
trigger gg_trg_runtime_init= null

trigger l__library_init

//JASSHelper struct globals:

endglobals
    native DzGetMouseTerrainX takes nothing returns real
    native DzGetMouseTerrainY takes nothing returns real
    native DzGetMouseTerrainZ takes nothing returns real
    native DzIsMouseOverUI takes nothing returns boolean
    native DzGetMouseX takes nothing returns integer
    native DzGetMouseY takes nothing returns integer
    native DzGetMouseXRelative takes nothing returns integer
    native DzGetMouseYRelative takes nothing returns integer
    native DzSetMousePos takes integer x, integer y returns nothing
    native DzTriggerRegisterMouseEvent takes trigger trig, integer btn, integer status, boolean sync, string func returns nothing
    native DzTriggerRegisterMouseEventByCode takes trigger trig, integer btn, integer status, boolean sync, code funcHandle returns nothing
    native DzTriggerRegisterKeyEvent takes trigger trig, integer key, integer status, boolean sync, string func returns nothing
    native DzTriggerRegisterKeyEventByCode takes trigger trig, integer key, integer status, boolean sync, code funcHandle returns nothing
    native DzTriggerRegisterMouseWheelEvent takes trigger trig, boolean sync, string func returns nothing
    native DzTriggerRegisterMouseWheelEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    native DzTriggerRegisterMouseMoveEvent takes trigger trig, boolean sync, string func returns nothing
    native DzTriggerRegisterMouseMoveEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    native DzGetTriggerKey takes nothing returns integer
    native DzGetWheelDelta takes nothing returns integer
    native DzIsKeyDown takes integer iKey returns boolean
    native DzGetTriggerKeyPlayer takes nothing returns player
    native DzGetWindowWidth takes nothing returns integer
    native DzGetWindowHeight takes nothing returns integer
    native DzGetWindowX takes nothing returns integer
    native DzGetWindowY takes nothing returns integer
    native DzTriggerRegisterWindowResizeEvent takes trigger trig, boolean sync, string func returns nothing
    native DzTriggerRegisterWindowResizeEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    native DzIsWindowActive takes nothing returns boolean
    native DzDestructablePosition takes destructable d, real x, real y returns nothing
    native DzSetUnitPosition takes unit whichUnit, real x, real y returns nothing
    native DzExecuteFunc takes string funcName returns nothing
    native DzGetUnitUnderMouse takes nothing returns unit
    native DzSetUnitTexture takes unit whichUnit, string path, integer texId returns nothing
    native DzSetMemory takes integer address, real value returns nothing
    native DzSetUnitID takes unit whichUnit, integer id returns nothing
    native DzSetUnitModel takes unit whichUnit, string path returns nothing
    native DzSetWar3MapMap takes string map returns nothing
    native DzGetLocale takes nothing returns string
    native DzGetUnitNeededXP takes unit whichUnit, integer level returns integer
    native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing
    native DzSyncData takes string prefix, string data returns nothing
    native DzGetTriggerSyncData takes nothing returns string
    native DzGetTriggerSyncPlayer takes nothing returns player
    native DzFrameHideInterface takes nothing returns nothing
    native DzFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing
    native DzFrameGetPortrait takes nothing returns integer
    native DzFrameGetMinimap takes nothing returns integer
    native DzFrameGetCommandBarButton takes integer row, integer column returns integer
    native DzFrameGetHeroBarButton takes integer buttonId returns integer
    native DzFrameGetHeroHPBar takes integer buttonId returns integer
    native DzFrameGetHeroManaBar takes integer buttonId returns integer
    native DzFrameGetItemBarButton takes integer buttonId returns integer
    native DzFrameGetMinimapButton takes integer buttonId returns integer
    native DzFrameGetUpperButtonBarButton takes integer buttonId returns integer
    native DzFrameGetTooltip takes nothing returns integer
    native DzFrameGetChatMessage takes nothing returns integer
    native DzFrameGetUnitMessage takes nothing returns integer
    native DzFrameGetTopMessage takes nothing returns integer
    native DzGetColor takes integer r, integer g, integer b, integer a returns integer
    native DzFrameSetUpdateCallback takes string func returns nothing
    native DzFrameSetUpdateCallbackByCode takes code funcHandle returns nothing
    native DzFrameShow takes integer frame, boolean enable returns nothing
    native DzCreateFrame takes string frame, integer parent, integer id returns integer
    native DzCreateSimpleFrame takes string frame, integer parent, integer id returns integer
    native DzDestroyFrame takes integer frame returns nothing
    native DzLoadToc takes string fileName returns nothing
    native DzFrameSetPoint takes integer frame, integer point, integer relativeFrame, integer relativePoint, real x, real y returns nothing
    native DzFrameSetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
    native DzFrameClearAllPoints takes integer frame returns nothing
    native DzFrameSetEnable takes integer name, boolean enable returns nothing
    native DzFrameSetScript takes integer frame, integer eventId, string func, boolean sync returns nothing
    native DzFrameSetScriptByCode takes integer frame, integer eventId, code funcHandle, boolean sync returns nothing
    native DzGetTriggerUIEventPlayer takes nothing returns player
    native DzGetTriggerUIEventFrame takes nothing returns integer
    native DzFrameFindByName takes string name, integer id returns integer
    native DzSimpleFrameFindByName takes string name, integer id returns integer
    native DzSimpleFontStringFindByName takes string name, integer id returns integer
    native DzSimpleTextureFindByName takes string name, integer id returns integer
    native DzGetGameUI takes nothing returns integer
    native DzClickFrame takes integer frame returns nothing
    native DzSetCustomFovFix takes real value returns nothing
    native DzEnableWideScreen takes boolean enable returns nothing
    native DzFrameSetText takes integer frame, string text returns nothing
    native DzFrameGetText takes integer frame returns string
    native DzFrameSetTextSizeLimit takes integer frame, integer size returns nothing
    native DzFrameGetTextSizeLimit takes integer frame returns integer
    native DzFrameSetTextColor takes integer frame, integer color returns nothing
    native DzGetMouseFocus takes nothing returns integer
    native DzFrameSetAllPoints takes integer frame, integer relativeFrame returns boolean
    native DzFrameSetFocus takes integer frame, boolean enable returns boolean
    native DzFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing
    native DzFrameGetEnable takes integer frame returns boolean
    native DzFrameSetAlpha takes integer frame, integer alpha returns nothing
    native DzFrameGetAlpha takes integer frame returns integer
    native DzFrameSetAnimate takes integer frame, integer animId, boolean autocast returns nothing
    native DzFrameSetAnimateOffset takes integer frame, real offset returns nothing
    native DzFrameSetTexture takes integer frame, string texture, integer flag returns nothing
    native DzFrameSetScale takes integer frame, real scale returns nothing
    native DzFrameSetTooltip takes integer frame, integer tooltip returns nothing
    native DzFrameCageMouse takes integer frame, boolean enable returns nothing
    native DzFrameGetValue takes integer frame returns real
    native DzFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing
    native DzFrameSetStepValue takes integer frame, real step returns nothing
    native DzFrameSetValue takes integer frame, real value returns nothing
    native DzFrameSetSize takes integer frame, real w, real h returns nothing
    native DzCreateFrameByTagName takes string frameType, string name, integer parent, string template, integer id returns integer
    native DzFrameSetVertexColor takes integer frame, integer color returns nothing
    native DzOriginalUIAutoResetPoint takes boolean enable returns nothing
    native DzFrameSetPriority takes integer frame, integer priority returns nothing
    native DzFrameSetParent takes integer frame, integer parent returns nothing
    native DzFrameGetHeight takes integer frame returns real
    native DzFrameSetFont takes integer frame, string fileName, real height, integer flag returns nothing
    native DzFrameGetParent takes integer frame returns integer
    native DzFrameSetTextAlignment takes integer frame, integer align returns nothing
    native DzFrameGetName takes integer frame returns string
    native EXSetUnitArrayString takes integer uid, integer id,integer n,string name returns boolean
	native EXSetUnitInteger takes integer uid, integer id,integer n returns boolean
	native DzAPI_Map_SaveServerValue takes player whichPlayer, string key, string value returns boolean
	native DzAPI_Map_GetServerValue takes player whichPlayer, string key returns string
	native DzAPI_Map_Ladder_SetStat takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_IsRPGLadder takes nothing returns boolean
	native DzAPI_Map_GetGameStartTime takes nothing returns integer
	native DzAPI_Map_Stat_SetStat takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetMatchType takes nothing returns integer
	native DzAPI_Map_Ladder_SetPlayerStat takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetServerValueErrorCode takes player whichPlayer returns integer
	native DzAPI_Map_GetLadderLevel takes player whichPlayer returns integer
	native DzAPI_Map_IsRedVIP takes player whichPlayer returns boolean
	native DzAPI_Map_IsBlueVIP takes player whichPlayer returns boolean
	native DzAPI_Map_GetLadderRank takes player whichPlayer returns integer
	native DzAPI_Map_GetMapLevelRank takes player whichPlayer returns integer
	native DzAPI_Map_GetGuildName takes player whichPlayer returns string
	native DzAPI_Map_GetGuildRole takes player whichPlayer returns integer
	native DzAPI_Map_IsRPGLobby takes nothing returns boolean
	native DzAPI_Map_GetMapLevel takes player whichPlayer returns integer
	native DzAPI_Map_MissionComplete takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetActivityData takes nothing returns string
	native DzAPI_Map_GetMapConfig takes string key returns string
	native DzAPI_Map_HasMallItem takes player whichPlayer, string key returns boolean
	native DzAPI_Map_SavePublicArchive takes player whichPlayer, string key, string value returns boolean
	native DzAPI_Map_GetPublicArchive takes player whichPlayer, string key returns string
	native DzAPI_Map_UseConsumablesItem takes player whichPlayer, string key returns nothing
	native DzAPI_Map_OrpgTrigger takes player whichPlayer, string key returns nothing
	native DzAPI_Map_GetServerArchiveDrop takes player whichPlayer, string key returns string
	native DzAPI_Map_GetServerArchiveEquip takes player whichPlayer, string key returns integer
	native RequestExtraIntegerData takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns integer
	native RequestExtraBooleanData takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns boolean
	native RequestExtraStringData takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns string
	native RequestExtraRealData takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns real
	native DzAPI_Map_GetPlatformVIP takes player whichPlayer returns integer
	native XMAddLocalEffect takes string path,real x,real y returns effect
	native XMSetEffectXY takes effect e,real x,real y returns nothing
	native XMSetEffectModel takes effect e,string path returns nothing
	native XMSetEffectAnimateByIndex takes effect e,integer index,boolean autocast returns nothing
	native XMSetEffectAnimate takes effect e,string aniname returns nothing
	native XMSetEffectVertexColor takes effect e,integer red, integer green, integer blue, integer alpha returns nothing
	native XMEnumEffectInRect takes rect r, boolexpr filter, code actionFunc returns nothing
	native XMEnumEffectInRange takes real x,real y, real radius, boolexpr filter, code actionFunc returns nothing
	native XMGetEnumEffect takes nothing returns effect
	native XMGetFilterEffect takes nothing returns effect
	native XMFrameSetAttr takes integer frame,integer t,string attr returns nothing
	native XMFrameGetAttr takes integer frame,integer t returns string
	native XMFrameSetAttrInteger takes integer frame,integer t,integer attr returns nothing
	native XMFrameGetAttrInteger takes integer frame,integer t returns integer
	native XMFrameSetAttrReal takes integer frame,integer t,real attr returns nothing
	native XMFrameGetAttrReal takes integer frame,integer t returns real
	native XMFrameClearAttr takes integer frame,integer t returns nothing
	native XMFrameFindByName takes string name,integer id returns integer
	native XMFrameFindChildByName takes integer frame,string name,integer id returns integer
	native XMFrameGetWidth takes integer frame returns real
	native XMFrameGetHeight takes integer frame returns real
	native XMFrameGetPointType takes integer frame,integer point returns integer
	native XMFrameGetRelativeFrame takes integer frame,integer point returns integer
	native XMFrameGetRelativePoint takes integer frame,integer point returns integer
	native XMFrameGetX takes integer frame,integer point returns real
	native XMFrameGetY takes integer frame,integer point returns real
	native XMFrameGetScale takes integer frame returns real
	native XMFrameIsVisible takes integer frame returns boolean
	native XMFrameGetTextWidth takes integer frame returns real
	native XMFrameGetTextHeight takes integer frame returns real
	native XMFrameSetViewPort takes integer frame, boolean isview returns nothing
	native XMFrameSetCameraSource takes integer frame,real x,real y,real z returns nothing
	native XMFrameSetCameraTarget takes integer frame,real x,real y,real z returns nothing
	native XMFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing
	native XMFrameAddEffect takes integer frame, string modelFile, string attachPointName returns effect
	native XMFrameSetModelMatReset takes integer frame returns nothing
	native XMFrameSetModelXY takes integer frame,real x,real y returns nothing
	native XMFrameSetModelZ takes integer frame,real z returns nothing
	native XMFrameSetModelVertexColor takes integer frame,integer red, integer green, integer blue, integer alpha returns nothing
	native XMFrameSetModelAnimateByIndex takes integer frame,integer seq, boolean autocast returns nothing
	native XMFrameSetModelAnimate takes integer frame,string ani returns nothing
	native XMFrameSetModelScale takes integer frame,real scalex,real scaley,real scalez returns nothing
	native XMFrameSetModelSize takes integer frame,real size returns nothing
	native XMFrameSetModelRotateX takes integer frame,real rotatex returns nothing
	native XMFrameSetModelRotateY takes integer frame,real rotatex returns nothing
	native XMFrameSetModelRotateZ takes integer frame,real rotatex returns nothing
	native XMGetCommandButtonType takes integer x,integer y returns integer
	native XMGetCommandButtonId takes integer x,integer y returns integer
	native XMSetItemAttr takes item o,integer t,string attr returns nothing
	native XMGetItemAttr takes item o,integer t returns string
	native XMClearItemAttr takes item o,integer t returns nothing
	native XMShowHPInterface takes integer v returns nothing
	native XMHPSetUpdateCallback takes code actionFunc returns nothing
	native XMHPIsShow takes nothing returns boolean
	native XMStopUpdateHP takes nothing returns nothing
	native XMGetHPUIInterface takes nothing returns integer
	native XMUnitToScreen takes unit o,location loc returns boolean
	native XMGetUnitHeight takes unit o returns real
	native XMSetUnitModel takes unit o,string model returns nothing
	native XMTestFrame takes integer frame returns nothing
	native XMSetUnitAttr takes unit o,integer t,string attr returns nothing
	native XMGetUnitAttr takes unit o,integer t returns string
	native XMSetUnitAttrInteger takes unit o,integer t,integer attr returns nothing
	native XMGetUnitAttrInteger takes unit o,integer t returns integer
	native XMSetUnitAttrReal takes unit o,integer t,real attr returns nothing
	native XMGetUnitAttrReal takes unit o,integer t returns real
	native XMClearUnitAttr takes unit o,integer t returns nothing
	native XMShowUnitName takes boolean o returns nothing
	native XMGetPlayerSelectUnit takes player p returns unit
	native XMGetPlayerSelectUnitToGroup takes group g, player p returns integer
	native XMDestructablesToScreen takes destructable o,location loc returns boolean
	native XMGetTime takes nothing returns real
	native XMCreateTimer takes nothing returns integer
	native XMGetExpiredTimer takes nothing returns integer
	native XMTimerStart takes integer id, real time, boolean l, code c returns nothing
	native XMDestroyTimer takes integer id returns nothing
	native XMAddUpdateCallback takes string id,code c returns nothing
	native XMRemoveUpdateCallback takes string id returns nothing
	native XMPostWindowMessage takes integer Msg, integer wParam, integer lParam returns nothing
	native XMExit takes nothing returns integer
	native XMStoreEncrypt takes nothing returns nothing
	native XMUnlockFps takes boolean isunlock returns nothing
	native XMGetFrameEditBlackBorders takes location loc returns integer
	native XMWorldToScreen takes location loc,real x,real y,real z returns real
	native XMGetFPS takes nothing returns real
	native XMExecuteTrigger takes trigger t returns nothing
	native XMGetTriggerName takes trigger t returns string
	native XMGetScreenWidth takes nothing returns integer
	native XMGetScreenHeight takes nothing returns integer
	native XMSetWar3Size takes integer width,integer height,boolean islock returns nothing
	native XMGetWar3IsWindow takes nothing returns boolean
	native XMGetWar3IsLock takes nothing returns boolean
	native XMGetMapName takes nothing returns string
	native XMLeak takes string mode returns string
	native XMRandom takes integer low, integer high returns integer
	native XMRandomSeed takes integer seed returns nothing
	native XMAsynCheck takes string host returns nothing
	native XMAsynFilter takes trigger t returns nothing
	native XMGetUserID takes player p returns string
	native XMCreateWebSocket takes string url, string protocol returns integer
	native XMCloseWebSocket takes integer id returns nothing
	native XMRegisterWebSocketEvent takes code c returns nothing
	native XMWebSocketID takes nothing returns integer
	native XMWebSocketEvent takes nothing returns integer
	native XMWebSocketError takes nothing returns integer
	native XMWebSocketData takes nothing returns string
	native XMSendWebSocket takes integer id, string data returns nothing
	native XMHttp takes string tag,string url,integer t,code c returns nothing
	native XMHttpStatus takes nothing returns integer
	native XMHttpIsSucceed takes nothing returns boolean
	native XMHttpTag takes nothing returns string
	native XMHttpHead takes nothing returns string
	native XMHttpData takes nothing returns string
	native XMDebug takes nothing returns nothing
	native XMCallLua takes string funname returns nothing
	native XMLuaParam_integer takes integer v returns nothing
	native XMLuaParam_real takes real v returns nothing
	native XMLuaParam_boolean takes boolean v returns nothing
	native XMLuaParam_string takes string v returns nothing
	native XMLuaParam_timer takes timer v returns nothing
	native XMLuaParam_trigger takes trigger v returns nothing
	native XMLuaParam_unit takes unit v returns nothing
	native XMLuaParam_item takes item v returns nothing
	native XMLuaParam_group takes group v returns nothing
	native XMLuaParam_player takes player v returns nothing
	native XMLuaParam_location takes location v returns nothing
	native XMLuaParam_destructable takes destructable v returns nothing
	native XMLuaParam_force takes force v returns nothing
	native XMLuaParam_rect takes rect v returns nothing
	native XMLuaParam_region takes region v returns nothing
	native XMLuaParam_sound takes sound v returns nothing
	native XMLuaParam_effect takes effect v returns nothing
	native XMLuaParam_unitpool takes unitpool v returns nothing
	native XMLuaParam_itempool takes itempool v returns nothing
	native XMLuaParam_quest takes quest v returns nothing
	native XMLuaParam_questitem takes questitem v returns nothing
	native XMLuaParam_timerdialog takes timerdialog v returns nothing
	native XMLuaParam_leaderboard takes leaderboard v returns nothing
	native XMLuaParam_multiboard takes multiboard v returns nothing
	native XMLuaParam_multiboarditem takes multiboarditem v returns nothing
	native XMLuaParam_trackable takes trackable v returns nothing
	native XMLuaParam_dialog takes dialog v returns nothing
	native XMLuaParam_button takes button v returns nothing
	native XMLuaParam_texttag takes texttag v returns nothing
	native XMLuaParam_lightning takes lightning v returns nothing
	native XMLuaParam_image takes image v returns nothing
	native XMLuaParam_fogstate takes fogstate v returns nothing
	native XMLuaParam_fogmodifier takes fogmodifier v returns nothing
	native XMLuaReturn_integer takes nothing returns integer
	native XMLuaReturn_real takes nothing returns real
	native XMLuaReturn_boolean takes nothing returns boolean
	native XMLuaReturn_string takes nothing returns string
	native XMLuaReturn_timer takes nothing returns timer
	native XMLuaReturn_trigger takes nothing returns trigger
	native XMLuaReturn_unit takes nothing returns unit
	native XMLuaReturn_item takes nothing returns item
	native XMLuaReturn_group takes nothing returns group
	native XMLuaReturn_player takes nothing returns player
	native XMLuaReturn_location takes nothing returns location
	native XMLuaReturn_destructable takes nothing returns destructable
	native XMLuaReturn_force takes nothing returns force
	native XMLuaReturn_rect takes nothing returns rect
	native XMLuaReturn_region takes nothing returns region
	native XMLuaReturn_sound takes nothing returns sound
	native XMLuaReturn_effect takes nothing returns effect
	native XMLuaReturn_unitpool takes nothing returns unitpool
	native XMLuaReturn_itempool takes nothing returns itempool
	native XMLuaReturn_quest takes nothing returns quest
	native XMLuaReturn_questitem takes nothing returns questitem
	native XMLuaReturn_timerdialog takes nothing returns timerdialog
	native XMLuaReturn_leaderboard takes nothing returns leaderboard
	native XMLuaReturn_multiboard takes nothing returns multiboard
	native XMLuaReturn_multiboarditem takes nothing returns multiboarditem
	native XMLuaReturn_trackable takes nothing returns trackable
	native XMLuaReturn_dialog takes nothing returns dialog
	native XMLuaReturn_button takes nothing returns button
	native XMLuaReturn_texttag takes nothing returns texttag
	native XMLuaReturn_lightning takes nothing returns lightning
	native XMLuaReturn_image takes nothing returns image
	native XMLuaReturn_fogstate takes nothing returns fogstate
	native XMLuaReturn_fogmodifier takes nothing returns fogmodifier
	native EXExecuteScript takes string script returns string


//library BzAPI:
    //hardware




























    //plus











    //sync




    //gui










































































    function DzTriggerRegisterMouseEventTrg takes trigger trg,integer status,integer btn returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterMouseEvent(trg, btn, status, true, null)
    endfunction
    function DzTriggerRegisterKeyEventTrg takes trigger trg,integer status,integer btn returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterKeyEvent(trg, btn, status, true, null)
    endfunction
    function DzTriggerRegisterMouseMoveEventTrg takes trigger trg returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterMouseMoveEvent(trg, true, null)
    endfunction
    function DzTriggerRegisterMouseWheelEventTrg takes trigger trg returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterMouseWheelEvent(trg, true, null)
    endfunction
    function DzTriggerRegisterWindowResizeEventTrg takes trigger trg returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterWindowResizeEvent(trg, true, null)
    endfunction
    function DzF2I takes integer i returns integer
        return i
    endfunction
    function DzI2F takes integer i returns integer
        return i
    endfunction
    function DzK2I takes integer i returns integer
        return i
    endfunction
    function DzI2K takes integer i returns integer
        return i
    endfunction
 function DzTriggerRegisterMallItemSyncData takes trigger trig returns nothing
		call DzTriggerRegisterSyncData(trig, "DZMIA", true)
	endfunction
  function DzGetTriggerMallItemPlayer takes nothing returns player
		return DzGetTriggerSyncPlayer()
	endfunction
  function DzGetTriggerMallItem takes nothing returns string
		return DzGetTriggerSyncData()
	endfunction

//library BzAPI ends
//library DzAPI:

































 function DzAPI_Map_IsPlatformVIP takes player whichPlayer returns boolean
		return DzAPI_Map_GetPlatformVIP(whichPlayer) > 0
	endfunction
 function DzAPI_Map_Global_GetStoreString takes string key returns string
		return RequestExtraStringData(36, GetLocalPlayer(), key, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_Global_StoreString takes string key,string value returns nothing
		call RequestExtraStringData(37, GetLocalPlayer(), key, value, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_Global_ChangeMsg takes trigger trig returns nothing
		call DzTriggerRegisterSyncData(trig, "DZGAU", true)
	endfunction
 function DzAPI_Map_ServerArchive takes player whichPlayer,string key returns string
	    return RequestExtraStringData(38, whichPlayer, key, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_SaveServerArchive takes player whichPlayer,string key,string value returns nothing
	    call RequestExtraBooleanData(39, whichPlayer, key, value, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_IsRPGQuickMatch takes nothing returns boolean
		return RequestExtraBooleanData(40, null, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_GetMallItemCount takes player whichPlayer,string key returns integer
		return RequestExtraIntegerData(41, whichPlayer, key, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_ConsumeMallItem takes player whichPlayer,string key,integer count returns boolean
		return RequestExtraBooleanData(42, whichPlayer, key, null, false, count, 0, 0)
	endfunction
 function DzAPI_Map_EnablePlatformSettings takes player whichPlayer,integer option,boolean enable returns boolean
		return RequestExtraBooleanData(43, whichPlayer, null, null, enable, option, 0, 0)
	endfunction
 function DzAPI_Map_IsBuyReforged takes player whichPlayer returns boolean
		return RequestExtraBooleanData(44, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function GetPlayerServerValueSuccess takes player whichPlayer returns boolean
		if ( DzAPI_Map_GetServerValueErrorCode(whichPlayer) == 0 ) then
			return true
		else
			return false
		endif
	endfunction
 function DzAPI_Map_StoreIntegerEX takes player whichPlayer,string key,integer value returns nothing
		set key="I" + key
		call RequestExtraBooleanData(39, whichPlayer, key, I2S(value), false, 0, 0, 0)
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GetStoredIntegerEX takes player whichPlayer,string key returns integer
  local integer value
		set key="I" + key
		set value=S2I(RequestExtraStringData(38, whichPlayer, key, null, false, 0, 0, 0))
		set key=null
		set whichPlayer=null
		return value
	endfunction
 function DzAPI_Map_StoreInteger takes player whichPlayer,string key,integer value returns nothing
		set key="I" + key
		call DzAPI_Map_SaveServerValue(whichPlayer, key, I2S(value))
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GetStoredInteger takes player whichPlayer,string key returns integer
  local integer value
		set key="I" + key
		set value=S2I(DzAPI_Map_GetServerValue(whichPlayer, key))
		set key=null
		set whichPlayer=null
		return value
	endfunction
        function DzAPI_Map_CommentTotalCount1 takes player whichPlayer,integer id returns integer
    		return RequestExtraIntegerData(52, whichPlayer, null, null, false, id, 0, 0)
	endfunction
 function DzAPI_Map_StoreReal takes player whichPlayer,string key,real value returns nothing
		set key="R" + key
		call DzAPI_Map_SaveServerValue(whichPlayer, key, R2S(value))
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GetStoredReal takes player whichPlayer,string key returns real
  local real value
		set key="R" + key
		set value=S2R(DzAPI_Map_GetServerValue(whichPlayer, key))
		set key=null
		set whichPlayer=null
		return value
	endfunction
 function DzAPI_Map_StoreBoolean takes player whichPlayer,string key,boolean value returns nothing
		set key="B" + key
		if ( value ) then
			call DzAPI_Map_SaveServerValue(whichPlayer, key, "1")
		else
			call DzAPI_Map_SaveServerValue(whichPlayer, key, "0")
		endif
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GetStoredBoolean takes player whichPlayer,string key returns boolean
  local boolean value
		set key="B" + key
		set key=DzAPI_Map_GetServerValue(whichPlayer, key)
		if ( key == "1" ) then
			set value=true
		else
			set value=false
		endif
		set key=null
		set whichPlayer=null
		return value
	endfunction
 function DzAPI_Map_StoreString takes player whichPlayer,string key,string value returns nothing
		set key="S" + key
		call DzAPI_Map_SaveServerValue(whichPlayer, key, value)
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GetStoredString takes player whichPlayer,string key returns string
		return DzAPI_Map_GetServerValue(whichPlayer, "S" + key)
	endfunction
 function DzAPI_Map_StoreStringEX takes player whichPlayer,string key,string value returns nothing
		set key="S" + key
		call RequestExtraBooleanData(39, whichPlayer, key, value, false, 0, 0, 0)
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GetStoredStringEX takes player whichPlayer,string key returns string
		return RequestExtraStringData(38, whichPlayer, "S" + key, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_GetStoredUnitType takes player whichPlayer,string key returns integer
  local integer value
		set key="I" + key
		set value=S2I(DzAPI_Map_GetServerValue(whichPlayer, key))
		set key=null
		set whichPlayer=null
		return value
	endfunction
 function DzAPI_Map_GetStoredAbilityId takes player whichPlayer,string key returns integer
  local integer value
		set key="I" + key
		set value=S2I(DzAPI_Map_GetServerValue(whichPlayer, key))
		set key=null
		set whichPlayer=null
		return value
	endfunction
 function DzAPI_Map_FlushStoredMission takes player whichPlayer,string key returns nothing
		call DzAPI_Map_SaveServerValue(whichPlayer, key, null)
		set key=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_Ladder_SubmitIntegerData takes player whichPlayer,string key,integer value returns nothing
		call DzAPI_Map_Ladder_SetStat(whichPlayer, key, I2S(value))
	endfunction
 function DzAPI_Map_Stat_SubmitUnitIdData takes player whichPlayer,string key,integer value returns nothing
		if ( value == 0 ) then
			//call DzAPI_Map_Ladder_SetStat(whichPlayer,key,"0")
		else
			call DzAPI_Map_Ladder_SetStat(whichPlayer, key, I2S(value))
		endif
	endfunction
 function DzAPI_Map_Stat_SubmitUnitData takes player whichPlayer,string key,unit value returns nothing
		call DzAPI_Map_Stat_SubmitUnitIdData(whichPlayer , key , GetUnitTypeId(value))
	endfunction
 function DzAPI_Map_Ladder_SubmitAblityIdData takes player whichPlayer,string key,integer value returns nothing
		if ( value == 0 ) then
			//call DzAPI_Map_Ladder_SetStat(whichPlayer,key,"0")
		else
			call DzAPI_Map_Ladder_SetStat(whichPlayer, key, I2S(value))
		endif
	endfunction
 function DzAPI_Map_Ladder_SubmitItemIdData takes player whichPlayer,string key,integer value returns nothing
  local string S
		if ( value == 0 ) then
			set S="0"
		else
			set S=I2S(value)
			call DzAPI_Map_Ladder_SetStat(whichPlayer, key, S)
		endif
		//call DzAPI_Map_Ladder_SetStat(whichPlayer,key,S)
		set S=null
		set whichPlayer=null
	endfunction
 function DzAPI_Map_Ladder_SubmitItemData takes player whichPlayer,string key,item value returns nothing
		call DzAPI_Map_Ladder_SubmitItemIdData(whichPlayer , key , GetItemTypeId(value))
	endfunction
 function DzAPI_Map_Ladder_SubmitBooleanData takes player whichPlayer,string key,boolean value returns nothing
		if ( value ) then
			call DzAPI_Map_Ladder_SetStat(whichPlayer, key, "1")
		else
			call DzAPI_Map_Ladder_SetStat(whichPlayer, key, "0")
		endif
	endfunction
 function DzAPI_Map_Ladder_SubmitTitle takes player whichPlayer,string value returns nothing
		call DzAPI_Map_Ladder_SetStat(whichPlayer, value, "1")
	endfunction
 function DzAPI_Map_Ladder_SubmitPlayerRank takes player whichPlayer,integer value returns nothing
		call DzAPI_Map_Ladder_SetPlayerStat(whichPlayer, "RankIndex", I2S(value))
	endfunction
 function DzAPI_Map_Ladder_SubmitPlayerExtraExp takes player whichPlayer,integer value returns nothing
		call DzAPI_Map_Ladder_SetStat(whichPlayer, "ExtraExp", I2S(value))
	endfunction
 function DzAPI_Map_PlayedGames takes player whichPlayer returns integer
	    return RequestExtraIntegerData(45, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_CommentCount takes player whichPlayer returns integer
	    return RequestExtraIntegerData(46, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_FriendCount takes player whichPlayer returns integer
	    return RequestExtraIntegerData(47, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_IsConnoisseur takes player whichPlayer returns boolean
	    return RequestExtraBooleanData(48, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_IsBattleNetAccount takes player whichPlayer returns boolean
	    return RequestExtraBooleanData(49, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_IsAuthor takes player whichPlayer returns boolean
	    return RequestExtraBooleanData(50, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_CommentTotalCount takes nothing returns integer
	    return RequestExtraIntegerData(51, null, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_Statistics takes player whichPlayer,string eventKey,string eventType,integer value returns nothing
	    call RequestExtraBooleanData(34, whichPlayer, eventKey, "", false, value, 0, 0)
	endfunction
 function DzAPI_Map_Returns takes player whichPlayer,integer label returns boolean
	    return RequestExtraBooleanData(53, whichPlayer, null, null, false, label, 0, 0)
	endfunction
 function DzAPI_Map_ContinuousCount takes player whichPlayer,integer id returns integer
	    return RequestExtraIntegerData(54, whichPlayer, null, null, false, id, 0, 0)
	endfunction
	// IsPlayer,                      //是否为玩家
 function DzAPI_Map_IsPlayer takes player whichPlayer returns boolean
	    return RequestExtraBooleanData(55, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
	// MapsTotalPlayed,               //所有地图的总游戏时长
 function DzAPI_Map_MapsTotalPlayed takes player whichPlayer returns integer
	    return RequestExtraIntegerData(56, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
	// MapsLevel,                    //指定地图的地图等级
 function DzAPI_Map_MapsLevel takes player whichPlayer,integer mapId returns integer
	    return RequestExtraIntegerData(57, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// MapsConsumeGold,              //所有地图的金币消耗
 function DzAPI_Map_MapsConsumeGold takes player whichPlayer,integer mapId returns integer
	    return RequestExtraIntegerData(58, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// MapsConsumeLumber,            //所有地图的木材消耗
 function DzAPI_Map_MapsConsumeLumber takes player whichPlayer,integer mapId returns integer
	    return RequestExtraIntegerData(59, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// MapsConsumeLv1,               //消费 1-199
 function DzAPI_Map_MapsConsumeLv1 takes player whichPlayer,integer mapId returns boolean
	    return RequestExtraBooleanData(60, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// MapsConsumeLv2,               //消费 200-499
 function DzAPI_Map_MapsConsumeLv2 takes player whichPlayer,integer mapId returns boolean
	    return RequestExtraBooleanData(61, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// MapsConsumeLv3,               //消费 500~999
 function DzAPI_Map_MapsConsumeLv3 takes player whichPlayer,integer mapId returns boolean
	    return RequestExtraBooleanData(62, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// MapsConsumeLv4,               //消费 1000+
 function DzAPI_Map_MapsConsumeLv4 takes player whichPlayer,integer mapId returns boolean
	    return RequestExtraBooleanData(63, whichPlayer, null, null, false, mapId, 0, 0)
	endfunction
	// IsPlayerUsingSkin,            //检查是否装备着皮肤（skinType：头像=1、边框=2、称号=3、底纹=4）
 function DzAPI_Map_IsPlayerUsingSkin takes player whichPlayer,integer skinType,integer id returns boolean
	    return RequestExtraBooleanData(64, whichPlayer, null, null, false, skinType, id, 0)
	endfunction
	//获取论坛数据（0=累计获得赞数，1=精华帖数量，2=发表回复次数，3=收到的欢乐数，4=是否发过贴子，5=是否版主，6=主题数量）
 function DzAPI_Map_GetForumData takes player whichPlayer,integer whichData returns integer
	    return RequestExtraIntegerData(65, whichPlayer, null, null, false, whichData, 0, 0)
	endfunction
	// PlayerFlags,                   //玩家标记 label（1=曾经是平台回流用户，2=当前是平台回流用户，4=曾经是地图回流用户，8=当前是地图回流用户，16=地图是否被玩家收藏）
 function DzAPI_Map_PlayerFlags takes player whichPlayer,integer label returns boolean
	    return RequestExtraBooleanData(53, whichPlayer, null, null, false, label, 0, 0)
	endfunction
	// GetLotteryUsedCount, // 获取宝箱抽取次数
 function DzAPI_Map_GetLotteryUsedCount takes player whichPlayer returns integer
	    return RequestExtraIntegerData(68, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_OpenMall takes player whichPlayer,string whichkey returns boolean
		return RequestExtraBooleanData(66, whichPlayer, whichkey, null, false, 0, 0, 0)
	endfunction
 function DzAPI_Map_GameResult_CommitData takes player whichPlayer,string key,string value returns nothing
		call RequestExtraIntegerData(69, whichPlayer, key, value, false, 0, 0, 0)
	endfunction
	//游戏结算
 function DzAPI_Map_GameResult_CommitTitle takes player whichPlayer,string value returns nothing
		call DzAPI_Map_GameResult_CommitData(whichPlayer , value , "1")
		set whichPlayer=null
		set value=null
	endfunction
 function DzAPI_Map_GameResult_CommitPlayerRank takes player whichPlayer,integer value returns nothing
		call DzAPI_Map_GameResult_CommitData(whichPlayer , "RankIndex" , I2S(value))
		set whichPlayer=null
		set value=0
	endfunction
 function DzAPI_Map_GameResult_CommitGameMode takes string value returns nothing
		call DzAPI_Map_GameResult_CommitData(GetLocalPlayer() , "InnerGameMode" , value)
		set value=null
	endfunction
 function DzAPI_Map_GameResult_CommitGameResult takes player whichPlayer,integer value returns nothing
		call DzAPI_Map_GameResult_CommitData(whichPlayer , "GameResult" , I2S(value))
		set whichPlayer=null
	endfunction
 function DzAPI_Map_GameResult_CommitGameResultNoEnd takes player whichPlayer,integer value returns nothing
		call DzAPI_Map_GameResult_CommitData(whichPlayer , "GameResultNoEnd" , I2S(value))
		set whichPlayer=null
	endfunction
	// GetSinceLastPlayedSeconds, // 获取距最后一次游戏的秒数
 function DzAPI_Map_GetSinceLastPlayedSeconds takes player whichPlayer returns integer
	    return RequestExtraIntegerData(70, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
	// QuickBuy, //游戏内快速购买
 function DzAPI_Map_QuickBuy takes player whichPlayer,string key,integer count,integer seconds returns boolean
	    return RequestExtraBooleanData(72, whichPlayer, key, null, false, count, seconds, 0)
	endfunction
	// CancelQuickBuy, //取消快速购买
 function DzAPI_Map_CancelQuickBuy takes player whichPlayer returns boolean
	    return RequestExtraBooleanData(73, whichPlayer, null, null, false, 0, 0, 0)
	endfunction
	//判断是加载成功某个玩家的道具
 function DzAPI_Map_PlayerLoadedItems takes player whichPlayer returns boolean
		return RequestExtraBooleanData(77, whichPlayer, null, null, false, 0, 0, 0)
	endfunction

//library DzAPI ends
//library XmAPI:
	//特效
	//添加异步特效 path:模型路径 x,y:坐标 返回值:特效

	//设置特效坐标(ydwe的设置坐标有bug) e:特效 x,y:坐标

	//设置特效模型 e:特效 path:模型路径

	//设置特效动画(序号模式) e:特效 index:序号 autocast:应该是自动播放(暂时不清楚用途)

	//设置特效动画 e:特效 aniname:动画名字

	//设置特效颜色 e:特效 r:红色(0-255) g:() b a:透明度

	//查找矩形内特效 r:矩形 filter:过滤函数 code执行函数

	//查找圆形内特效 x,y:坐标 radius:半径 filter:过滤函数 code执行函数

	//获得枚举特效 (XMEnumEffectInRect,XMEnumEffectInRect中使用)

	//获得过滤特效 (XMEnumEffectInRect,XMEnumEffectInRect中使用)

	
	//UI功能:
	//设置Frame属性

	//获取Frame属性-字符串

	//设置Frame属性-整形

	//获取Frame属性-整形

	//设置Frame属性-实数

	//获取Frame属性-实数

	//清空Frame属性

	//查找Frame

	//查找子Frame

	//获取Frame宽度

	//获取Frame高度

	//获取Frame锚点类型 0无效 1绝对 2相对

	//获取Frame锚点的相对frame

	//获取Frame锚点的相对锚点

	//获取Frame锚点的x

	//获取Frame锚点的y

	//获取Frame缩放

	//获取Frame是否显示

	//获取TEXT文字宽度

	//获取TEXT文字高度

	//设置ui为裁剪模式(ui显示模型,制作滚动ui) frame:ui isview:是否为裁剪模式

	//设置ui摄像机位置 frame:ui x,y,z:坐标

	//设置ui摄像机目标位置 frame:ui x,y,z:坐标

	//设置Frame模型

	//绑定特效到Frame模型

	//复位ui中模型的矩阵 frame:ui x,y:坐标

	//设置ui中模型的xy坐标 frame:ui x,y:坐标

	//设置ui中模型的z坐标 frame:ui z:z坐标

	//设置UI模型颜色 e:特效 r:红色(0-255) g:绿(0-255) b:蓝(0-255) a:透明度(0-255)

	//播放UI模型动画 e:特效 seq:动画序号 autocast:无用

	//播放UI模型动画 e:特效 ani:动画名

	//设置ui中模型的缩放 frame:ui scalex,scaley,scalez:缩放

	//设置ui中模型的大小(暂时没发现用处) frame:ui size:大小

	//设置ui中模型的x旋转 frame:ui rotatex:x旋转弧度

	//设置ui中模型的y旋转 frame:ui rotatey:y旋转弧度

	//设置ui中模型的z旋转 frame:ui rotatez:z旋转弧度

	//获得命令按钮类型  0:未知类型 1:单位类型 2:物品类型 3:技能类型 4:命令类型

	//获得命令按钮ID

	
	//物品
	//设置单个物品属性

	//获取单个物品属性

	//清空单位属性

	
	//单位:
	//原生HP

	//刷新血条回调

	//是显示血条

	//停止显示原生血条

	//血条背景

	//单个坐标转屏幕坐标

	//获得单位高度

	//设置单位模型

	//测试Frame

	//设置单个单位属性

	//获取单个单位属性-字符串

	//设置单个单位属性-整形

	//获取单个单位属性-整形

	//设置单个单位属性-实数

	//获取单个单位属性-实数

	//清空单位属性

	//显示/隐藏单位名字(头顶标签)

	//玩家选择的单位

	
	//单位组
	//玩家选择的单位添加到单位组

	
	//可破坏物
	//可破坏物坐标转屏幕坐标

	
	//定时器
	//返回游戏时间

	//创建异步定时器,这个只返回一个累积的整数

	//当前异步计时器

	//异步计时器

	//删除异步计时器

	
	
	//特殊功能:
	//设置更新回调

	//清除更新回调

	//给窗口发送消息(可模拟按下F10(特殊按键和按键组合)) 参数为Windows PostMessage API,自己百度PostMessage

	//直接退出war3程序

	//开启存档加密(需要游戏开始时调用) 只针对新上线的地图,如果是老地图会破坏之前存档 

	//解锁FPS isunlock:是否解锁

	//获得黑边大小 loc:点(最后结果返回给这个点, x代表上边  y代表下边)

	//世界坐标转屏幕坐标  x,y,z:世界坐标 loc:点(最后结果返回给这个点) 返回值: 超出屏幕返回-1 ,其他返回深度值 

	//获得fps

	//运行触发器[异步]

	//获得触发器名字

	//桌面宽度

	//桌面高度

	//设置war3窗口大小

	//war3是否窗口模式

	//war3窗口是否锁定

	//获得地图名

	//获得句柄信息

	//获得异步随机数

	//设置异步随机种子

	//开启异步检测

	//不检测触发器

	//获得用户id

	
	//WebSocket
	//创建websocket

	//关闭websocket

	//设置websocket回调

	//获取websocketID

	//获取websocket事件 0:错误 1:链接 2:接收数据 3:关闭

	//获取websocket错误 0:超时 1:链接失败 2:未知

	//获取websocket数据

	//发送websocket数据

	//发送Http数据

	//获取Http状态

	//获取Http是否成功

	//获取Http标志

	//获取Http头数据

	//获取Http内容数据

	
	//调试

	
	//lua

	//lua参数

































	//lua返回值

































	
	//T世界坐标转屏幕坐标  x,y,z:世界坐标 loc:点(最后结果返回给这个点) 返回值: 超出屏幕返回-1 ,其他返回深度值 
 function XMWorldToScreenT takes real x,real y,real z,location loc returns real
		return XMWorldToScreen(loc, x, y, z)
	endfunction
	
 function XMFrameSetModelExA takes integer frame,string path,string ani returns nothing
  local real scale= XMFrameGetScale(frame)
  local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm == 0 then
			set frm=DzCreateFrameByTagName("SPRITE", "_MODEL", frame, "", 0)
		endif
		call XMFrameSetAttrInteger(frame, - 123456789, frm)
		call DzFrameSetPoint(frm, 4, frame, 4, 0.00, 0.00)
        call DzFrameSetSize(frm, XMFrameGetWidth(frame) * scale, XMFrameGetHeight(frame) * scale)
		call XMFrameSetViewPort(frm, true)
        call XMFrameSetModel(frm, path, 0, 0)
		call XMFrameSetModelAnimate(frm, ani)
	endfunction
	
	//设置界面的模型
 function XMFrameSetModelEx takes integer frame,string path returns nothing
		call XMFrameSetModelExA(frame , path , "stand")
	endfunction
	
	//获得界面的Sprite
 function XMFrameGetModelSpriteEx takes integer frame returns integer
		return XMFrameGetAttrInteger(frame, - 123456789)
	endfunction
	//播放界面的模型动画(序列)
 function XMFrameSetModelAnimateByIndexEx takes integer frame,integer seq,boolean auto returns nothing
  local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm != 0 then
			call XMFrameSetModelAnimateByIndex(frm, seq, auto)
		endif
	endfunction
	
	//播放界面的模型动画
 function XMFrameSetModelAnimateEx takes integer frame,string name returns nothing
  local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm != 0 then
			call XMFrameSetModelAnimate(frm, name)
		endif
	endfunction
	
	//设置窗口中模型的x旋转 frame:窗口 rotatex:x旋转弧度
 function XMFrameSetModelRotateXEx takes integer frame,real rotatex returns nothing
  local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm != 0 then
			call XMFrameSetModelRotateX(frm, rotatex)
		endif
	endfunction
	
	//设置窗口中模型的y旋转 frame:窗口 rotatey:y旋转弧度
 function XMFrameSetModelRotateYEx takes integer frame,real rotatex returns nothing
  local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm != 0 then
			call XMFrameSetModelRotateY(frm, rotatex)
		endif
	endfunction
	
	//设置窗口中模型的z旋转 frame:窗口 rotatez:z旋转弧度
 function XMFrameSetModelRotateZEx takes integer frame,real rotatex returns nothing
   local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm != 0 then
			call XMFrameSetModelRotateZ(frm, rotatex)
		endif
	endfunction
	
	//复位窗口中模型的矩阵 frame:窗口 x,y:坐标
 function XMFrameSetModelMatResetEx takes integer frame returns nothing
  local integer frm= XMFrameGetAttrInteger(frame, - 123456789)
		if frm != 0 then
			call XMFrameSetModelMatReset(frm)
		endif
	endfunction
	
 function XMDebugInfoTimer takes nothing returns nothing
		call DzFrameSetText(xm_DebugUI, XMLeak(""))
	endfunction
	
	//显示句柄信息面板
 function XMShowDebugInfo takes nothing returns nothing
		if ( xm_DebugUI == 0 ) then
			set xm_DebugUI=DzCreateFrameByTagName("TEXT", "DebugInfo", DzGetGameUI(), "", 0)
			call DzFrameSetSize(xm_DebugUI, 0.40, 0.40)
			call DzFrameSetEnable(xm_DebugUI, false)
			call DzFrameSetPoint(xm_DebugUI, 3, DzGetGameUI(), 3, 0.03, 0)
			call DzFrameSetFont(xm_DebugUI, "Fonts\\dfst-m3u.ttf", 0.02, 5)
			set xm_DebugUITimer=XMCreateTimer()
		endif
		call DzFrameShow(xm_DebugUI, true)
		call XMTimerStart(xm_DebugUITimer, 2.00, true, function XMDebugInfoTimer)
	endfunction
	
	//关闭句柄信息面板
 function XMCloseDebugInfo takes nothing returns nothing
		call XMDestroyTimer(xm_DebugUITimer)
		call DzFrameShow(xm_DebugUI, false)
	endfunction
	
	//获得命令按钮命令id
 function XMGetCommandButtonOrderId takes integer x,integer y returns integer
		return XMGetCommandButtonId(x, y)
	endfunction
	
	//获得命令按钮单位
 function XMGetCommandButtonUnit takes integer x,integer y returns integer
		return XMGetCommandButtonId(x, y)
	endfunction
	
	//获得命令按钮物品
 function XMGetCommandButtonItem takes integer x,integer y returns integer
		return XMGetCommandButtonId(x, y)
	endfunction
	
	//获得命令按钮技能
 function XMGetCommandButtonAbility takes integer x,integer y returns integer
		return XMGetCommandButtonId(x, y)
	endfunction
	
	//获得命令按钮科技
 function XMGetCommandButtonTech takes integer x,integer y returns integer
		return XMGetCommandButtonId(x, y)
	endfunction
	

//library XmAPI ends
//library XmUI:
	//载入场景
 function XMUILoadScene takes string file,string name,integer frame returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//查找Frame
 function XMUIFindChild takes integer frame,string name returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//所有下级界面做动作
 function XMUIEnumChild takes integer frame,trigger t returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//所有下级界面做动作
 function XMUIEnumChildCode takes integer frame,code actionFunc returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//播放动画
 function XMUIPlayAction takes integer frame,string name,boolean rep,trigger t returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//播放动画
 function XMUIPlayActionCode takes integer frame,string name,boolean rep,code actionFunc returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//停止动画
 function XMUIStopAction takes integer frame,string name returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//停止所有动画
 function XMUIStopAllAction takes integer frame returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//触发界面
 function XMUIGetTriggerUI takes nothing returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//设置鼠标事件
 function XMUISetMouseEvent takes integer frame,integer e,trigger t returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//设置鼠标事件
 function XMUISetMouseEventCode takes integer frame,integer e,code actionFunc returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//清空鼠标事件
 function XMUIClearMouseEvent takes integer frame,integer e returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得ui名字
 function XMUIGetName takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//获得ui标记
 function XMUIGetTag takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置大小
 function XMUISetSize takes integer frame,real width,real height returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得宽度
 function XMUIGetWidth takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//获得高度
 function XMUIGetHeight takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//设置透明度
 function XMUISetAlpha takes integer frame,integer alpha returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得透明度
 function XMUIGetAlpha takes integer frame returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//设置缩放
 function XMUISetScale takes integer frame,real scale returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得缩放
 function XMUIGetScale takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//设置启用\禁用
 function XMUISetEnable takes integer frame,boolean b returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得启用\禁用
 function XMUIGetEnable takes integer frame returns boolean
		call GetTriggeringTrigger()
		return false
	endfunction
	
	//设置显示\隐藏
 function XMUISetVisible takes integer frame,boolean b returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得显示\隐藏
 function XMUIGetVisible takes integer frame returns boolean
		call GetTriggeringTrigger()
		return false
	endfunction
	
	//设置位置
 function XMUISetPosition takes integer frame,real x,real y returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//设置相对位置
 function XMUISetRelativePoint takes integer frame,integer anchorType,integer relativeframe,integer relativeAnchorType,real x,real y returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//设置绝对位置
 function XMUISetAbsolutePoint takes integer frame,integer anchorType,real x,real y returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//清空锚点
 function XMUIClearPoint takes integer frame returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得x位置
 function XMUIGetX takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//获得y位置
 function XMUIGetY takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//Backdrop
	//设置图片 Backdrop,LoadingBar
 function XMUISetTexture takes integer frame,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得图片 Backdrop,LoadingBar
 function XMUIGetTexture takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//Button
	//设置普通状态图片 Button,CheckBox
 function XMUISetNormalImage takes integer frame,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得普通状态图片
 function XMUIGetNormalImage takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置按下状态图片 Button,CheckBox
 function XMUISetPressedImage takes integer frame,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得按下状态图片 Button,CheckBox
 function XMUIGetPressedImage takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置禁用状态图片
 function XMUISetDisableImage takes integer frame,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得禁用状态图片
 function XMUIGetDisableImage takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置按钮状态图片
 function XMUISetButtonStateImage takes integer frame,integer state,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得按钮状态图片
 function XMUIGetButtonStateImage takes integer frame,integer state returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置文字 Button,EditBox,Text
 function XMUISetText takes integer frame,string text returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得文字 Button,EditBox,Text
 function XMUIGetText takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//根据内容设置大小 Text
 function XMUIAutoSize takes integer frame,real maxWidth returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//设置字体 Button,EditBox,Text
 function XMUISetFont takes integer frame,string text returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得字体 Button,EditBox,Text
 function XMUIGetFont takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置字体大小 Button,EditBox,Text
 function XMUISetFontSize takes integer frame,real size returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得字体大小 Button,EditBox,Text
 function XMUIGetFontSize takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//CheckBox
	//设置选中图片 CheckBox
 function XMUISetNodeNormalImage takes integer frame,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得选中图片 CheckBox
 function XMUIGetNodeNormalImage takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//设置选中状态
 function XMUISetCheckState takes integer frame,boolean b returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得选中状态
 function XMUIGetCheckState takes integer frame returns boolean
		call GetTriggeringTrigger()
		return false
	endfunction
	//EditBox
	//设置字体样式 EditBox,Text
 function XMUISetFontStyle takes integer frame,integer style returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得字体样式 EditBox,Text
 function XMUIGetFontStyle takes integer frame returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//设置对齐方式 EditBox,Text
 function XMUISetTextAlignment takes integer frame,integer v returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得对齐方式 EditBox,Text
 function XMUIGetTextAlignment takes integer frame returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//LoadingBar 
	//设置值0-1 LoadingBar, Slider
 function XMUISetValue takes integer frame,real v returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得值0-1 LoadingBar, Slider
 function XMUIGetValue takes integer frame returns real
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//Slider
	//设置进度条图片 Slider
 function XMUISetProgressBarImage takes integer frame,string texture returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得进度条图片 Slider
 function XMUIGetProgressBarImage takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//值改变回调 Slider
 function XMUISetValueCallback takes integer frame,trigger t returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//值改变回调 Slider
 function XMUISetValueCallbackCode takes integer frame,code actionFunc returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//清除值改变回调 Slider
 function XMUIClearValueCallback takes integer frame returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//释放ui
 function XMUIDestroy takes integer frame returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//释放所有ui
 function XMUIDestroyAll takes nothing returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//设置XMUI界面模式
 function XMUISetMode takes integer mode returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//每帧回调
 function XMUIUpdateCallback takes string tag,trigger t returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//清除每帧回调
 function XMUIClearUpdateCallback takes string tag returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//创建提示面板
 function XMUICreateTip takes string name,integer parent,string filename,string template returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//设置提示面板边距
 function XMUITipSetPadding takes integer frame,real left,real top,real right,real bottom returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//提示面板添加
 function XMUITipAdd takes integer frame,string name,string template,integer align,boolean br,real left,real top,real right,real bottom returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//发送同步数据
 function XMFWSyncData takes trigger trig returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//立即发送同步数据
 function XMFWSyncDataImm takes trigger trig returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//添加同步数据-字符串
 function XMFWSyncPushString takes string key,string data returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得同步数据-字符串
 function XMFWSyncGetString takes string key returns string
		call GetTriggeringTrigger()
		return ""
	endfunction
	
	//添加同步数据-整数
 function XMFWSyncPushInteger takes string key,integer data returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得同步数据-整数
 function XMFWSyncGetInteger takes string key returns integer
		call GetTriggeringTrigger()
		return 0
	endfunction
	
	//添加同步数据-实数
 function XMFWSyncPushReal takes string key,real data returns nothing
		call GetTriggeringTrigger()
	endfunction
	
	//获得同步数据-实数
 function XMFWSyncGetReal takes string key returns real
		call GetTriggeringTrigger()
		return 0.0
	endfunction
	

//library XmUI ends
//library YDTriggerSaveLoadSystem:
    function YDTriggerSaveLoadSystem___Init takes nothing returns nothing
            set YDHT=InitHashtable()
        set YDLOC=InitHashtable()
    endfunction

//library YDTriggerSaveLoadSystem ends
//library YDWEYDWEJapiScript:


//library YDWEYDWEJapiScript ends
//===========================================================================
//*
//*  Global variables
//*
//===========================================================================
function InitGlobals takes nothing returns nothing
 local integer i= 0
endfunction
function InitRandomGroups takes nothing returns nothing
 local integer curset
endfunction
function InitSounds takes nothing returns nothing
endfunction
function CreateDestructables takes nothing returns nothing
 local destructable d
 local trigger t
 local real life
endfunction
function CreateItems takes nothing returns nothing
 local integer itemID
endfunction
function CreateUnits takes nothing returns nothing
 local unit u
 local integer unitID
 local trigger t
 local real life
	set u=CreateUnit(Player(0), 'Hpal', - 95.6, 113.5, 111.6)
	set u=CreateUnit(Player(0), 'hpea', 188.3, 82.1, 13.2)
	set u=CreateUnit(Player(0), 'hmpr', 161.5, 490.3, 304.7)
endfunction
function CreateRegions takes nothing returns nothing
 local weathereffect we
	set gg_rct_1=Rect(- 416, - 192, 192, 480)
	set we=AddWeatherEffect(gg_rct_1, 'RAhr')
	call EnableWeatherEffect(we, true)
	set gg_rct______________001awefawefawef1234=Rect(256, 192, 640, 896)
	set gg_rct______________002_______123456=Rect(- 1344, 448, - 1024, 896)
	set gg_rct______________002_______123456_______u=Rect(- 768, 64, - 448, 512)
endfunction
function CreateCameras takes nothing returns nothing
endfunction
//===========================================================================
// Trigger: 4 发送同步数据
//===========================================================================
function Trig_4___________________uActions takes nothing returns nothing
	call XMFWSyncPushString("字符串" , "字符串")
	call XMFWSyncPushInteger("整数" , 123456)
	call XMFWSyncPushReal("实数" , 3.14)
	call XMFWSyncData(gg_trg_4_1___________________u)
endfunction
//===========================================================================
function InitTrig_4___________________u takes nothing returns nothing
	set gg_trg_4___________________u=CreateTrigger()
	call DisableTrigger(gg_trg_4___________________u)
	call TriggerRegisterPlayerEventEndCinematic(gg_trg_4___________________u, Player(0))
	call TriggerAddAction(gg_trg_4___________________u, function Trig_4___________________uActions)
endfunction
//===========================================================================
// Trigger: 4_1 接收同步数据
//===========================================================================
function Trig_4_1___________________uActions takes nothing returns nothing
	call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, XMFWSyncGetString("字符串"))
	call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, I2S(XMFWSyncGetInteger("整数")))
	call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, R2S(XMFWSyncGetReal("实数")))
endfunction
//===========================================================================
function InitTrig_4_1___________________u takes nothing returns nothing
	set gg_trg_4_1___________________u=CreateTrigger()
	call DisableTrigger(gg_trg_4_1___________________u)
	call TriggerAddAction(gg_trg_4_1___________________u, function Trig_4_1___________________uActions)
endfunction
//===========================================================================
// Trigger: 1.地图初始化
//===========================================================================
function Trig_1________________uActions takes nothing returns nothing
	call Cheat("exec-lua: \"runtime_init\"")
	call XMUnlockFps(true)
	call DzEnableWideScreen(true)
	call Cheat("exec-lua: \"dev\"")
	call Cheat("exec-lua: \"quick.main\"")
endfunction
//===========================================================================
function InitTrig_1________________u takes nothing returns nothing
	set gg_trg_1________________u=CreateTrigger()
	call TriggerAddAction(gg_trg_1________________u, function Trig_1________________uActions)
endfunction
function Trig_1_______uiFunc005T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, XMUIGetName(XMUIGetTriggerUI()))
endfunction
function Trig_1_______uiFunc008T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, "血条动画完成")
endfunction
function Trig_1_______uiFunc011T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, "血条动画完成")
endfunction
function Trig_1_______uiFunc014T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, "点击了布阵按钮")
    call XMFWSyncPushString("字符串" , "abcdef")
    call XMFWSyncPushInteger("整数" , 123456)
    call XMFWSyncPushReal("实数" , 3.14)
    call XMFWSyncData(gg_trg_4_1___________________u)
endfunction
function Trig_1_______uiFunc017T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, "血条动画完成")
endfunction
function Trig_1_______uiFunc020T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, "点击了英雄按钮")
endfunction
function Trig_1_______uiFunc027T takes nothing returns nothing
    call DisplayTextToPlayer(Player(0), 0, 0, ( "滑动条改变:" + R2S(XMUIGetValue(XMUIGetTriggerUI())) ))
endfunction
function Trig_1_______uiFunc030T takes nothing returns nothing
    if ( ( DzGetWheelDelta() > 0 ) ) then
        call XMUISetValue(XMUIGetTriggerUI() , ( ( XMUIGetValue(XMUIGetTriggerUI()) ) + ( 0.10 ) ))
    else
        call XMUISetValue(XMUIGetTriggerUI() , ( ( XMUIGetValue(XMUIGetTriggerUI()) ) + ( - 0.10 ) ))
    endif
endfunction
function Trig_1_______uiActions takes nothing returns nothing
    local integer ydl_localvar_step= LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76)
 set ydl_localvar_step=ydl_localvar_step + 3
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76, ydl_localvar_step)
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xECE825E7, ydl_localvar_step)
    call XMUIDestroyAll()
    // 加载UI库
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490, XMUILoadScene("MainScene.xmui" , "scene1" , DzGetGameUI()))
    call DisplayTextToPlayer(Player(0), 0, 0, "所有下级界面:")
    call XMUIEnumChildCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , function Trig_1_______uiFunc005T)
    // 播放血条动画
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "FileNode_1"))
    call XMUIPlayActionCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , "start" , true , function Trig_1_______uiFunc008T)
    // 播放布阵按钮动画
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "FileNode_2"))
    call XMUIPlayActionCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , "start" , true , function Trig_1_______uiFunc011T)
    // 给布阵按钮添加事件
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , "Image_1"))
    call XMUISetMouseEventCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , 1 , function Trig_1_______uiFunc014T)
    // 播放英雄按钮动画
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "FileNode_3"))
    call XMUIPlayActionCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , "start" , true , function Trig_1_______uiFunc017T)
    // 给英雄按钮添加事件
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , "Image_1"))
    call XMUISetMouseEventCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , 1 , function Trig_1_______uiFunc020T)
    // 设置按钮图片
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "Button_1"))
    call XMUISetButtonStateImage(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , 0 , ( EXExecuteScript("(require'jass.slk').item[" + I2S('ratf') + "].Art") ))
    call DisplayTextToPlayer(Player(0), 0, 0, XMUIGetButtonStateImage(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , 0))
    // 滑动条事件
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "Slider_3"))
    call XMUISetValueCallbackCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , function Trig_1_______uiFunc027T)
    // 给滑动条添加滚轮事件
    call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3, XMUIFindChild(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "Slider_3"))
    call XMUISetMouseEventCode(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x7145C9D3) , 6 , function Trig_1_______uiFunc030T)
    call FlushChildHashtable(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step)
endfunction
//===========================================================================
function InitTrig_1_______ui takes nothing returns nothing
    set gg_trg_1_______ui=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_1_______ui, 0.00)
    call TriggerAddAction(gg_trg_1_______ui, function Trig_1_______uiActions)
endfunction
//===========================================================================
// Trigger: 1 加载ui2
//===========================================================================
function Trig_1_______ui2Actions takes nothing returns nothing
 local integer ydl_localvar_step= LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76)
 set ydl_localvar_step=ydl_localvar_step + 3
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76, ydl_localvar_step)
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xECE825E7, ydl_localvar_step)
	call XMUISetMode(1)
	call XMUIDestroyAll()
	//加载UI库
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490, XMUICreateTip("aa" , DzGetGameUI() , "Tip.xmui" , "Panel_BG"))
	call XMUISetAbsolutePoint(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , 4 , 0.40 , 0.30)
	call XMUITipSetPadding(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , 0.01 , 0.01 , 0.01 , 0.01)
	call XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "图标" , "Image_Icon" , 3 , false , 0.0 , 0.0 , 0.0 , 0.0)
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193, XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "名字" , "Text_Name" , 3 , true , 0.01 , 0.0 , 0.0 , 0.0))
	call XMUISetText(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193) , "无敌大南瓜")
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193, XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "属性" , "Text_Green" , 3 , true , 0.00 , 0.01 , 0.0 , 0.0))
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193, XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "力量" , "Text_Green_0" , 3 , false , 0.02 , 0.0 , 0.0 , 0.0))
	call XMUISetText(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193) , "力量")
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193, XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "力量数值" , "Text_Green_0" , 5 , true , 0.00 , 0.0 , 0.0 , 0.0))
	call XMUISetText(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193) , "+10")
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193, XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "说明" , "Text_White" , 3 , true , 0.00 , 0.0 , 0.0 , 0.0))
	call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193, XMUITipAdd(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0xC7389490) , "详细说明" , "Text_Info" , 3 , false , 0.02 , 0.0 , 0.0 , 0.0))
	call XMUISetText(LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step, 0x5FB77193) , "这是一长串说明,用[竖行n]可以手动换行,也可以在ui里设置宽度,达到宽度自动换行")
	call FlushChildHashtable(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step)
endfunction
//===========================================================================
function InitTrig_1_______ui2 takes nothing returns nothing
	set gg_trg_1_______ui2=CreateTrigger()
	call DisableTrigger(gg_trg_1_______ui2)
	call TriggerRegisterPlayerEventEndCinematic(gg_trg_1_______ui2, Player(0))
	call TriggerAddAction(gg_trg_1_______ui2, function Trig_1_______ui2Actions)
endfunction
//TESH.scrollpos=0
//TESH.alwaysfold=0

//TESH.scrollpos=0
//TESH.alwaysfold=0

//TESH.scrollpos=27
//TESH.alwaysfold=0

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
	call InitTrig_4___________________u()
	call InitTrig_4_1___________________u()
	call InitTrig_1________________u()
	call InitTrig_1_______ui()
	call InitTrig_1_______ui2()
endfunction
//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
	call ConditionalTriggerExecute(gg_trg_1________________u)
endfunction
function InitCustomPlayerSlots takes nothing returns nothing
	call SetPlayerStartLocation(Player(0), 0)
	call ForcePlayerStartLocation(Player(0), 0)
	call SetPlayerColor(Player(0), ConvertPlayerColor(0))
	call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
	call SetPlayerRaceSelectable(Player(0), false)
	call SetPlayerController(Player(0), MAP_CONTROL_USER)
	call SetPlayerStartLocation(Player(1), 1)
	call ForcePlayerStartLocation(Player(1), 1)
	call SetPlayerColor(Player(1), ConvertPlayerColor(1))
	call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
	call SetPlayerRaceSelectable(Player(1), false)
	call SetPlayerController(Player(1), MAP_CONTROL_USER)
	call SetPlayerStartLocation(Player(11), 2)
	call ForcePlayerStartLocation(Player(11), 2)
	call SetPlayerColor(Player(11), ConvertPlayerColor(11))
	call SetPlayerRacePreference(Player(11), RACE_PREF_UNDEAD)
	call SetPlayerRaceSelectable(Player(11), false)
	call SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
	// Force: TRIGSTR_010
	call SetPlayerTeam(Player(0), 0)
	call SetPlayerTeam(Player(1), 0)
	call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
	call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
	call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
	call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
	// Force: TRIGSTR_011
	call SetPlayerTeam(Player(11), 1)
endfunction
function InitAllyPriorities takes nothing returns nothing
	call SetStartLocPrioCount(0, 1)
	call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
	call SetStartLocPrioCount(1, 1)
	call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction
//===========================================================================
//*
//*  Main Initialization
//*
//===========================================================================
function main takes nothing returns nothing
	call SetCameraBounds(- 3328.000000 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.000000 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.000000 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.000000 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.000000 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.000000 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.000000 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.000000 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
	call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
	call NewSoundEnvironment("Default")
	call SetAmbientDaySound("LordaeronSummerDay")
	call SetAmbientNightSound("LordaeronSummerNight")
	call SetMapMusic("Music", true, 0)
	call InitSounds()
	call InitRandomGroups()
	call CreateRegions()
	call CreateCameras()
	call CreateDestructables()
	call CreateItems()
	call CreateUnits()
	call InitBlizzard()

call ExecuteFunc("YDTriggerSaveLoadSystem___Init")

	call InitGlobals()
	call ExecuteFunc("InitCustomTriggers")
	call RunInitializationTriggers()
endfunction
//===========================================================================
//*
//*  Map Configuration
//*
//===========================================================================
function config takes nothing returns nothing
	call SetMapName("xm框架地图")
	call SetMapDescription("没有说明")
	call SetPlayers(3)
	call SetTeams(3)
	call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
	call DefineStartLocation(0, - 64.000000, 64.000000)
	call DefineStartLocation(1, - 64.000000, 64.000000)
	call DefineStartLocation(2, - 64.000000, 64.000000)
	call InitCustomPlayerSlots()
	call InitCustomTeams()
	call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:


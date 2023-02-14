-- --===========================================================================
-- -- Blizzard.j ( define Jass2 functions that need to be in every map script )
-- --===========================================================================
local CJ = require "jass.common"
local BJ = {}
-- -------------------------------------------------------------------------
-- -- Constants
-- --

-- -- Misc constants
BJ.bj_PI = 3.14159
-- bj_E = 2.71828
-- bj_CELLWIDTH = 128.0
-- bj_CLIFFHEIGHT = 128.0
BJ.bj_UNIT_FACING = 270.0
BJ.bj_RADTODEG = 180.0 / BJ.bj_PI
BJ.bj_DEGTORAD = BJ.bj_PI / 180.0
-- bj_TEXT_DELAY_QUEST = 20.0
-- bj_TEXT_DELAY_QUESTUPDATE = 20.0
-- bj_TEXT_DELAY_QUESTDONE = 20.0
-- bj_TEXT_DELAY_QUESTFAILED = 20.0
-- bj_TEXT_DELAY_QUESTREQUIREMENT = 20.0
-- bj_TEXT_DELAY_MISSIONFAILED = 20.0
-- bj_TEXT_DELAY_ALWAYSHINT = 12.0
-- bj_TEXT_DELAY_HINT = 12.0
-- bj_TEXT_DELAY_SECRET = 10.0
-- bj_TEXT_DELAY_UNITACQUIRED = 15.0
-- bj_TEXT_DELAY_UNITAVAILABLE = 10.0
-- bj_TEXT_DELAY_ITEMACQUIRED = 10.0
-- bj_TEXT_DELAY_WARNING = 12.0
-- bj_QUEUE_DELAY_QUEST = 5.0
-- bj_QUEUE_DELAY_HINT = 5.0
-- bj_QUEUE_DELAY_SECRET = 3.0
-- bj_HANDICAP_EASY = 60.0
BJ.bj_GAME_STARTED_THRESHOLD = 0.01
-- bj_WAIT_FOR_COND_MIN_INTERVAL = 0.1
-- bj_POLLED_WAIT_INTERVAL = 0.1
-- bj_POLLED_WAIT_SKIP_THRESHOLD = 2.0

-- -- Game constants
-- bj_MAX_INVENTORY = 6
BJ.bj_MAX_PLAYERS = 12
BJ.bj_PLAYER_NEUTRAL_VICTIM = 13
-- bj_PLAYER_NEUTRAL_EXTRA = 14
BJ.bj_MAX_PLAYER_SLOTS = 16
BJ.bj_MAX_SKELETONS = 25
BJ.bj_MAX_STOCK_ITEM_SLOTS = 11
BJ.bj_MAX_STOCK_UNIT_SLOTS = 11
BJ.bj_MAX_ITEM_LEVEL = 10

-- -- Ideally these would be looked up from Units/MiscData.txt,
-- -- but there is currently no script functionality exposed to do that
BJ.bj_TOD_DAWN = 6.0
BJ.bj_TOD_DUSK = 18.0

-- -- Melee game settings:
-- --   - Starting Time of Day (TOD)
-- --   - Starting Gold
-- --   - Starting Lumber
-- --   - Starting Hero Tokens (free heroes)
-- --   - Max heroes allowed per player
-- --   - Max heroes allowed per hero type
-- --   - Distance from start loc to search for nearby mines
-- --
-- bj_MELEE_STARTING_TOD = 8.0
-- bj_MELEE_STARTING_GOLD_V0 = 750
-- bj_MELEE_STARTING_GOLD_V1 = 500
-- bj_MELEE_STARTING_LUMBER_V0 = 200
-- bj_MELEE_STARTING_LUMBER_V1 = 150
-- bj_MELEE_STARTING_HERO_TOKENS = 1
-- bj_MELEE_HERO_LIMIT = 3
-- bj_MELEE_HERO_TYPE_LIMIT = 1
-- bj_MELEE_MINE_SEARCH_RADIUS = 2000
-- bj_MELEE_CLEAR_UNITS_RADIUS = 1500
-- bj_MELEE_CRIPPLE_TIMEOUT = 120.0
-- bj_MELEE_CRIPPLE_MSG_DURATION = 20.0
BJ.bj_MELEE_MAX_TWINKED_HEROES_V0 = 3
BJ.bj_MELEE_MAX_TWINKED_HEROES_V1 = 1

-- -- Delay between a creep's death and the time it may drop an item.
-- bj_CREEP_ITEM_DELAY = 0.5

-- -- Timing settings for Marketplace inventories.
BJ.bj_STOCK_RESTOCK_INITIAL_DELAY = 120
BJ.bj_STOCK_RESTOCK_INTERVAL = 30
BJ.bj_STOCK_MAX_ITERATIONS = 20

-- -- Max events registered by a single "dest dies in region" event.
-- bj_MAX_DEST_IN_REGION_EVENTS = 64

-- -- Camera settings
-- bj_CAMERA_MIN_FARZ = 100
-- bj_CAMERA_DEFAULT_DISTANCE = 1650
-- bj_CAMERA_DEFAULT_FARZ = 5000
-- bj_CAMERA_DEFAULT_AOA = 304
-- bj_CAMERA_DEFAULT_FOV = 70
-- bj_CAMERA_DEFAULT_ROLL = 0
-- bj_CAMERA_DEFAULT_ROTATION = 90

-- Rescue
BJ.bj_RESCUE_PING_TIME = 2.0

-- -- Transmission behavior settings
BJ.bj_NOTHING_SOUND_DURATION = 5.0
BJ.bj_TRANSMISSION_PING_TIME = 1.0
BJ.bj_TRANSMISSION_IND_RED = 255
BJ.bj_TRANSMISSION_IND_BLUE = 255
BJ.bj_TRANSMISSION_IND_GREEN = 255
BJ.bj_TRANSMISSION_IND_ALPHA = 255
BJ.bj_TRANSMISSION_PORT_HANGTIME = 1.5

-- -- Cinematic mode settings
BJ.bj_CINEMODE_INTERFACEFADE = 0.5
BJ.bj_CINEMODE_GAMESPEED = CJ.MAP_SPEED_NORMAL

-- -- Cinematic mode volume levels
BJ.bj_CINEMODE_VOLUME_UNITMOVEMENT = 0.4
BJ.bj_CINEMODE_VOLUME_UNITSOUNDS = 0.0
BJ.bj_CINEMODE_VOLUME_COMBAT = 0.4
BJ.bj_CINEMODE_VOLUME_SPELLS = 0.4
BJ.bj_CINEMODE_VOLUME_UI = 0.0
BJ.bj_CINEMODE_VOLUME_MUSIC = 0.55
BJ.bj_CINEMODE_VOLUME_AMBIENTSOUNDS = 1.0
BJ.bj_CINEMODE_VOLUME_FIRE = 0.6

-- -- Speech mode volume levels
-- bj_SPEECH_VOLUME_UNITMOVEMENT = 0.25
-- bj_SPEECH_VOLUME_UNITSOUNDS = 0.0
-- bj_SPEECH_VOLUME_COMBAT = 0.25
-- bj_SPEECH_VOLUME_SPELLS = 0.25
-- bj_SPEECH_VOLUME_UI = 0.0
-- bj_SPEECH_VOLUME_MUSIC = 0.55
-- bj_SPEECH_VOLUME_AMBIENTSOUNDS = 1.0
-- bj_SPEECH_VOLUME_FIRE = 0.6

-- -- Smart pan settings
-- bj_SMARTPAN_TRESHOLD_PAN = 500
-- bj_SMARTPAN_TRESHOLD_SNAP = 3500

-- -- QueuedTriggerExecute settings
BJ.bj_MAX_QUEUED_TRIGGERS = 100
BJ.bj_QUEUED_TRIGGER_TIMEOUT = 180.0

-- -- Campaign indexing constants
-- bj_CAMPAIGN_INDEX_T = 0
-- bj_CAMPAIGN_INDEX_H = 1
-- bj_CAMPAIGN_INDEX_U = 2
-- bj_CAMPAIGN_INDEX_O = 3
-- bj_CAMPAIGN_INDEX_N = 4
-- bj_CAMPAIGN_INDEX_XN = 5
-- bj_CAMPAIGN_INDEX_XH = 6
-- bj_CAMPAIGN_INDEX_XU = 7
-- bj_CAMPAIGN_INDEX_XO = 8

-- -- Campaign offset constants (for mission indexing)
-- bj_CAMPAIGN_OFFSET_T = 0
-- bj_CAMPAIGN_OFFSET_H = 1
-- bj_CAMPAIGN_OFFSET_U = 2
-- bj_CAMPAIGN_OFFSET_O = 3
-- bj_CAMPAIGN_OFFSET_N = 4
-- bj_CAMPAIGN_OFFSET_XN = 0
-- bj_CAMPAIGN_OFFSET_XH = 1
-- bj_CAMPAIGN_OFFSET_XU = 2
-- bj_CAMPAIGN_OFFSET_XO = 3

-- -- Mission indexing constants
-- -- Tutorial
-- bj_MISSION_INDEX_T00 = bj_CAMPAIGN_OFFSET_T * 1000 + 0
-- bj_MISSION_INDEX_T01 = bj_CAMPAIGN_OFFSET_T * 1000 + 1
-- -- Human
-- bj_MISSION_INDEX_H00 = bj_CAMPAIGN_OFFSET_H * 1000 + 0
-- bj_MISSION_INDEX_H01 = bj_CAMPAIGN_OFFSET_H * 1000 + 1
-- bj_MISSION_INDEX_H02 = bj_CAMPAIGN_OFFSET_H * 1000 + 2
-- bj_MISSION_INDEX_H03 = bj_CAMPAIGN_OFFSET_H * 1000 + 3
-- bj_MISSION_INDEX_H04 = bj_CAMPAIGN_OFFSET_H * 1000 + 4
-- bj_MISSION_INDEX_H05 = bj_CAMPAIGN_OFFSET_H * 1000 + 5
-- bj_MISSION_INDEX_H06 = bj_CAMPAIGN_OFFSET_H * 1000 + 6
-- bj_MISSION_INDEX_H07 = bj_CAMPAIGN_OFFSET_H * 1000 + 7
-- bj_MISSION_INDEX_H08 = bj_CAMPAIGN_OFFSET_H * 1000 + 8
-- bj_MISSION_INDEX_H09 = bj_CAMPAIGN_OFFSET_H * 1000 + 9
-- bj_MISSION_INDEX_H10 = bj_CAMPAIGN_OFFSET_H * 1000 + 10
-- bj_MISSION_INDEX_H11 = bj_CAMPAIGN_OFFSET_H * 1000 + 11
-- -- Undead
-- bj_MISSION_INDEX_U00 = bj_CAMPAIGN_OFFSET_U * 1000 + 0
-- bj_MISSION_INDEX_U01 = bj_CAMPAIGN_OFFSET_U * 1000 + 1
-- bj_MISSION_INDEX_U02 = bj_CAMPAIGN_OFFSET_U * 1000 + 2
-- bj_MISSION_INDEX_U03 = bj_CAMPAIGN_OFFSET_U * 1000 + 3
-- bj_MISSION_INDEX_U05 = bj_CAMPAIGN_OFFSET_U * 1000 + 4
-- bj_MISSION_INDEX_U07 = bj_CAMPAIGN_OFFSET_U * 1000 + 5
-- bj_MISSION_INDEX_U08 = bj_CAMPAIGN_OFFSET_U * 1000 + 6
-- bj_MISSION_INDEX_U09 = bj_CAMPAIGN_OFFSET_U * 1000 + 7
-- bj_MISSION_INDEX_U10 = bj_CAMPAIGN_OFFSET_U * 1000 + 8
-- bj_MISSION_INDEX_U11 = bj_CAMPAIGN_OFFSET_U * 1000 + 9
-- -- Orc
-- bj_MISSION_INDEX_O00 = bj_CAMPAIGN_OFFSET_O * 1000 + 0
-- bj_MISSION_INDEX_O01 = bj_CAMPAIGN_OFFSET_O * 1000 + 1
-- bj_MISSION_INDEX_O02 = bj_CAMPAIGN_OFFSET_O * 1000 + 2
-- bj_MISSION_INDEX_O03 = bj_CAMPAIGN_OFFSET_O * 1000 + 3
-- bj_MISSION_INDEX_O04 = bj_CAMPAIGN_OFFSET_O * 1000 + 4
-- bj_MISSION_INDEX_O05 = bj_CAMPAIGN_OFFSET_O * 1000 + 5
-- bj_MISSION_INDEX_O06 = bj_CAMPAIGN_OFFSET_O * 1000 + 6
-- bj_MISSION_INDEX_O07 = bj_CAMPAIGN_OFFSET_O * 1000 + 7
-- bj_MISSION_INDEX_O08 = bj_CAMPAIGN_OFFSET_O * 1000 + 8
-- bj_MISSION_INDEX_O09 = bj_CAMPAIGN_OFFSET_O * 1000 + 9
-- bj_MISSION_INDEX_O10 = bj_CAMPAIGN_OFFSET_O * 1000 + 10
-- -- Night Elf
-- bj_MISSION_INDEX_N00 = bj_CAMPAIGN_OFFSET_N * 1000 + 0
-- bj_MISSION_INDEX_N01 = bj_CAMPAIGN_OFFSET_N * 1000 + 1
-- bj_MISSION_INDEX_N02 = bj_CAMPAIGN_OFFSET_N * 1000 + 2
-- bj_MISSION_INDEX_N03 = bj_CAMPAIGN_OFFSET_N * 1000 + 3
-- bj_MISSION_INDEX_N04 = bj_CAMPAIGN_OFFSET_N * 1000 + 4
-- bj_MISSION_INDEX_N05 = bj_CAMPAIGN_OFFSET_N * 1000 + 5
-- bj_MISSION_INDEX_N06 = bj_CAMPAIGN_OFFSET_N * 1000 + 6
-- bj_MISSION_INDEX_N07 = bj_CAMPAIGN_OFFSET_N * 1000 + 7
-- bj_MISSION_INDEX_N08 = bj_CAMPAIGN_OFFSET_N * 1000 + 8
-- bj_MISSION_INDEX_N09 = bj_CAMPAIGN_OFFSET_N * 1000 + 9
-- -- Expansion Night Elf
-- bj_MISSION_INDEX_XN00 = bj_CAMPAIGN_OFFSET_XN * 1000 + 0
-- bj_MISSION_INDEX_XN01 = bj_CAMPAIGN_OFFSET_XN * 1000 + 1
-- bj_MISSION_INDEX_XN02 = bj_CAMPAIGN_OFFSET_XN * 1000 + 2
-- bj_MISSION_INDEX_XN03 = bj_CAMPAIGN_OFFSET_XN * 1000 + 3
-- bj_MISSION_INDEX_XN04 = bj_CAMPAIGN_OFFSET_XN * 1000 + 4
-- bj_MISSION_INDEX_XN05 = bj_CAMPAIGN_OFFSET_XN * 1000 + 5
-- bj_MISSION_INDEX_XN06 = bj_CAMPAIGN_OFFSET_XN * 1000 + 6
-- bj_MISSION_INDEX_XN07 = bj_CAMPAIGN_OFFSET_XN * 1000 + 7
-- bj_MISSION_INDEX_XN08 = bj_CAMPAIGN_OFFSET_XN * 1000 + 8
-- bj_MISSION_INDEX_XN09 = bj_CAMPAIGN_OFFSET_XN * 1000 + 9
-- bj_MISSION_INDEX_XN10 = bj_CAMPAIGN_OFFSET_XN * 1000 + 10
-- -- Expansion Human
-- bj_MISSION_INDEX_XH00 = bj_CAMPAIGN_OFFSET_XH * 1000 + 0
-- bj_MISSION_INDEX_XH01 = bj_CAMPAIGN_OFFSET_XH * 1000 + 1
-- bj_MISSION_INDEX_XH02 = bj_CAMPAIGN_OFFSET_XH * 1000 + 2
-- bj_MISSION_INDEX_XH03 = bj_CAMPAIGN_OFFSET_XH * 1000 + 3
-- bj_MISSION_INDEX_XH04 = bj_CAMPAIGN_OFFSET_XH * 1000 + 4
-- bj_MISSION_INDEX_XH05 = bj_CAMPAIGN_OFFSET_XH * 1000 + 5
-- bj_MISSION_INDEX_XH06 = bj_CAMPAIGN_OFFSET_XH * 1000 + 6
-- bj_MISSION_INDEX_XH07 = bj_CAMPAIGN_OFFSET_XH * 1000 + 7
-- bj_MISSION_INDEX_XH08 = bj_CAMPAIGN_OFFSET_XH * 1000 + 8
-- bj_MISSION_INDEX_XH09 = bj_CAMPAIGN_OFFSET_XH * 1000 + 9
-- -- Expansion Undead
-- bj_MISSION_INDEX_XU00 = bj_CAMPAIGN_OFFSET_XU * 1000 + 0
-- bj_MISSION_INDEX_XU01 = bj_CAMPAIGN_OFFSET_XU * 1000 + 1
-- bj_MISSION_INDEX_XU02 = bj_CAMPAIGN_OFFSET_XU * 1000 + 2
-- bj_MISSION_INDEX_XU03 = bj_CAMPAIGN_OFFSET_XU * 1000 + 3
-- bj_MISSION_INDEX_XU04 = bj_CAMPAIGN_OFFSET_XU * 1000 + 4
-- bj_MISSION_INDEX_XU05 = bj_CAMPAIGN_OFFSET_XU * 1000 + 5
-- bj_MISSION_INDEX_XU06 = bj_CAMPAIGN_OFFSET_XU * 1000 + 6
-- bj_MISSION_INDEX_XU07 = bj_CAMPAIGN_OFFSET_XU * 1000 + 7
-- bj_MISSION_INDEX_XU08 = bj_CAMPAIGN_OFFSET_XU * 1000 + 8
-- bj_MISSION_INDEX_XU09 = bj_CAMPAIGN_OFFSET_XU * 1000 + 9
-- bj_MISSION_INDEX_XU10 = bj_CAMPAIGN_OFFSET_XU * 1000 + 10
-- bj_MISSION_INDEX_XU11 = bj_CAMPAIGN_OFFSET_XU * 1000 + 11
-- bj_MISSION_INDEX_XU12 = bj_CAMPAIGN_OFFSET_XU * 1000 + 12
-- bj_MISSION_INDEX_XU13 = bj_CAMPAIGN_OFFSET_XU * 1000 + 13

-- -- Expansion Orc
-- bj_MISSION_INDEX_XO00 = bj_CAMPAIGN_OFFSET_XO * 1000 + 0

-- -- Cinematic indexing constants
-- bj_CINEMATICINDEX_TOP = 0
-- bj_CINEMATICINDEX_HOP = 1
-- bj_CINEMATICINDEX_HED = 2
-- bj_CINEMATICINDEX_OOP = 3
-- bj_CINEMATICINDEX_OED = 4
-- bj_CINEMATICINDEX_UOP = 5
-- bj_CINEMATICINDEX_UED = 6
-- bj_CINEMATICINDEX_NOP = 7
-- bj_CINEMATICINDEX_NED = 8
-- bj_CINEMATICINDEX_XOP = 9
-- bj_CINEMATICINDEX_XED = 10

-- -- Alliance settings
-- bj_ALLIANCE_UNALLIED = 0
-- bj_ALLIANCE_UNALLIED_VISION = 1
-- bj_ALLIANCE_ALLIED = 2
-- bj_ALLIANCE_ALLIED_VISION = 3
-- bj_ALLIANCE_ALLIED_UNITS = 4
-- bj_ALLIANCE_ALLIED_ADVUNITS = 5
-- bj_ALLIANCE_NEUTRAL = 6
-- bj_ALLIANCE_NEUTRAL_VISION = 7

-- -- Keyboard Event Types
-- bj_KEYEVENTTYPE_DEPRESS = 0
-- bj_KEYEVENTTYPE_RELEASE = 1

-- -- Keyboard Event Keys
-- bj_KEYEVENTKEY_LEFT = 0
-- bj_KEYEVENTKEY_RIGHT = 1
-- bj_KEYEVENTKEY_DOWN = 2
-- bj_KEYEVENTKEY_UP = 3

-- -- Transmission timing methods
BJ.bj_TIMETYPE_ADD = 0
BJ.bj_TIMETYPE_SET = 1
BJ.bj_TIMETYPE_SUB = 2

-- -- Camera bounds adjustment methods
-- bj_CAMERABOUNDS_ADJUST_ADD = 0
-- bj_CAMERABOUNDS_ADJUST_SUB = 1

-- -- Quest creation states
-- bj_QUESTTYPE_REQ_DISCOVERED = 0
-- bj_QUESTTYPE_REQ_UNDISCOVERED = 1
-- bj_QUESTTYPE_OPT_DISCOVERED = 2
-- bj_QUESTTYPE_OPT_UNDISCOVERED = 3

-- -- Quest message types
-- bj_QUESTMESSAGE_DISCOVERED = 0
-- bj_QUESTMESSAGE_UPDATED = 1
-- bj_QUESTMESSAGE_COMPLETED = 2
-- bj_QUESTMESSAGE_FAILED = 3
-- bj_QUESTMESSAGE_REQUIREMENT = 4
-- bj_QUESTMESSAGE_MISSIONFAILED = 5
-- bj_QUESTMESSAGE_ALWAYSHINT = 6
-- bj_QUESTMESSAGE_HINT = 7
-- bj_QUESTMESSAGE_SECRET = 8
-- bj_QUESTMESSAGE_UNITACQUIRED = 9
-- bj_QUESTMESSAGE_UNITAVAILABLE = 10
-- bj_QUESTMESSAGE_ITEMACQUIRED = 11
-- bj_QUESTMESSAGE_WARNING = 12

-- -- Leaderboard sorting methods
-- bj_SORTTYPE_SORTBYVALUE = 0
-- bj_SORTTYPE_SORTBYPLAYER = 1
-- bj_SORTTYPE_SORTBYLABEL = 2

-- -- Cinematic fade filter methods
-- bj_CINEFADETYPE_FADEIN = 0
-- bj_CINEFADETYPE_FADEOUT = 1
-- bj_CINEFADETYPE_FADEOUTIN = 2

-- -- Buff removal methods
-- bj_REMOVEBUFFS_POSITIVE = 0
-- bj_REMOVEBUFFS_NEGATIVE = 1
-- bj_REMOVEBUFFS_ALL = 2
-- bj_REMOVEBUFFS_NONTLIFE = 3

-- -- Buff properties - polarity
-- bj_BUFF_POLARITY_POSITIVE = 0
-- bj_BUFF_POLARITY_NEGATIVE = 1
-- bj_BUFF_POLARITY_EITHER = 2

-- -- Buff properties - resist type
-- bj_BUFF_RESIST_MAGIC = 0
-- bj_BUFF_RESIST_PHYSICAL = 1
-- bj_BUFF_RESIST_EITHER = 2
-- bj_BUFF_RESIST_BOTH = 3

-- -- Hero stats
-- bj_HEROSTAT_STR = 0
-- bj_HEROSTAT_AGI = 1
-- bj_HEROSTAT_INT = 2

-- -- Hero skill point modification methods
-- bj_MODIFYMETHOD_ADD = 0
-- bj_MODIFYMETHOD_SUB = 1
-- bj_MODIFYMETHOD_SET = 2

-- -- Unit state adjustment methods (for replaced units)
-- bj_UNIT_STATE_METHOD_ABSOLUTE = 0
-- bj_UNIT_STATE_METHOD_RELATIVE = 1
-- bj_UNIT_STATE_METHOD_DEFAULTS = 2
-- bj_UNIT_STATE_METHOD_MAXIMUM = 3

-- -- Gate operations
-- bj_GATEOPERATION_CLOSE = 0
-- bj_GATEOPERATION_OPEN = 1
-- bj_GATEOPERATION_DESTROY = 2

-- -- Game cache value types
-- bj_GAMECACHE_BOOLEAN = 0
-- bj_GAMECACHE_INTEGER = 1
-- bj_GAMECACHE_REAL = 2
-- bj_GAMECACHE_UNIT = 3
-- bj_GAMECACHE_STRING = 4

-- -- Hashtable value types
-- bj_HASHTABLE_BOOLEAN = 0
-- bj_HASHTABLE_INTEGER = 1
-- bj_HASHTABLE_REAL = 2
-- bj_HASHTABLE_STRING = 3
-- bj_HASHTABLE_HANDLE = 4

-- -- Item status types
-- bj_ITEM_STATUS_HIDDEN = 0
-- bj_ITEM_STATUS_OWNED = 1
-- bj_ITEM_STATUS_INVULNERABLE = 2
-- bj_ITEM_STATUS_POWERUP = 3
-- bj_ITEM_STATUS_SELLABLE = 4
-- bj_ITEM_STATUS_PAWNABLE = 5

-- -- Itemcode status types
-- bj_ITEMCODE_STATUS_POWERUP = 0
-- bj_ITEMCODE_STATUS_SELLABLE = 1
-- bj_ITEMCODE_STATUS_PAWNABLE = 2

-- -- Minimap ping styles
-- bj_MINIMAPPINGSTYLE_SIMPLE = 0
-- bj_MINIMAPPINGSTYLE_FLASHY = 1
-- bj_MINIMAPPINGSTYLE_ATTACK = 2

-- -- Corpse creation settings
BJ.bj_CORPSE_MAX_DEATH_TIME = 8.0

-- -- Corpse creation styles
BJ.CORPSETYPE_FLESH = 0
BJ.CORPSETYPE_BONE = 1

-- -- Elevator pathing-blocker destructable code
-- bj_ELEVATOR_BLOCKER_CODE = 1146381680
-- bj_ELEVATOR_CODE01 = 1146384998
-- bj_ELEVATOR_CODE02 = 1146385016

-- -- Elevator wall codes
-- bj_ELEVATOR_WALL_TYPE_ALL = 0
-- bj_ELEVATOR_WALL_TYPE_EAST = 1
-- bj_ELEVATOR_WALL_TYPE_NORTH = 2
-- bj_ELEVATOR_WALL_TYPE_SOUTH = 3
-- bj_ELEVATOR_WALL_TYPE_WEST = 4

-- -------------------------------------------------------------------------
-- -- Variables
-- --

-- -- Force predefs
BJ.bj_FORCE_ALL_PLAYERS = nil
BJ.bj_FORCE_PLAYER = {} ---_array_

BJ.bj_MELEE_MAX_TWINKED_HEROES = 0

-- -- Map area rects
BJ.bj_mapInitialPlayableArea = nil
BJ.bj_mapInitialCameraBounds = nil

-- -- Utility function BJ.vars
-- bj_forLoopAIndex = 0
-- bj_forLoopBIndex = 0
-- bj_forLoopAIndexEnd = 0
-- bj_forLoopBIndexEnd = 0

-- bj_slotControlReady = false
-- bj_slotControlUsed = _array_(false)
-- bj_slotControl = _array_()

-- -- Game started detection vars
BJ.bj_gameStartedTimer = nil
BJ.bj_gameStarted = false

-- -- Singleplayer check
BJ.bj_isSinglePlayer = false

-- -- Day/Night Cycle vars
BJ.bj_dncSoundsDay = nil
BJ.bj_dncSoundsNight = nil
BJ.bj_dayAmbientSound = nil
BJ.bj_nightAmbientSound = nil
BJ.bj_dncSoundsDawn = nil
BJ.bj_dncSoundsDusk = nil
BJ.bj_dawnSound = nil
BJ.bj_duskSound = nil
BJ.bj_useDawnDuskSounds = true
BJ.bj_dncIsDaytime = false

-- -- Triggered sounds
-- --sound              bj_pingMinimapSound         = null
BJ.bj_rescueSound = nil
BJ.bj_questDiscoveredSound = nil
BJ.bj_questUpdatedSound = nil
BJ.bj_questCompletedSound = nil
BJ.bj_questFailedSound = nil
BJ.bj_questHintSound = nil
BJ.bj_questSecretSound = nil
BJ.bj_questItemAcquiredSound = nil
BJ.bj_questWarningSound = nil
BJ.bj_victoryDialogSound = nil
BJ.bj_defeatDialogSound = nil

-- -- Marketplace vars
BJ.bj_stockItemPurchased = nil
BJ.bj_stockUpdateTimer = nil
BJ.bj_stockAllowedPermanent = {} ---_array_(false)
BJ.bj_stockAllowedCharged = {} ---_array_(false)
BJ.bj_stockAllowedArtifact = {} ---_array_(false)
BJ.bj_stockPickedItemLevel = 0
BJ.bj_stockPickedItemType = nil

-- -- Melee vars
-- bj_meleeVisibilityTrained = nil
-- bj_meleeVisibilityIsDay = true
-- bj_meleeGrantHeroItems = false
-- bj_meleeNearestMineToLoc = nil
-- bj_meleeNearestMine = nil
-- bj_meleeNearestMineDist = 0.0
-- bj_meleeGameOver = false
-- bj_meleeDefeated = _array_(false)
-- bj_meleeVictoried = _array_(false)
-- bj_ghoul = _array_()
-- bj_crippledTimer = _array_()
-- bj_crippledTimerWindows = _array_()
-- bj_playerIsCrippled = _array_(false)
-- bj_playerIsExposed = _array_(false)
-- bj_finishSoonAllExposed = false
-- bj_finishSoonTimerDialog = nil
-- bj_meleeTwinkedHeroes = _array_(0)

-- -- Rescue behavior vars
BJ.bj_rescueUnitBehavior = nil
BJ.bj_rescueChangeColorUnit = true
BJ.bj_rescueChangeColorBldg = true

-- -- Transmission vars
-- bj_cineSceneEndingTimer = nil
BJ.bj_cineSceneLastSound = nil
BJ.bj_cineSceneBeingSkipped = nil

-- -- Cinematic mode vars
BJ.bj_cineModePriorSpeed = CJ.MAP_SPEED_NORMAL
BJ.bj_cineModePriorFogSetting = false
BJ.bj_cineModePriorMaskSetting = false
BJ.bj_cineModeAlreadyIn = false
BJ.bj_cineModePriorDawnDusk = false
BJ.bj_cineModeSavedSeed = 0

-- -- Cinematic fade vars
-- bj_cineFadeFinishTimer = nil
-- bj_cineFadeContinueTimer = nil
-- bj_cineFadeContinueRed = 0
-- bj_cineFadeContinueGreen = 0
-- bj_cineFadeContinueBlue = 0
-- bj_cineFadeContinueTrans = 0
-- bj_cineFadeContinueDuration = 0
-- bj_cineFadeContinueTex = ""

-- -- QueuedTriggerExecute vars
BJ.bj_queuedExecTotal = 0
BJ.bj_queuedExecTriggers = {}
BJ.bj_queuedExecUseConds = {}

BJ.bj_queuedExecTimeout = nil

-- -- Helper vars (for CJ.Filter and Enum funcs)
-- bj_destInRegionDiesCount = 0
-- bj_destInRegionDiesTrig = nil
-- bj_groupCountUnits = 0
-- bj_forceCountPlayers = 0
BJ.bj_groupEnumTypeId = 0
BJ.bj_groupEnumOwningPlayer = nil
-- bj_groupAddGroupDest = nil
-- bj_groupRemoveGroupDest = nil
-- bj_groupRandomConsidered = 0
-- bj_groupRandomCurrentPick = nil
-- bj_groupLastCreatedDest = nil
-- bj_randomSubGroupGroup = nil
-- bj_randomSubGroupWant = 0
-- bj_randomSubGroupTotal = 0
-- bj_randomSubGroupChance = 0
-- bj_destRandomConsidered = 0
-- bj_destRandomCurrentPick = nil
-- bj_elevatorWallBlocker = nil
-- bj_elevatorNeighbor = nil
-- bj_itemRandomConsidered = 0
-- bj_itemRandomCurrentPick = nil
-- bj_forceRandomConsidered = 0
-- bj_forceRandomCurrentPick = nil
-- bj_makeUnitRescuableUnit = nil
-- bj_makeUnitRescuableFlag = true
-- bj_pauseAllUnitsFlag = true
BJ.bj_enumDestructableCenter = nil
BJ.bj_enumDestructableRadius = 0
-- bj_setPlayerTargetColor = nil
-- bj_isUnitGroupDeadResult = true
-- bj_isUnitGroupEmptyResult = true
-- bj_isUnitGroupInRectResult = true
-- bj_isUnitGroupInRectRect = nil
BJ.bj_changeLevelShowScores = false
BJ.bj_changeLevelMapName = nil

BJ.bj_delayedSuspendDecayTrig = nil
BJ.bj_livingPlayerUnitsTypeId = 0
-- bj_lastDyingWidget = nil

-- -- Random distribution vars
-- bj_randDistCount = 0
-- bj_randDistID = _array_(0)
-- bj_randDistChance = _array_(0)

-- -- Last X'd vars
BJ.bj_lastCreatedUnit = nil
-- bj_lastCreatedItem = nil
-- bj_lastRemovedItem = nil
-- bj_lastHauntedGoldMine = nil
-- bj_lastCreatedDestructable = nil

-- bj_lastCreatedFogModifier = nil
BJ.bj_lastCreatedEffect = nil
-- bj_lastCreatedWeatherEffect = nil
-- bj_lastCreatedTerrainDeformation = nil
-- bj_lastCreatedQuest = nil
-- bj_lastCreatedQuestItem = nil
-- bj_lastCreatedDefeatCondition = nil
-- bj_lastStartedTimer = CJ.CreateTimer()
-- bj_lastCreatedTimerDialog = nil
-- bj_lastCreatedLeaderboard = nil
-- bj_lastCreatedMultiboard = nil
BJ.bj_lastPlayedSound = nil
-- bj_lastPlayedMusic = ""
BJ.bj_lastTransmissionDuration = 0
-- bj_lastCreatedGameCache = nil
-- bj_lastCreatedHashtable = nil
-- bj_lastLoadedUnit = nil
-- bj_lastCreatedButton = nil
-- bj_lastReplacedUnit = nil
-- bj_lastCreatedTextTag = nil
-- bj_lastCreatedLightning = nil
-- bj_lastCreatedImage = nil
-- bj_lastCreatedUbersplat = nil

-- CJ.Filter function BJ.vars
BJ.filterIssueHauntOrderAtLocBJ = nil
BJ.filterEnumDestructablesInCircleBJ = nil
BJ.filterGetUnitsInRectOfPlayer = nil
BJ.filterGetUnitsOfTypeIdAll = nil
BJ.filterGetUnitsOfPlayerAndTypeId = nil
BJ.filterMeleeTrainedUnitIsHeroBJ = nil
BJ.filterLivingPlayerUnitsOfTypeId = nil

-- -- Memory cleanup vars
BJ.bj_wantDestroyGroup = false

function BJ.InitVariables()
    BJ.bj_volumeGroupsTimer = CJ.CreateTimer()
    BJ.bj_queuedExecTimeoutTimer = CJ.CreateTimer()
    BJ.bj_suspendDecayFleshGroup = CJ.CreateGroup()
    BJ.bj_suspendDecayBoneGroup = CJ.CreateGroup()
    BJ.bj_delayedSuspendDecayTimer = CJ.CreateTimer()
    BJ.bj_lastCreatedGroup = CJ.CreateGroup()
end

-- ***************************************************************************
-- *
-- *  Debugging Functions
-- *
-- ***************************************************************************

-- ===========================================================================
function BJ.BJDebugMsg(msg)
    for index = 0, BJ.bj_MAX_PLAYERS - 1 do
        CJ.DisplayTimedTextToPlayer(CJ.Player(index), 0, 0, 60, msg)
    end
end

-- --***************************************************************************
-- --*
-- --*  Math Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
function BJ.RMinBJ(a, b)
    if a < b then
        return a
    else
        return b
    end
end

-- ===========================================================================
function BJ.RMaxBJ(a, b)
    if a < b then
        return b
    else
        return a
    end
end

-- --===========================================================================
-- function BJ.RAbsBJ(a)
-- 	if a >= 0 then
-- 		return a
-- 	else
-- 		return  - a
-- 	end
-- end

-- --===========================================================================
-- function BJ.RSignBJ(a)
-- 	if a >= 0.0 then
-- 		return 1.0
-- 	else
-- 		return -1.0
-- 	end
-- end

-- --===========================================================================
-- function BJ.IMinBJ(a, b)
-- 	if a < b then
-- 		return a
-- 	else
-- 		return b
-- 	end
-- end

-- --===========================================================================
-- function BJ.IMaxBJ(a, b)
-- 	if a < b then
-- 		return b
-- 	else
-- 		return a
-- 	end
-- end

-- ===========================================================================
function BJ.IAbsBJ(a)
    if a >= 0 then
        return a
    else
        return -a
    end
end

-- --===========================================================================
-- function BJ.ISignBJ(a)
-- 	if a >= 0 then
-- 		return 1
-- 	else
-- 		return -1
-- 	end
-- end

--===========================================================================
function BJ.SinBJ(degrees)
	return CJ.Sin(degrees * BJ.bj_DEGTORAD)
end

--===========================================================================
function BJ.CosBJ(degrees)
	return CJ.Cos(degrees * BJ.bj_DEGTORAD)
end

-- --===========================================================================
-- function BJ.TanBJ(degrees)
-- 	return Tan(degrees * BJ.bj_DEGTORAD)
-- end

-- --===========================================================================
-- function BJ.AsinBJ(degrees)
-- 	return Asin(degrees) * BJ.bj_RADTODEG
-- end

-- --===========================================================================
-- function BJ.AcosBJ(degrees)
-- 	return Acos(degrees) * BJ.bj_RADTODEG
-- end

-- --===========================================================================
-- function BJ.AtanBJ(degrees)
-- 	return Atan(degrees) * BJ.bj_RADTODEG
-- end

-- --===========================================================================
-- function BJ.Atan2BJ(y, x)
-- 	return CJ.Atan2(y, x) * BJ.bj_RADTODEG
-- end

-- ===========================================================================
function BJ.AngleBetweenPoints(locA, locB)
    return BJ.bj_RADTODEG *
               CJ.Atan2(CJ.GetLocationY(locB) - CJ.GetLocationY(locA),
                        CJ.GetLocationX(locB) - CJ.GetLocationX(locA))
end

-- ===========================================================================
function BJ.DistanceBetweenPoints(locA, locB)
    local dx = CJ.GetLocationX(locB) - CJ.GetLocationX(locA)
    local dy = CJ.GetLocationY(locB) - CJ.GetLocationY(locA)
    return CJ.SquareRoot(dx * dx + dy * dy)
end

-- ===========================================================================
function BJ.PolarProjectionBJ(source, dist, angle)
    local x = CJ.GetLocationX(source) + dist * CJ.Cos(angle * BJ.bj_DEGTORAD)
    local y = CJ.GetLocationY(source) + dist * CJ.Sin(angle * BJ.bj_DEGTORAD)
    return CJ.Location(x, y)
end

-- --===========================================================================
function BJ.GetRandomDirectionDeg()
	return CJ.GetRandomReal(0, 360)
end

-- --===========================================================================
-- function BJ.GetRandomPercentageBJ()
-- 	return CJ.GetRandomReal(0, 100)
-- end

-- ===========================================================================
function BJ.GetRandomLocInRect(whichRect)
    return CJ.Location(CJ.GetRandomReal(CJ.GetRectMinX(whichRect),
                                        CJ.GetRectMaxX(whichRect)),
                       CJ.GetRandomReal(CJ.GetRectMinY(whichRect),
                                        CJ.GetRectMaxY(whichRect)))
end

-- --===========================================================================
-- -- Calculate the modulus/remainder of (dividend) divided by (divisor).
-- -- Examples:  18 mod 5 = 3.  15 mod 5 = 0.  -8 mod 5 = 2.
-- --
-- function BJ.ModuloInteger(dividend, divisor)
-- 	local modulus = dividend - dividend // divisor * divisor

-- 	-- If the dividend was negative, the above modulus calculation will
-- 	-- be negative, but within (-divisor..0).  We can add (divisor) to
-- 	-- shift this result into the desired range of (0..divisor).
-- 	if modulus < 0 then
-- 		modulus = modulus + divisor
-- 	end

-- 	return modulus
-- end

-- --===========================================================================
-- -- Calculate the modulus/remainder of (dividend) divided by (divisor).
-- -- Examples:  13.000 mod 2.500 = 0.500.  -6.000 mod 2.500 = 1.500.
-- --
-- function BJ.ModuloReal(dividend, divisor)
-- 	local modulus = dividend - CJ.I2R(CJ.R2I(dividend / divisor)) * divisor

-- 	-- If the dividend was negative, the above modulus calculation will
-- 	-- be negative, but within (-divisor..0).  We can add (divisor) to
-- 	-- shift this result into the desired range of (0..divisor).
-- 	if modulus < 0 then
-- 		modulus = modulus + divisor
-- 	end

-- 	return modulus
-- end

-- --===========================================================================
-- function BJ.OffsetLocation(loc, dx, dy)
-- 	return CJ.Location(CJ.GetLocationX(loc) + dx, CJ.GetLocationY(loc) + dy)
-- end

-- --===========================================================================
-- function BJ.OffsetRectBJ(r, dx, dy)
-- 	return CJ.Rect(CJ.GetRectMinX(r) + dx, CJ.GetRectMinY(r) + dy, CJ.GetRectMaxX(r) + dx, CJ.GetRectMaxY(r) + dy)
-- end

-- --===========================================================================
-- function BJ.RectFromCenterSizeBJ(center, width, height)
-- 	local x = CJ.GetLocationX(center)
-- 	local y = CJ.GetLocationY(center)
-- 	return CJ.Rect(x - width * 0.5, y - height * 0.5, x + width * 0.5, y + height * 0.5)
-- end

-- --===========================================================================
-- function BJ.RectContainsCoords(r, x, y)
-- 	return CJ.GetRectMinX(r) <= x and x <= CJ.GetRectMaxX(r) and CJ.GetRectMinY(r) <= y and y <= CJ.GetRectMaxY(r)
-- end

-- --===========================================================================
-- function BJ.RectContainsLoc(r, loc)
-- 	return RectContainsCoords(r, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- end

-- --===========================================================================
-- function BJ.RectContainsUnit(r, whichUnit)
-- 	return RectContainsCoords(r, CJ.GetUnitX(whichUnit), CJ.GetUnitY(whichUnit))
-- end

-- --===========================================================================
-- function BJ.RectContainsItem(whichItem, r)
-- 	if whichItem == nil then
-- 		return false
-- 	end

-- 	if IsItemOwned(whichItem) then
-- 		return false
-- 	end

-- 	return RectContainsCoords(r, GetItemX(whichItem), GetItemY(whichItem))
-- end

-- --***************************************************************************
-- --*
-- --*  Utility Constructs
-- --*
-- --***************************************************************************

-- --===========================================================================
-- -- Runs the trigger's actions if the trigger's conditions evaluate to true.
-- --
-- function BJ.ConditionalTriggerExecute(trig)
-- 	if CJ.TriggerEvaluate(trig) then
-- 		CJ.TriggerExecute(trig)
-- 	end
-- end

-- ===========================================================================
-- Runs the trigger's actions if the trigger's conditions evaluate to true.
--
function BJ.TriggerExecuteBJ(trig, checkConditions)
    if checkConditions then
        if not CJ.TriggerEvaluate(trig) then return false end
    end
    CJ.TriggerExecute(trig)
    return true
end

-- --===========================================================================
-- -- Arranges for a trigger to fire almost immediately, except that the calling
-- -- trigger is not interrupted as is the case with a CJ.TriggerExecute call.
-- -- Since the trigger executes normally, its conditions are still evaluated.
-- --
-- function BJ.PostTriggerExecuteBJ(trig, checkConditions)
-- 	if checkConditions then
-- 		if not CJ.TriggerEvaluate(trig) then
-- 			return false
-- 		end
-- 	end
-- 	TriggerRegisterTimerEvent(trig, 0, false)
-- 	return true
-- end

-- --===========================================================================
-- -- Debug - Display the contents of the trigger queue (as either null or "x"
-- -- for each entry).
-- function BJ.QueuedTriggerCheck()
-- 	local s = "TrigQueue Check "
-- 	local i

-- 	i = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		if i >= BJ.bj_queuedExecTotal then break end
-- 		s = (s or "") .. "q[" .. (I2S(i) or "") .. "]="
-- 		if BJ.bj_queuedExecTriggers[i] == nil then
-- 			s = (s or "") .. "null "
-- 		else
-- 			s = (s or "") .. "x "
-- 		end
-- 		i = i + 1
-- 	end
-- 	s = (s or "") .. "(" .. (I2S(BJ.bj_queuedExecTotal) or "") .. " total)"
-- 	DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, 600, s)
-- end

-- ===========================================================================
-- Searches the queue for a given trigger, returning the index of the
-- trigger within the queue if it is found, or -1 if it is not found.
--
function BJ.QueuedTriggerGetIndex(trig)
    -- Determine which, if any, of the queued triggers is being removed.
    local index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if index >= BJ.bj_queuedExecTotal then break end
        if BJ.bj_queuedExecTriggers[index] == trig then return index end
        index = index + 1
    end
    return -1
end

-- ===========================================================================
-- Removes a trigger from the trigger queue, shifting other triggers down
-- to fill the unused space.  If the currently running trigger is removed
-- in this manner, this function BJ.does NOT attempt to run the next trigger.
--
function BJ.QueuedTriggerRemoveByIndex(trigIndex)
    local index

    -- If the to-be-removed index is out of range, fail.
    if trigIndex >= BJ.bj_queuedExecTotal then return false end

    -- Shift all queue entries down to fill in the gap.
    BJ.bj_queuedExecTotal = BJ.bj_queuedExecTotal - 1
    index = trigIndex
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if index >= BJ.bj_queuedExecTotal then break end
        BJ.bj_queuedExecTriggers[index] = BJ.bj_queuedExecTriggers[index + 1]
        BJ.bj_queuedExecUseConds[index] = BJ.bj_queuedExecUseConds[index + 1]
        index = index + 1
    end
    return true
end

-- ===========================================================================
-- Attempt to execute the first trigger in the queue.  If it fails, remove
-- it and execute the next one.  Continue this cycle until a trigger runs,
-- or until the queue is empty.
--
function BJ.QueuedTriggerAttemptExec()
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if BJ.bj_queuedExecTotal == 0 then break end

        if BJ.TriggerExecuteBJ(BJ.bj_queuedExecTriggers[0],
                               BJ.bj_queuedExecUseConds[0]) then
            -- Timeout the queue if it sits at the front of the queue for too long.
            CJ.TimerStart(BJ.bj_queuedExecTimeoutTimer,
                          BJ.bj_QUEUED_TRIGGER_TIMEOUT, false, nil)
            return true
        end

        BJ.QueuedTriggerRemoveByIndex(0)
    end
    return false
end

-- --===========================================================================
-- -- Queues a trigger to be executed, assuring that such triggers are not
-- -- executed at the same time.
-- --
-- function BJ.QueuedTriggerAddBJ(trig, checkConditions)
-- 	-- Make sure our queue isn't full.  If it is, return failure.
-- 	if BJ.bj_queuedExecTotal >= BJ.bj_MAX_QUEUED_TRIGGERS then
-- 		return false
-- 	end

-- 	-- Add the trigger to an array of to-be-executed triggers.
-- 	BJ.bj_queuedExecTriggers[BJ.bj_queuedExecTotal] = trig
-- 	BJ.bj_queuedExecUseConds[BJ.bj_queuedExecTotal] = checkConditions
-- 	BJ.bj_queuedExecTotal = BJ.bj_queuedExecTotal + 1

-- 	-- If this is the only trigger in the queue, run it.
-- 	if BJ.bj_queuedExecTotal == 1 then
-- 		BJ.QueuedTriggerAttemptExec()
-- 	end
-- 	return true
-- end

-- ===========================================================================
-- Denotes the end of a queued trigger. Be sure to call this only once per
-- queued trigger, or risk stepping on the toes of other queued triggers.
--
function BJ.QueuedTriggerRemoveBJ(trig)
    local trigIndex

    -- Find the trigger's index.
    trigIndex = BJ.QueuedTriggerGetIndex(trig)
    if trigIndex == -1 then return end

    -- Shuffle the other trigger entries down to fill in the gap.
    BJ.QueuedTriggerRemoveByIndex(trigIndex)

    -- If we just axed the currently running trigger, run the next one.
    if trigIndex == 0 then
        CJ.PauseTimer(BJ.bj_queuedExecTimeoutTimer)
        BJ.QueuedTriggerAttemptExec()
    end
end

-- ===========================================================================
-- Denotes the end of a queued trigger. Be sure to call this only once per
-- queued trigger, lest you step on the toes of other queued triggers.
--
function BJ.QueuedTriggerDoneBJ()
    local index

    -- Make sure there's something on the queue to remove.
    if BJ.bj_queuedExecTotal <= 0 then return end

    -- Remove the currently running trigger from the array.
    BJ.QueuedTriggerRemoveByIndex(0)

    -- If other triggers are waiting to run, run one of them.
    CJ.PauseTimer(BJ.bj_queuedExecTimeoutTimer)
    BJ.QueuedTriggerAttemptExec()
end

-- --===========================================================================
-- -- Empty the trigger queue.
-- --
-- function BJ.QueuedTriggerClearBJ()
-- 	CJ.PauseTimer(BJ.bj_queuedExecTimeoutTimer)
-- 	BJ.bj_queuedExecTotal = 0
-- end

-- --===========================================================================
-- -- Remove all but the currently executing trigger from the trigger queue.
-- --
-- function BJ.QueuedTriggerClearInactiveBJ()
-- 	BJ.bj_queuedExecTotal = IMinBJ(BJ.bj_queuedExecTotal, 1)
-- end

-- --===========================================================================
-- function BJ.QueuedTriggerCountBJ()
-- 	return BJ.bj_queuedExecTotal
-- end

-- --===========================================================================
-- function BJ.IsTriggerQueueEmptyBJ()
-- 	return BJ.bj_queuedExecTotal <= 0
-- end

-- --===========================================================================
-- function BJ.IsTriggerQueuedBJ(trig)
-- 	return BJ.QueuedTriggerGetIndex(trig) ~= -1
-- end

-- --===========================================================================
-- function BJ.GetForLoopIndexA()
-- 	return bj_forLoopAIndex
-- end

-- --===========================================================================
-- function BJ.SetForLoopIndexA(newIndex)
-- 	bj_forLoopAIndex = newIndex
-- end

-- --===========================================================================
-- function BJ.GetForLoopIndexB()
-- 	return bj_forLoopBIndex
-- end

-- --===========================================================================
-- function BJ.SetForLoopIndexB(newIndex)
-- 	bj_forLoopBIndex = newIndex
-- end

-- --===========================================================================
-- -- We can't do game-time waits, so this simulates one by starting a timer
-- -- and polling until the timer expires.
-- function BJ.PolledWait(duration)
-- 	local t
-- 	local timeRemaining

-- 	if duration > 0 then
-- 		t = CJ.CreateTimer()
-- 		CJ.TimerStart(t, duration, false, nil)
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			timeRemaining = TimerGetRemaining(t)
-- 			if timeRemaining <= 0 then break end

-- 			-- If we have a bit of time left, skip past 10% of the remaining
-- 			-- duration instead of checking every interval, to minimize the
-- 			-- polling on long waits.
-- 			if timeRemaining > bj_POLLED_WAIT_SKIP_THRESHOLD then
-- 				CJ.TriggerSleepAction(0.1 * timeRemaining)
-- 			else
-- 				CJ.TriggerSleepAction(bj_POLLED_WAIT_INTERVAL)
-- 			end
-- 		end
-- 		CJ.DestroyTimer(t)
-- 	end
-- end

-- --===========================================================================
-- function BJ.IntegerTertiaryOp(flag, valueA, valueB)
-- 	if flag then
-- 		return valueA
-- 	else
-- 		return valueB
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  General Utility Functions
-- --*  These functions exist purely to make the trigger dialogs cleaner and
-- --*  more comprehensible.
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.DoNothing()
-- end

-- --===========================================================================
-- -- This function BJ.does nothing.  WorldEdit should should eventually ignore
-- -- CommentString triggers during script generation, but until such a time,
-- -- this function BJ.will serve as a stub.
-- --
-- function BJ.CommentString(commentString)
-- end

-- --===========================================================================
-- -- This function BJ.returns the input string, converting it from the localized text, if necessary
-- --
-- function BJ.StringIdentity(theString)
-- 	return CJ.GetLocalizedString(theString)
-- end

-- --===========================================================================
-- function BJ.GetBooleanAnd(valueA, valueB)
-- 	return valueA and valueB
-- end

-- --===========================================================================
-- function BJ.GetBooleanOr(valueA, valueB)
-- 	return valueA or valueB
-- end

-- ===========================================================================
-- Converts a percentage (real, 0..100) into a scaled integer (0..max),
-- clipping the result to 0..max in case the input is invalid.
--
function BJ.PercentToInt(percentage, max)
    local result = CJ.R2I(percentage * CJ.I2R(max) * 0.01)

    if result < 0 then
        result = 0
    elseif result > max then
        result = max
    end

    return result
end

-- ===========================================================================
function BJ.PercentTo255(percentage) return BJ.PercentToInt(percentage, 255) end

-- --===========================================================================
function BJ.GetTimeOfDay() return
    CJ.GetFloatGameState(CJ.GAME_STATE_TIME_OF_DAY) end

-- ===========================================================================
function BJ.SetTimeOfDay(whatTime)
    CJ.SetFloatGameState(CJ.GAME_STATE_TIME_OF_DAY, whatTime)
end

-- ===========================================================================
function BJ.SetTimeOfDayScalePercentBJ(scalePercent)
    CJ.SetTimeOfDayScale(scalePercent * 0.01)
end

-- ===========================================================================
function BJ.GetTimeOfDayScalePercentBJ() return CJ.GetTimeOfDayScale() * 100 end

-- --===========================================================================
-- function BJ.PlaySound(soundName)
-- 	local soundHandle = CreateSound(soundName, false, false, true, 12700, 12700, "")
-- 	CJ.StartSound(soundHandle)
-- 	KillSoundWhenDone(soundHandle)
-- end

-- --===========================================================================
-- function BJ.CompareLocationsBJ(A, B)
-- 	return CJ.GetLocationX(A) == CJ.GetLocationX(B) and CJ.GetLocationY(A) == CJ.GetLocationY(B)
-- end

-- --===========================================================================
-- function BJ.CompareRectsBJ(A, B)
-- 	return CJ.GetRectMinX(A) == CJ.GetRectMinX(B) and CJ.GetRectMinY(A) == CJ.GetRectMinY(B) and CJ.GetRectMaxX(A) == CJ.GetRectMaxX(B) and CJ.GetRectMaxY(A) == CJ.GetRectMaxY(B)
-- end

-- --===========================================================================
-- -- Returns a square rect that exactly encompasses the specified circle.
-- --
-- function BJ.GetRectFromCircleBJ(center, radius)
-- 	local centerX = CJ.GetLocationX(center)
-- 	local centerY = CJ.GetLocationY(center)
-- 	return CJ.Rect(centerX - radius, centerY - radius, centerX + radius, centerY + radius)
-- end

-- --***************************************************************************
-- --*
-- --*  Camera Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.GetCurrentCameraSetup()
-- 	local theCam = CreateCameraSetup()
-- 	local duration = 0
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_TARGET_DISTANCE, GetCameraField(CAMERA_FIELD_TARGET_DISTANCE), duration)
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_FARZ, GetCameraField(CAMERA_FIELD_FARZ), duration)
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET), duration)
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_ANGLE_OF_ATTACK, BJ.bj_RADTODEG * GetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK), duration)
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_FIELD_OF_VIEW, BJ.bj_RADTODEG * GetCameraField(CAMERA_FIELD_FIELD_OF_VIEW), duration)
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_ROLL, BJ.bj_RADTODEG * GetCameraField(CAMERA_FIELD_ROLL), duration)
-- 	CameraSetupSetField(theCam, CAMERA_FIELD_ROTATION, BJ.bj_RADTODEG * GetCameraField(CAMERA_FIELD_ROTATION), duration)
-- 	CameraSetupSetDestPosition(theCam, GetCameraTargetPositionX(), GetCameraTargetPositionY(), duration)
-- 	return theCam
-- end

-- --===========================================================================
-- function BJ.CameraSetupApplyForPlayer(doPan, whichSetup, whichPlayer, duration)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CameraSetupApplyForceDuration(whichSetup, doPan, duration)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CameraSetupGetFieldSwap(whichField, whichSetup)
-- 	return CameraSetupGetField(whichSetup, whichField)
-- end

-- --===========================================================================
-- function BJ.SetCameraFieldForPlayer(whichPlayer, whichField, value, duration)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraField(whichField, value, duration)
-- 	end
-- end

--===========================================================================
function BJ.SetCameraTargetControllerNoZForPlayer(whichPlayer, whichUnit, xoffset, yoffset, inheritOrientation)
	if CJ.GetLocalPlayer() == whichPlayer then
		-- Use only local code (no net traffic) within this block to avoid desyncs.
		CJ.SetCameraTargetController(whichUnit, xoffset, yoffset, inheritOrientation)
	end
end

-- --===========================================================================
-- function BJ.SetCameraPositionForPlayer(whichPlayer, x, y)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraPosition(x, y)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetCameraPositionLocForPlayer(whichPlayer, loc)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraPosition(CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- 	end
-- end

-- --===========================================================================
-- function BJ.RotateCameraAroundLocBJ(degrees, loc, whichPlayer, duration)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraRotateMode(CJ.GetLocationX(loc), CJ.GetLocationY(loc), BJ.bj_DEGTORAD * degrees, duration)
-- 	end
-- end

-- --===========================================================================
-- function BJ.PanCameraToForPlayer(whichPlayer, x, y)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		PanCameraTo(x, y)
-- 	end
-- end

-- --===========================================================================
-- function BJ.PanCameraToLocForPlayer(whichPlayer, loc)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		PanCameraTo(CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- 	end
-- end

-- ===========================================================================
function BJ.PanCameraToTimedForPlayer(whichPlayer, x, y, duration)
    if CJ.GetLocalPlayer() == whichPlayer then
        -- Use only local code (no net traffic) within this block to avoid desyncs.
        CJ.PanCameraToTimed(x, y, duration)
    end
end

-- ===========================================================================
function BJ.PanCameraToTimedLocForPlayer(whichPlayer, loc, duration)
    if CJ.GetLocalPlayer() == whichPlayer then
        -- Use only local code (no net traffic) within this block to avoid desyncs.
        CJ.PanCameraToTimed(CJ.GetLocationX(loc), CJ.GetLocationY(loc), duration)
    end
end

-- --===========================================================================
-- function BJ.PanCameraToTimedLocWithZForPlayer(whichPlayer, loc, zOffset, duration)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		PanCameraToTimedWithZ(CJ.GetLocationX(loc), CJ.GetLocationY(loc), zOffset, duration)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SmartCameraPanBJ(whichPlayer, loc, duration)
-- 	local dist
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 		dist = BJ.DistanceBetweenPoints(loc, GetCameraTargetPositionLoc())
-- 		if dist >= bj_SMARTPAN_TRESHOLD_SNAP then
-- 			-- If the user is too far away, snap the camera.
-- 			CJ.PanCameraToTimed(CJ.GetLocationX(loc), CJ.GetLocationY(loc), 0)
-- 		elseif dist >= bj_SMARTPAN_TRESHOLD_PAN then
-- 			-- If the user is moderately close, pan the camera.
-- 			CJ.PanCameraToTimed(CJ.GetLocationX(loc), CJ.GetLocationY(loc), duration)
-- 		else
-- 		-- User is close enough, so don't touch the camera.
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetCinematicCameraForPlayer(whichPlayer, cameraModelFile)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCinematicCamera(cameraModelFile)
-- 	end
-- end

-- --===========================================================================
-- function BJ.ResetToGameCameraForPlayer(whichPlayer, duration)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		ResetToGameCamera(duration)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CameraSetSourceNoiseForPlayer(whichPlayer, magnitude, velocity)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CameraSetSourceNoise(magnitude, velocity)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CameraSetTargetNoiseForPlayer(whichPlayer, magnitude, velocity)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CameraSetTargetNoise(magnitude, velocity)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CameraSetEQNoiseForPlayer(whichPlayer, magnitude)
-- 	local richter = magnitude
-- 	if richter > 5.0 then
-- 		richter = 5.0
-- 	end
-- 	if richter < 2.0 then
-- 		richter = 2.0
-- 	end
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CameraSetTargetNoiseEx(magnitude * 2.0, magnitude * Pow(10, richter), true)
-- 		CameraSetSourceNoiseEx(magnitude * 2.0, magnitude * Pow(10, richter), true)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CameraClearNoiseForPlayer(whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CameraSetSourceNoise(0, 0)
-- 		CameraSetTargetNoise(0, 0)
-- 	end
-- end

-- ===========================================================================
-- Query the current camera bounds.
--
function BJ.GetCurrentCameraBoundsMapRectBJ()
    return CJ.Rect(CJ.GetCameraBoundMinX(), CJ.GetCameraBoundMinY(),
                   CJ.GetCameraBoundMaxX(), CJ.GetCameraBoundMaxY())
end

-- --===========================================================================
-- -- Query the initial camera bounds, as defined at map init.
-- --
-- function BJ.GetCameraBoundsMapRect()
-- 	return BJ.bj_mapInitialCameraBounds
-- end

-- --===========================================================================
-- -- Query the playable map area, as defined at map init.
-- --
-- function BJ.GetPlayableMapRect()
-- 	return BJ.bj_mapInitialPlayableArea
-- end

-- --===========================================================================
-- -- Query the entire map area, as defined at map init.
-- --
-- function BJ.GetEntireMapRect()
-- 	return GetWorldBounds()
-- end

-- --===========================================================================
-- function BJ.SetCameraBoundsToRect(r)
-- 	local minX = CJ.GetRectMinX(r)
-- 	local minY = CJ.GetRectMinY(r)
-- 	local maxX = CJ.GetRectMaxX(r)
-- 	local maxY = CJ.GetRectMaxY(r)
-- 	SetCameraBounds(minX, minY, minX, maxY, maxX, maxY, maxX, minY)
-- end

-- --===========================================================================
-- function BJ.SetCameraBoundsToRectForPlayerBJ(whichPlayer, r)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraBoundsToRect(r)
-- 	end
-- end

-- --===========================================================================
-- function BJ.AdjustCameraBoundsBJ(adjustMethod, dxWest, dxEast, dyNorth, dySouth)
-- 	local minX = 0
-- 	local minY = 0
-- 	local maxX = 0
-- 	local maxY = 0
-- 	local scale = 0

-- 	if adjustMethod == bj_CAMERABOUNDS_ADJUST_ADD then
-- 		scale = 1
-- 	elseif adjustMethod == bj_CAMERABOUNDS_ADJUST_SUB then
-- 		scale = -1
-- 	else
-- 		-- Unrecognized adjustment method - ignore the request.
-- 		return
-- 	end

-- 	-- Adjust the actual camera values
-- 	minX = CJ.GetCameraBoundMinX() - scale * dxWest
-- 	maxX = CJ.GetCameraBoundMaxX() + scale * dxEast
-- 	minY = CJ.GetCameraBoundMinY() - scale * dySouth
-- 	maxY = CJ.GetCameraBoundMaxY() + scale * dyNorth

-- 	-- Make sure the camera bounds are still valid.
-- 	if maxX < minX then
-- 		minX = (minX + maxX) * 0.5
-- 		maxX = minX
-- 	end
-- 	if maxY < minY then
-- 		minY = (minY + maxY) * 0.5
-- 		maxY = minY
-- 	end

-- 	-- Apply the new camera values.
-- 	SetCameraBounds(minX, minY, minX, maxY, maxX, maxY, maxX, minY)
-- end

-- --===========================================================================
-- function BJ.AdjustCameraBoundsForPlayerBJ(adjustMethod, whichPlayer, dxWest, dxEast, dyNorth, dySouth)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		AdjustCameraBoundsBJ(adjustMethod, dxWest, dxEast, dyNorth, dySouth)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetCameraQuickPositionForPlayer(whichPlayer, x, y)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraQuickPosition(x, y)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetCameraQuickPositionLocForPlayer(whichPlayer, loc)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraQuickPosition(CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetCameraQuickPositionLoc(loc)
-- 	SetCameraQuickPosition(CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- end

-- --===========================================================================
-- function BJ.StopCameraForPlayerBJ(whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		StopCamera()
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetCameraOrientControllerForPlayerBJ(whichPlayer, whichUnit, xoffset, yoffset)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetCameraOrientController(whichUnit, xoffset, yoffset)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CameraSetSmoothingFactorBJ(factor)
-- 	CJ.CameraSetSmoothingFactor(factor)
-- end

-- ===========================================================================
function BJ.CameraResetSmoothingFactorBJ() CJ.CameraSetSmoothingFactor(0) end

-- --***************************************************************************
-- --*
-- --*  Text Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.DisplayTextToForce(toForce, message)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), toForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		DisplayTextToPlayer(CJ.GetLocalPlayer(), 0, 0, message)
-- 	end
-- end

-- --===========================================================================
-- function BJ.DisplayTimedTextToForce(toForce, duration, message)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), toForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, duration, message)
-- 	end
-- end

-- ===========================================================================
function BJ.ClearTextMessagesBJ(toForce)
    if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), toForce) then
        -- Use only local code (no net traffic) within this block to avoid desyncs.
        CJ.ClearTextMessages()
    end
end

-- --===========================================================================
-- -- The parameters for the API Substring function BJ.are unintuitive, so this
-- -- merely performs a translation for the starting index.
-- --
-- function BJ.SubStringBJ(source, start, end_)
-- 	return SubString(source, start - 1, end_)
-- end

-- function BJ.GetHandleIdBJ(h)
-- 	return GetHandleId(h)
-- end

-- function BJ.StringHashBJ(s)
-- 	return StringHash(s)
-- end

-- --***************************************************************************
-- --*
-- --*  Event Registration Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
function BJ.TriggerRegisterTimerEventPeriodic(trig, timeout)
    return CJ.TriggerRegisterTimerEvent(trig, timeout, true)
end

-- ===========================================================================
function BJ.TriggerRegisterTimerEventSingle(trig, timeout)
    return CJ.TriggerRegisterTimerEvent(trig, timeout, false)
end

-- --===========================================================================
-- function BJ.TriggerRegisterTimerExpireEventBJ(trig, t)
-- 	return CJ.TriggerRegisterTimerExpireEvent(trig, t)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterPlayerUnitEventSimple(trig, whichPlayer, whichEvent)
-- 	return CJ.TriggerRegisterPlayerUnitEvent(trig, whichPlayer, whichEvent, nil)
-- end

-- ===========================================================================
function BJ.TriggerRegisterAnyUnitEventBJ(trig, whichEvent)
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        CJ.TriggerRegisterPlayerUnitEvent(trig, CJ.Player(index), whichEvent,
                                          nil)
    end
end

--===========================================================================
function BJ.TriggerRegisterPlayerSelectionEventBJ(trig, whichPlayer, selected)
	if selected then
		return CJ.TriggerRegisterPlayerUnitEvent(trig, whichPlayer, CJ.EVENT_PLAYER_UNIT_SELECTED, nil)
	else
		return CJ.TriggerRegisterPlayerUnitEvent(trig, whichPlayer, CJ.EVENT_PLAYER_UNIT_DESELECTED, nil)
	end
end

-- --===========================================================================
-- function BJ.TriggerRegisterPlayerKeyEventBJ(trig, whichPlayer, keType, keKey)
-- 	if keType == bj_KEYEVENTTYPE_DEPRESS then
-- 		-- Depress event - find out what key
-- 		if keKey == bj_KEYEVENTKEY_LEFT then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_LEFT_DOWN)
-- 		elseif keKey == bj_KEYEVENTKEY_RIGHT then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_RIGHT_DOWN)
-- 		elseif keKey == bj_KEYEVENTKEY_DOWN then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_DOWN_DOWN)
-- 		elseif keKey == bj_KEYEVENTKEY_UP then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_UP_DOWN)
-- 		else
-- 			-- Unrecognized key - ignore the request and return failure.
-- 			return nil
-- 		end
-- 	elseif keType == bj_KEYEVENTTYPE_RELEASE then
-- 		-- Release event - find out what key
-- 		if keKey == bj_KEYEVENTKEY_LEFT then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_LEFT_UP)
-- 		elseif keKey == bj_KEYEVENTKEY_RIGHT then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_RIGHT_UP)
-- 		elseif keKey == bj_KEYEVENTKEY_DOWN then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_DOWN_UP)
-- 		elseif keKey == bj_KEYEVENTKEY_UP then
-- 			return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ARROW_UP_UP)
-- 		else
-- 			-- Unrecognized key - ignore the request and return failure.
-- 			return nil
-- 		end
-- 	else
-- 		-- Unrecognized type - ignore the request and return failure.
-- 		return nil
-- 	end
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterPlayerEventVictory(trig, whichPlayer)
-- 	return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_VICTORY)
-- end

--===========================================================================
function BJ.TriggerRegisterPlayerEventDefeat(trig, whichPlayer)
	return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, CJ.EVENT_PLAYER_DEFEAT)
end

--===========================================================================
function BJ.TriggerRegisterPlayerEventLeave(trig, whichPlayer)
	return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, CJ.EVENT_PLAYER_LEAVE)
end

-- --===========================================================================
-- function BJ.TriggerRegisterPlayerEventAllianceChanged(trig, whichPlayer)
-- 	return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, EVENT_PLAYER_ALLIANCE_CHANGED)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterPlayerEventEndCinematic(trig, whichPlayer)
-- 	return CJ.TriggerRegisterPlayerEvent(trig, whichPlayer, CJ.EVENT_PLAYER_END_CINEMATIC)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterGameStateEventTimeOfDay(trig, opcode, limitval)
-- 	return CJ.TriggerRegisterGameStateEvent(trig, CJ.GAME_STATE_TIME_OF_DAY, opcode, limitval)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterEnterRegionSimple(trig, whichRegion)
-- 	return TriggerRegisterEnterRegion(trig, whichRegion, nil)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterLeaveRegionSimple(trig, whichRegion)
-- 	return TriggerRegisterLeaveRegion(trig, whichRegion, nil)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterEnterRectSimple(trig, r)
-- 	local rectRegion = CreateRegion()
-- 	RegionAddRect(rectRegion, r)
-- 	return TriggerRegisterEnterRegion(trig, rectRegion, nil)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterLeaveRectSimple(trig, r)
-- 	local rectRegion = CreateRegion()
-- 	RegionAddRect(rectRegion, r)
-- 	return TriggerRegisterLeaveRegion(trig, rectRegion, nil)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterDistanceBetweenUnits(trig, whichUnit, condition, range)
-- 	return TriggerRegisterUnitInRange(trig, whichUnit, range, condition)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterUnitInRangeSimple(trig, range, whichUnit)
-- 	return TriggerRegisterUnitInRange(trig, whichUnit, range, nil)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterUnitLifeEvent(trig, whichUnit, opcode, limitval)
-- 	return TriggerRegisterUnitStateEvent(trig, whichUnit, CJ.UNIT_STATE_LIFE, opcode, limitval)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterUnitManaEvent(trig, whichUnit, opcode, limitval)
-- 	return TriggerRegisterUnitStateEvent(trig, whichUnit, UNIT_STATE_MANA, opcode, limitval)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterDialogEventBJ(trig, whichDialog)
-- 	return TriggerRegisterDialogEvent(trig, whichDialog)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterShowSkillEventBJ(trig)
-- 	return TriggerRegisterGameEvent(trig, EVENT_GAME_SHOW_SKILL)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterBuildSubmenuEventBJ(trig)
-- 	return TriggerRegisterGameEvent(trig, EVENT_GAME_BUILD_SUBMENU)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterGameLoadedEventBJ(trig)
-- 	return TriggerRegisterGameEvent(trig, EVENT_GAME_LOADED)
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterGameSavedEventBJ(trig)
-- 	return TriggerRegisterGameEvent(trig, EVENT_GAME_SAVE)
-- end

-- --===========================================================================
-- function BJ.RegisterDestDeathInRegionEnum()
-- 	bj_destInRegionDiesCount = bj_destInRegionDiesCount + 1
-- 	if bj_destInRegionDiesCount <= bj_MAX_DEST_IN_REGION_EVENTS then
-- 		TriggerRegisterDeathEvent(bj_destInRegionDiesTrig, GetEnumDestructable())
-- 	end
-- end

-- --===========================================================================
-- function BJ.TriggerRegisterDestDeathInRegionEvent(trig, r)
-- 	bj_destInRegionDiesTrig = trig
-- 	bj_destInRegionDiesCount = 0
-- 	EnumDestructablesInRect(r, nil, RegisterDestDeathInRegionEnum)
-- end

-- --***************************************************************************
-- --*
-- --*  Environment Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.AddWeatherEffectSaveLast(where, effectID)
-- 	bj_lastCreatedWeatherEffect = AddWeatherEffect(where, effectID)
-- 	return bj_lastCreatedWeatherEffect
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedWeatherEffect()
-- 	return bj_lastCreatedWeatherEffect
-- end

-- --===========================================================================
-- function BJ.RemoveWeatherEffectBJ(whichWeatherEffect)
-- 	RemoveWeatherEffect(whichWeatherEffect)
-- end

-- --===========================================================================
-- function BJ.TerrainDeformationCraterBJ(duration, permanent, where, radius, depth)
-- 	bj_lastCreatedTerrainDeformation = TerrainDeformCrater(CJ.GetLocationX(where), CJ.GetLocationY(where), radius, depth, CJ.R2I(duration * 1000), permanent)
-- 	return bj_lastCreatedTerrainDeformation
-- end

-- --===========================================================================
-- function BJ.TerrainDeformationRippleBJ(duration, limitNeg, where, startRadius, endRadius, depth, wavePeriod, waveWidth)
-- 	local spaceWave
-- 	local timeWave
-- 	local radiusRatio

-- 	if endRadius <= 0 or waveWidth <= 0 or wavePeriod <= 0 then
-- 		return nil
-- 	end

-- 	timeWave = 2.0 * duration / wavePeriod
-- 	spaceWave = 2.0 * endRadius / waveWidth
-- 	radiusRatio = startRadius / endRadius

-- 	bj_lastCreatedTerrainDeformation = TerrainDeformRipple(CJ.GetLocationX(where), CJ.GetLocationY(where), endRadius, depth, CJ.R2I(duration * 1000), 1, spaceWave, timeWave, radiusRatio, limitNeg)
-- 	return bj_lastCreatedTerrainDeformation
-- end

-- --===========================================================================
-- function BJ.TerrainDeformationWaveBJ(duration, source, target, radius, depth, trailDelay)
-- 	local distance
-- 	local dirX
-- 	local dirY
-- 	local speed

-- 	distance = BJ.DistanceBetweenPoints(source, target)
-- 	if distance == 0 or duration <= 0 then
-- 		return nil
-- 	end

-- 	dirX = (CJ.GetLocationX(target) - CJ.GetLocationX(source)) / distance
-- 	dirY = (CJ.GetLocationY(target) - CJ.GetLocationY(source)) / distance
-- 	speed = distance / duration

-- 	bj_lastCreatedTerrainDeformation = TerrainDeformWave(CJ.GetLocationX(source), CJ.GetLocationY(source), dirX, dirY, distance, speed, radius, depth, CJ.R2I(trailDelay * 1000), 1)
-- 	return bj_lastCreatedTerrainDeformation
-- end

-- --===========================================================================
-- function BJ.TerrainDeformationRandomBJ(duration, where, radius, minDelta, maxDelta, updateInterval)
-- 	bj_lastCreatedTerrainDeformation = TerrainDeformRandom(CJ.GetLocationX(where), CJ.GetLocationY(where), radius, minDelta, maxDelta, CJ.R2I(duration * 1000), CJ.R2I(updateInterval * 1000))
-- 	return bj_lastCreatedTerrainDeformation
-- end

-- --===========================================================================
-- function BJ.TerrainDeformationStopBJ(deformation, duration)
-- 	TerrainDeformStop(deformation, CJ.R2I(duration * 1000))
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedTerrainDeformation()
-- 	return bj_lastCreatedTerrainDeformation
-- end

-- --===========================================================================
-- function BJ.AddLightningLoc(codeName, where1, where2)
-- 	bj_lastCreatedLightning = AddLightningEx(codeName, true, CJ.GetLocationX(where1), CJ.GetLocationY(where1), GetLocationZ(where1), CJ.GetLocationX(where2), CJ.GetLocationY(where2), GetLocationZ(where2))
-- 	return bj_lastCreatedLightning
-- end

-- --===========================================================================
-- function BJ.DestroyLightningBJ(whichBolt)
-- 	return DestroyLightning(whichBolt)
-- end

-- --===========================================================================
-- function BJ.MoveLightningLoc(whichBolt, where1, where2)
-- 	return MoveLightningEx(whichBolt, true, CJ.GetLocationX(where1), CJ.GetLocationY(where1), GetLocationZ(where1), CJ.GetLocationX(where2), CJ.GetLocationY(where2), GetLocationZ(where2))
-- end

-- --===========================================================================
-- function BJ.GetLightningColorABJ(whichBolt)
-- 	return GetLightningColorA(whichBolt)
-- end

-- --===========================================================================
-- function BJ.GetLightningColorRBJ(whichBolt)
-- 	return GetLightningColorR(whichBolt)
-- end

-- --===========================================================================
-- function BJ.GetLightningColorGBJ(whichBolt)
-- 	return GetLightningColorG(whichBolt)
-- end

-- --===========================================================================
-- function BJ.GetLightningColorBBJ(whichBolt)
-- 	return GetLightningColorB(whichBolt)
-- end

-- --===========================================================================
-- function BJ.SetLightningColorBJ(whichBolt, r, g, b, a)
-- 	return SetLightningColor(whichBolt, r, g, b, a)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedLightningBJ()
-- 	return bj_lastCreatedLightning
-- end

-- --===========================================================================
-- function BJ.GetAbilityEffectBJ(abilcode, t, index)
-- 	return GetAbilityEffectById(abilcode, t, index)
-- end

-- --===========================================================================
-- function BJ.GetAbilitySoundBJ(abilcode, t)
-- 	return GetAbilitySoundById(abilcode, t)
-- end

-- --===========================================================================
-- function BJ.GetTerrainCliffLevelBJ(where)
-- 	return GetTerrainCliffLevel(CJ.GetLocationX(where), CJ.GetLocationY(where))
-- end

-- --===========================================================================
-- function BJ.GetTerrainTypeBJ(where)
-- 	return GetTerrainType(CJ.GetLocationX(where), CJ.GetLocationY(where))
-- end

-- --===========================================================================
-- function BJ.GetTerrainVarianceBJ(where)
-- 	return GetTerrainVariance(CJ.GetLocationX(where), CJ.GetLocationY(where))
-- end

-- --===========================================================================
-- function BJ.SetTerrainTypeBJ(where, terrainType, variation, area, shape)
-- 	SetTerrainType(CJ.GetLocationX(where), CJ.GetLocationY(where), terrainType, variation, area, shape)
-- end

-- --===========================================================================
-- function BJ.IsTerrainPathableBJ(where, t)
-- 	return IsTerrainPathable(CJ.GetLocationX(where), CJ.GetLocationY(where), t)
-- end

-- --===========================================================================
-- function BJ.SetTerrainPathableBJ(where, t, flag)
-- 	SetTerrainPathable(CJ.GetLocationX(where), CJ.GetLocationY(where), t, flag)
-- end

-- --===========================================================================
-- function BJ.SetWaterBaseColorBJ(red, green, blue, transparency)
-- 	SetWaterBaseColor(BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.CreateFogModifierRectSimple(whichPlayer, whichFogState, r, afterUnits)
-- 	bj_lastCreatedFogModifier = CreateFogModifierRect(whichPlayer, whichFogState, r, true, afterUnits)
-- 	return bj_lastCreatedFogModifier
-- end

-- --===========================================================================
-- function BJ.CreateFogModifierRadiusLocSimple(whichPlayer, whichFogState, center, radius, afterUnits)
-- 	bj_lastCreatedFogModifier = CreateFogModifierRadiusLoc(whichPlayer, whichFogState, center, radius, true, afterUnits)
-- 	return bj_lastCreatedFogModifier
-- end

-- --===========================================================================
-- -- Version of CreateFogModifierRect that assumes use of sharedVision and
-- -- gives the option of immediately enabling the modifier, so that triggers
-- -- can default to modifiers that are immediately enabled.
-- --
-- function BJ.CreateFogModifierRectBJ(enabled, whichPlayer, whichFogState, r)
-- 	bj_lastCreatedFogModifier = CreateFogModifierRect(whichPlayer, whichFogState, r, true, false)
-- 	if enabled then
-- 		FogModifierStart(bj_lastCreatedFogModifier)
-- 	end
-- 	return bj_lastCreatedFogModifier
-- end

-- --===========================================================================
-- -- Version of CreateFogModifierRadius that assumes use of sharedVision and
-- -- gives the option of immediately enabling the modifier, so that triggers
-- -- can default to modifiers that are immediately enabled.
-- --
-- function BJ.CreateFogModifierRadiusLocBJ(enabled, whichPlayer, whichFogState, center, radius)
-- 	bj_lastCreatedFogModifier = CreateFogModifierRadiusLoc(whichPlayer, whichFogState, center, radius, true, false)
-- 	if enabled then
-- 		FogModifierStart(bj_lastCreatedFogModifier)
-- 	end
-- 	return bj_lastCreatedFogModifier
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedFogModifier()
-- 	return bj_lastCreatedFogModifier
-- end

-- --===========================================================================
-- function BJ.FogEnableOn()
-- 	CJ.FogEnable(true)
-- end

-- ===========================================================================
function BJ.FogEnableOff() CJ.FogEnable(false) end

-- --===========================================================================
-- function BJ.FogMaskEnableOn()
-- 	CJ.FogMaskEnable(true)
-- end

-- ===========================================================================
function BJ.FogMaskEnableOff() CJ.FogMaskEnable(false) end

-- --===========================================================================
-- function BJ.UseTimeOfDayBJ(flag)
-- 	SuspendTimeOfDay(not flag)
-- end

-- --===========================================================================
-- function BJ.SetTerrainFogExBJ(style, zstart, zend, density, red, green, blue)
-- 	SetTerrainFogEx(style, zstart, zend, density, red * 0.01, green * 0.01, blue * 0.01)
-- end

-- --===========================================================================
-- function BJ.ResetTerrainFogBJ()
-- 	ResetTerrainFog()
-- end

-- --===========================================================================
-- function BJ.SetDoodadAnimationBJ(animName, doodadID, radius, center)
-- 	SetDoodadAnimation(CJ.GetLocationX(center), CJ.GetLocationY(center), radius, doodadID, false, animName, false)
-- end

-- --===========================================================================
-- function BJ.SetDoodadAnimationRectBJ(animName, doodadID, r)
-- 	SetDoodadAnimationRect(r, doodadID, animName, false)
-- end

-- --===========================================================================
-- function BJ.AddUnitAnimationPropertiesBJ(add, animProperties, whichUnit)
-- 	AddUnitAnimationProperties(whichUnit, animProperties, add)
-- end

-- --============================================================================
-- function BJ.CreateImageBJ(file, size, where, zOffset, imageType)
-- 	bj_lastCreatedImage = CreateImage(file, size, size, size, CJ.GetLocationX(where), CJ.GetLocationY(where), zOffset, 0, 0, 0, imageType)
-- 	return bj_lastCreatedImage
-- end

-- --============================================================================
-- function BJ.ShowImageBJ(flag, whichImage)
-- 	ShowImage(whichImage, flag)
-- end

-- --============================================================================
-- function BJ.SetImagePositionBJ(whichImage, where, zOffset)
-- 	SetImagePosition(whichImage, CJ.GetLocationX(where), CJ.GetLocationY(where), zOffset)
-- end

-- --============================================================================
-- function BJ.SetImageColorBJ(whichImage, red, green, blue, alpha)
-- 	SetImageColor(whichImage, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - alpha))
-- end

-- --============================================================================
-- function BJ.GetLastCreatedImage()
-- 	return bj_lastCreatedImage
-- end

-- --============================================================================
-- function BJ.CreateUbersplatBJ(where, name, red, green, blue, alpha, forcePaused, noBirthTime)
-- 	bj_lastCreatedUbersplat = CreateUbersplat(CJ.GetLocationX(where), CJ.GetLocationY(where), name, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - alpha), forcePaused, noBirthTime)
-- 	return bj_lastCreatedUbersplat
-- end

-- --============================================================================
-- function BJ.ShowUbersplatBJ(flag, whichSplat)
-- 	ShowUbersplat(whichSplat, flag)
-- end

-- --============================================================================
-- function BJ.GetLastCreatedUbersplat()
-- 	return bj_lastCreatedUbersplat
-- end

-- --***************************************************************************
-- --*
-- --*  Sound Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
function BJ.PlaySoundBJ(soundHandle)
    BJ.bj_lastPlayedSound = soundHandle
    if soundHandle ~= nil then CJ.StartSound(soundHandle) end
end

-- ===========================================================================
function BJ.StopSoundBJ(soundHandle, fadeOut)
    CJ.StopSound(soundHandle, false, fadeOut)
end

--===========================================================================
function BJ.SetSoundVolumeBJ(soundHandle, volumePercent)
	CJ.SetSoundVolume(soundHandle, BJ.PercentToInt(volumePercent, 127))
end

-- --===========================================================================
-- function BJ.SetSoundOffsetBJ(newOffset, soundHandle)
-- 	SetSoundPlayPosition(soundHandle, CJ.R2I(newOffset * 1000))
-- end

-- --===========================================================================
-- function BJ.SetSoundDistanceCutoffBJ(soundHandle, cutoff)
-- 	SetSoundDistanceCutoff(soundHandle, cutoff)
-- end

-- --===========================================================================
-- function BJ.SetSoundPitchBJ(soundHandle, pitch)
-- 	SetSoundPitch(soundHandle, pitch)
-- end

--===========================================================================
function BJ.SetSoundPositionLocBJ(soundHandle, loc, z)
	CJ.SetSoundPosition(soundHandle, CJ.GetLocationX(loc), CJ.GetLocationY(loc), z)
end

--===========================================================================
function BJ.AttachSoundToUnitBJ(soundHandle, whichUnit)
	CJ.AttachSoundToUnit(soundHandle, whichUnit)
end

-- --===========================================================================
-- function BJ.SetSoundConeAnglesBJ(soundHandle, inside, outside, outsideVolumePercent)
-- 	SetSoundConeAngles(soundHandle, inside, outside, BJ.PercentToInt(outsideVolumePercent, 127))
-- end

-- --===========================================================================
-- function BJ.KillSoundWhenDoneBJ(soundHandle)
-- 	KillSoundWhenDone(soundHandle)
-- end

--===========================================================================
function BJ.PlaySoundAtPointBJ(soundHandle, volumePercent, loc, z)
	BJ.SetSoundPositionLocBJ(soundHandle, loc, z)
	BJ.SetSoundVolumeBJ(soundHandle, volumePercent)
	BJ.PlaySoundBJ(soundHandle)
end

--===========================================================================
function BJ.PlaySoundOnUnitBJ(soundHandle, volumePercent, whichUnit)
	BJ.AttachSoundToUnitBJ(soundHandle, whichUnit)
	BJ.SetSoundVolumeBJ(soundHandle, volumePercent)
	BJ.PlaySoundBJ(soundHandle)
end

-- --===========================================================================
-- function BJ.PlaySoundFromOffsetBJ(soundHandle, volumePercent, startingOffset)
-- 	BJ.SetSoundVolumeBJ(soundHandle, volumePercent)
-- 	BJ.PlaySoundBJ(soundHandle)
-- 	SetSoundOffsetBJ(startingOffset, soundHandle)
-- end

-- --===========================================================================
-- function BJ.PlayMusicBJ(musicFileName)
-- 	bj_lastPlayedMusic = musicFileName
-- 	PlayMusic(musicFileName)
-- end

-- --===========================================================================
-- function BJ.PlayMusicExBJ(musicFileName, startingOffset, fadeInTime)
-- 	bj_lastPlayedMusic = musicFileName
-- 	PlayMusicEx(musicFileName, CJ.R2I(startingOffset * 1000), CJ.R2I(fadeInTime * 1000))
-- end

-- --===========================================================================
-- function BJ.SetMusicOffsetBJ(newOffset)
-- 	SetMusicPlayPosition(CJ.R2I(newOffset * 1000))
-- end

-- --===========================================================================
-- function BJ.PlayThematicMusicBJ(musicName)
-- 	PlayThematicMusic(musicName)
-- end

-- --===========================================================================
-- function BJ.PlayThematicMusicExBJ(musicName, startingOffset)
-- 	PlayThematicMusicEx(musicName, CJ.R2I(startingOffset * 1000))
-- end

-- --===========================================================================
-- function BJ.SetThematicMusicOffsetBJ(newOffset)
-- 	SetThematicMusicPlayPosition(CJ.R2I(newOffset * 1000))
-- end

-- --===========================================================================
-- function BJ.EndThematicMusicBJ()
-- 	CJ.EndThematicMusic()
-- end

-- --===========================================================================
-- function BJ.StopMusicBJ(fadeOut)
-- 	StopMusic(fadeOut)
-- end

-- --===========================================================================
-- function BJ.ResumeMusicBJ()
-- 	ResumeMusic()
-- end

-- --===========================================================================
-- function BJ.SetMusicVolumeBJ(volumePercent)
-- 	SetMusicVolume(BJ.PercentToInt(volumePercent, 127))
-- end

-- ===========================================================================
function BJ.GetSoundDurationBJ(soundHandle)
    if soundHandle == nil then
        return BJ.bj_NOTHING_SOUND_DURATION
    else
        return CJ.I2R(CJ.GetSoundDuration(soundHandle)) * 0.001
    end
end

-- --===========================================================================
-- function BJ.GetSoundFileDurationBJ(musicFileName)
-- 	return CJ.I2R(GetSoundFileDuration(musicFileName)) * 0.001
-- end

-- --===========================================================================
-- function BJ.GetLastPlayedSound()
-- 	return BJ.bj_lastPlayedSound
-- end

-- --===========================================================================
-- function BJ.GetLastPlayedMusic()
-- 	return bj_lastPlayedMusic
-- end

-- --===========================================================================
-- function BJ.VolumeGroupSetVolumeBJ(vgroup, percent)
-- 	CJ.VolumeGroupSetVolume(vgroup, percent * 0.01)
-- end

-- ===========================================================================
function BJ.SetCineModeVolumeGroupsImmediateBJ()
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_UNITMOVEMENT,
                            BJ.bj_CINEMODE_VOLUME_UNITMOVEMENT)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_UNITSOUNDS,
                            BJ.bj_CINEMODE_VOLUME_UNITSOUNDS)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_COMBAT,
                            BJ.bj_CINEMODE_VOLUME_COMBAT)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_SPELLS,
                            BJ.bj_CINEMODE_VOLUME_SPELLS)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_UI, BJ.bj_CINEMODE_VOLUME_UI)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_MUSIC,
                            BJ.bj_CINEMODE_VOLUME_MUSIC)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_AMBIENTSOUNDS,
                            BJ.bj_CINEMODE_VOLUME_AMBIENTSOUNDS)
    CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_FIRE,
                            BJ.bj_CINEMODE_VOLUME_FIRE)
end

-- ===========================================================================
function BJ.SetCineModeVolumeGroupsBJ()
    -- Delay the request if it occurs at map init.
    if BJ.bj_gameStarted then
        BJ.SetCineModeVolumeGroupsImmediateBJ()
    else
        CJ.TimerStart(BJ.bj_volumeGroupsTimer, BJ.bj_GAME_STARTED_THRESHOLD,
                      false, BJ.SetCineModeVolumeGroupsImmediateBJ)
    end
end

-- --===========================================================================
-- function BJ.SetSpeechVolumeGroupsImmediateBJ()
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_UNITMOVEMENT, bj_SPEECH_VOLUME_UNITMOVEMENT)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_UNITSOUNDS, bj_SPEECH_VOLUME_UNITSOUNDS)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_COMBAT, bj_SPEECH_VOLUME_COMBAT)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_SPELLS, bj_SPEECH_VOLUME_SPELLS)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_UI, bj_SPEECH_VOLUME_UI)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_MUSIC, bj_SPEECH_VOLUME_MUSIC)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_AMBIENTSOUNDS, bj_SPEECH_VOLUME_AMBIENTSOUNDS)
-- 	CJ.VolumeGroupSetVolume(CJ.SOUND_VOLUMEGROUP_FIRE, bj_SPEECH_VOLUME_FIRE)
-- end

-- --===========================================================================
-- function BJ.SetSpeechVolumeGroupsBJ()
-- 	-- Delay the request if it occurs at map init.
-- 	if BJ.bj_gameStarted then
-- 		SetSpeechVolumeGroupsImmediateBJ()
-- 	else
-- 		CJ.TimerStart(BJ.bj_volumeGroupsTimer, BJ.bj_GAME_STARTED_THRESHOLD, false, SetSpeechVolumeGroupsImmediateBJ)
-- 	end
-- end

-- --===========================================================================
-- function BJ.VolumeGroupResetImmediateBJ()
-- 	CJ.VolumeGroupReset()
-- end

-- --===========================================================================
-- function BJ.VolumeGroupResetBJ()
-- 	-- Delay the request if it occurs at map init.
-- 	if BJ.bj_gameStarted then
-- 		VolumeGroupResetImmediateBJ()
-- 	else
-- 		CJ.TimerStart(BJ.bj_volumeGroupsTimer, BJ.bj_GAME_STARTED_THRESHOLD, false, VolumeGroupResetImmediateBJ)
-- 	end
-- end

-- --===========================================================================
-- function BJ.GetSoundIsPlayingBJ(soundHandle)
-- 	return GetSoundIsLoading(soundHandle) or GetSoundIsPlaying(soundHandle)
-- end

-- ===========================================================================
function BJ.WaitForSoundBJ(soundHandle, offset)
    CJ.TriggerWaitForSound(soundHandle, offset)
end

-- --===========================================================================
-- function BJ.SetMapMusicIndexedBJ(musicName, index)
-- 	SetMapMusic(musicName, false, index)
-- end

-- --===========================================================================
-- function BJ.SetMapMusicRandomBJ(musicName)
-- 	SetMapMusic(musicName, true, 0)
-- end

-- --===========================================================================
-- function BJ.ClearMapMusicBJ()
-- 	ClearMapMusic()
-- end

-- --===========================================================================
-- function BJ.SetStackedSoundBJ(add, soundHandle, r)
-- 	local width = CJ.GetRectMaxX(r) - CJ.GetRectMinX(r)
-- 	local height = CJ.GetRectMaxY(r) - CJ.GetRectMinY(r)

-- 	CJ.SetSoundPosition(soundHandle, CJ.GetRectCenterX(r), CJ.GetRectCenterY(r), 0)
-- 	if add then
-- 		RegisterStackedSound(soundHandle, true, width, height)
-- 	else
-- 		UnregisterStackedSound(soundHandle, true, width, height)
-- 	end
-- end

-- ===========================================================================
function BJ.StartSoundForPlayerBJ(whichPlayer, soundHandle)
    if whichPlayer == CJ.GetLocalPlayer() then CJ.StartSound(soundHandle) end
end

-- ===========================================================================
function BJ.VolumeGroupSetVolumeForPlayerBJ(whichPlayer, vgroup, scale)
    if CJ.GetLocalPlayer() == whichPlayer then
        CJ.VolumeGroupSetVolume(vgroup, scale)
    end
end

-- ===========================================================================
function BJ.EnableDawnDusk(flag) BJ.bj_useDawnDuskSounds = flag end

-- ===========================================================================
function BJ.IsDawnDuskEnabled() return BJ.bj_useDawnDuskSounds end

-- --***************************************************************************
-- --*
-- --*  Day/Night ambient sounds
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.SetAmbientDaySound(inLabel)
-- 	local ToD

-- 	-- Stop old sound, if necessary
-- 	if BJ.bj_dayAmbientSound ~= nil then
-- 		CJ.StopSound(BJ.bj_dayAmbientSound, true, true)
-- 	end

-- 	-- Create new sound
-- 	BJ.bj_dayAmbientSound = CreateMIDISound(inLabel, 20, 20)

-- 	-- Start the sound if necessary, based on current time
-- 	ToD = BJ.GetTimeOfDay()
-- 	if ToD >= BJ.bj_TOD_DAWN and ToD < BJ.bj_TOD_DUSK then
-- 		CJ.StartSound(BJ.bj_dayAmbientSound)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetAmbientNightSound(inLabel)
-- 	local ToD

-- 	-- Stop old sound, if necessary
-- 	if BJ.bj_nightAmbientSound ~= nil then
-- 		CJ.StopSound(BJ.bj_nightAmbientSound, true, true)
-- 	end

-- 	-- Create new sound
-- 	BJ.bj_nightAmbientSound = CreateMIDISound(inLabel, 20, 20)

-- 	-- Start the sound if necessary, based on current time
-- 	ToD = BJ.GetTimeOfDay()
-- 	if ToD < BJ.bj_TOD_DAWN or ToD >= BJ.bj_TOD_DUSK then
-- 		CJ.StartSound(BJ.bj_nightAmbientSound)
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Special Effect Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
function BJ.AddSpecialEffectLocBJ(where, modelName)
    BJ.bj_lastCreatedEffect = CJ.AddSpecialEffectLoc(modelName, where)
    return BJ.bj_lastCreatedEffect
end

-- --===========================================================================
-- function BJ.AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
-- 	BJ.bj_lastCreatedEffect = AddSpecialEffectTarget(modelName, targetWidget, attachPointName)
-- 	return BJ.bj_lastCreatedEffect
-- end

-- --===========================================================================
-- -- Two distinct trigger actions can't share the same function BJ.name, so this
-- -- dummy function BJ.simply mimics the behavior of an existing call.
-- --
-- -- Commented out - Destructibles have no attachment points.
-- --
-- --function BJ.AddSpecialEffectTargetDestructableBJ takes string attachPointName, widget targetWidget, string modelName returns effect
-- --    return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
-- --endfunction

-- --===========================================================================
-- -- Two distinct trigger actions can't share the same function BJ.name, so this
-- -- dummy function BJ.simply mimics the behavior of an existing call.
-- --
-- -- Commented out - Items have no attachment points.
-- --
-- --function BJ.AddSpecialEffectTargetItemBJ takes string attachPointName, widget targetWidget, string modelName returns effect
-- --    return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
-- --endfunction

-- --===========================================================================
-- function BJ.DestroyEffectBJ(whichEffect)
-- 	CJ.DestroyEffect(whichEffect)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedEffectBJ()
-- 	return BJ.bj_lastCreatedEffect
-- end

-- --***************************************************************************
-- --*
-- --*  Hero and Item Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.GetItemLoc(whichItem)
-- 	return CJ.Location(GetItemX(whichItem), GetItemY(whichItem))
-- end

-- --===========================================================================
-- function BJ.GetItemLifeBJ(whichWidget)
-- 	return GetWidgetLife(whichWidget)
-- end

-- --===========================================================================
-- function BJ.SetItemLifeBJ(whichWidget, life)
-- 	SetWidgetLife(whichWidget, life)
-- end

-- --===========================================================================
-- function BJ.AddHeroXPSwapped(xpToAdd, whichHero, showEyeCandy)
-- 	AddHeroXP(whichHero, xpToAdd, showEyeCandy)
-- end

-- --===========================================================================
-- function BJ.SetHeroLevelBJ(whichHero, newLevel, showEyeCandy)
-- 	local oldLevel = GetHeroLevel(whichHero)

-- 	if newLevel > oldLevel then
-- 		SetHeroLevel(whichHero, newLevel, showEyeCandy)
-- 	elseif newLevel < oldLevel then
-- 		UnitStripHeroLevel(whichHero, oldLevel - newLevel)
-- 	else
-- 	-- No change in level - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.DecUnitAbilityLevelSwapped(abilcode, whichUnit)
-- 	return DecUnitAbilityLevel(whichUnit, abilcode)
-- end

-- --===========================================================================
-- function BJ.IncUnitAbilityLevelSwapped(abilcode, whichUnit)
-- 	return IncUnitAbilityLevel(whichUnit, abilcode)
-- end

-- --===========================================================================
-- function BJ.SetUnitAbilityLevelSwapped(abilcode, whichUnit, level)
-- 	return SetUnitAbilityLevel(whichUnit, abilcode, level)
-- end

-- --===========================================================================
-- function BJ.GetUnitAbilityLevelSwapped(abilcode, whichUnit)
-- 	return GetUnitAbilityLevel(whichUnit, abilcode)
-- end

-- --===========================================================================
-- function BJ.UnitHasBuffBJ(whichUnit, buffcode)
-- 	return GetUnitAbilityLevel(whichUnit, buffcode) > 0
-- end

-- --===========================================================================
-- function BJ.UnitRemoveBuffBJ(buffcode, whichUnit)
-- 	return UnitRemoveAbility(whichUnit, buffcode)
-- end

-- --===========================================================================
-- function BJ.UnitAddItemSwapped(whichItem, whichHero)
-- 	return UnitAddItem(whichHero, whichItem)
-- end

-- --===========================================================================
-- function BJ.UnitAddItemByIdSwapped(itemId, whichHero)
-- 	-- Create the item at the hero's feet first, and then give it to him.
-- 	-- This is to ensure that the item will be left at the hero's feet if
-- 	-- his inventory is full. 
-- 	bj_lastCreatedItem = CreateItem(itemId, CJ.GetUnitX(whichHero), CJ.GetUnitY(whichHero))
-- 	UnitAddItem(whichHero, bj_lastCreatedItem)
-- 	return bj_lastCreatedItem
-- end

-- --===========================================================================
-- function BJ.UnitRemoveItemSwapped(whichItem, whichHero)
-- 	bj_lastRemovedItem = whichItem
-- 	UnitRemoveItem(whichHero, whichItem)
-- end

-- --===========================================================================
-- -- Translates 0-based slot indices to 1-based slot indices.
-- --
-- function BJ.UnitRemoveItemFromSlotSwapped(itemSlot, whichHero)
-- 	bj_lastRemovedItem = UnitRemoveItemFromSlot(whichHero, itemSlot - 1)
-- 	return bj_lastRemovedItem
-- end

-- --===========================================================================
-- function BJ.CreateItemLoc(itemId, loc)
-- 	bj_lastCreatedItem = CreateItem(itemId, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- 	return bj_lastCreatedItem
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedItem()
-- 	return bj_lastCreatedItem
-- end

-- --===========================================================================
-- function BJ.GetLastRemovedItem()
-- 	return bj_lastRemovedItem
-- end

-- --===========================================================================
-- function BJ.SetItemPositionLoc(whichItem, loc)
-- 	SetItemPosition(whichItem, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- end

-- --===========================================================================
-- function BJ.GetLearnedSkillBJ()
-- 	return GetLearnedSkill()
-- end

-- --===========================================================================
-- function BJ.SuspendHeroXPBJ(flag, whichHero)
-- 	SuspendHeroXP(whichHero, not flag)
-- end

-- --===========================================================================
-- function BJ.SetPlayerHandicapXPBJ(whichPlayer, handicapPercent)
-- 	SetPlayerHandicapXP(whichPlayer, handicapPercent * 0.01)
-- end

-- --===========================================================================
-- function BJ.GetPlayerHandicapXPBJ(whichPlayer)
-- 	return GetPlayerHandicapXP(whichPlayer) * 100
-- end

-- --===========================================================================
-- function BJ.SetPlayerHandicapBJ(whichPlayer, handicapPercent)
-- 	SetPlayerHandicap(whichPlayer, handicapPercent * 0.01)
-- end

-- --===========================================================================
-- function BJ.GetPlayerHandicapBJ(whichPlayer)
-- 	return GetPlayerHandicap(whichPlayer) * 100
-- end

-- --===========================================================================
-- function BJ.GetHeroStatBJ(whichStat, whichHero, includeBonuses)
-- 	if whichStat == bj_HEROSTAT_STR then
-- 		return GetHeroStr(whichHero, includeBonuses)
-- 	elseif whichStat == bj_HEROSTAT_AGI then
-- 		return GetHeroAgi(whichHero, includeBonuses)
-- 	elseif whichStat == bj_HEROSTAT_INT then
-- 		return GetHeroInt(whichHero, includeBonuses)
-- 	else
-- 		-- Unrecognized hero stat - return 0
-- 		return 0
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetHeroStat(whichHero, whichStat, value)
-- 	-- Ignore requests for negative hero stats.
-- 	if value <= 0 then
-- 		return
-- 	end

-- 	if whichStat == bj_HEROSTAT_STR then
-- 		SetHeroStr(whichHero, value, true)
-- 	elseif whichStat == bj_HEROSTAT_AGI then
-- 		SetHeroAgi(whichHero, value, true)
-- 	elseif whichStat == bj_HEROSTAT_INT then
-- 		SetHeroInt(whichHero, value, true)
-- 	else
-- 	-- Unrecognized hero stat - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.ModifyHeroStat(whichStat, whichHero, modifyMethod, value)
-- 	if modifyMethod == bj_MODIFYMETHOD_ADD then
-- 		SetHeroStat(whichHero, whichStat, GetHeroStatBJ(whichStat, whichHero, false) + value)
-- 	elseif modifyMethod == bj_MODIFYMETHOD_SUB then
-- 		SetHeroStat(whichHero, whichStat, GetHeroStatBJ(whichStat, whichHero, false) - value)
-- 	elseif modifyMethod == bj_MODIFYMETHOD_SET then
-- 		SetHeroStat(whichHero, whichStat, value)
-- 	else
-- 	-- Unrecognized modification method - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.ModifyHeroSkillPoints(whichHero, modifyMethod, value)
-- 	if modifyMethod == bj_MODIFYMETHOD_ADD then
-- 		return UnitModifySkillPoints(whichHero, value)
-- 	elseif modifyMethod == bj_MODIFYMETHOD_SUB then
-- 		return UnitModifySkillPoints(whichHero,  - value)
-- 	elseif modifyMethod == bj_MODIFYMETHOD_SET then
-- 		return UnitModifySkillPoints(whichHero, value - GetHeroSkillPoints(whichHero))
-- 	else
-- 		-- Unrecognized modification method - ignore the request and return failure.
-- 		return false
-- 	end
-- end

-- --===========================================================================
-- function BJ.UnitDropItemPointBJ(whichUnit, whichItem, x, y)
-- 	return UnitDropItemPoint(whichUnit, whichItem, x, y)
-- end

-- --===========================================================================
-- function BJ.UnitDropItemPointLoc(whichUnit, whichItem, loc)
-- 	return UnitDropItemPoint(whichUnit, whichItem, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- end

-- --===========================================================================
-- function BJ.UnitDropItemSlotBJ(whichUnit, whichItem, slot)
-- 	return UnitDropItemSlot(whichUnit, whichItem, slot - 1)
-- end

-- --===========================================================================
-- function BJ.UnitDropItemTargetBJ(whichUnit, whichItem, target)
-- 	return UnitDropItemTarget(whichUnit, whichItem, target)
-- end

-- --===========================================================================
-- -- Two distinct trigger actions can't share the same function BJ.name, so this
-- -- dummy function BJ.simply mimics the behavior of an existing call.
-- --
-- function BJ.UnitUseItemDestructable(whichUnit, whichItem, target)
-- 	return UnitUseItemTarget(whichUnit, whichItem, target)
-- end

-- --===========================================================================
-- function BJ.UnitUseItemPointLoc(whichUnit, whichItem, loc)
-- 	return UnitUseItemPoint(whichUnit, whichItem, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- end

-- --===========================================================================
-- -- Translates 0-based slot indices to 1-based slot indices.
-- --
-- function BJ.UnitItemInSlotBJ(whichUnit, itemSlot)
-- 	return UnitItemInSlot(whichUnit, itemSlot - 1)
-- end

-- --===========================================================================
-- -- Translates 0-based slot indices to 1-based slot indices.
-- --
-- function BJ.GetInventoryIndexOfItemTypeBJ(whichUnit, itemId)
-- 	local index
-- 	local indexItem

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexItem = UnitItemInSlot(whichUnit, index)
-- 		if indexItem ~= nil and CJ.GetItemTypeId(indexItem) == itemId then
-- 			return index + 1
-- 		end

-- 		index = index + 1
-- 		if index >= bj_MAX_INVENTORY then break end
-- 	end
-- 	return 0
-- end

-- --===========================================================================
-- function BJ.GetItemOfTypeFromUnitBJ(whichUnit, itemId)
-- 	local index = GetInventoryIndexOfItemTypeBJ(whichUnit, itemId)

-- 	if index == 0 then
-- 		return nil
-- 	else
-- 		return UnitItemInSlot(whichUnit, index - 1)
-- 	end
-- end

-- --===========================================================================
-- function BJ.UnitHasItemOfTypeBJ(whichUnit, itemId)
-- 	return GetInventoryIndexOfItemTypeBJ(whichUnit, itemId) > 0
-- end

-- --===========================================================================
-- function BJ.UnitInventoryCount(whichUnit)
-- 	local index = 0
-- 	local count = 0

-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		if UnitItemInSlot(whichUnit, index) ~= nil then
-- 			count = count + 1
-- 		end

-- 		index = index + 1
-- 		if index >= bj_MAX_INVENTORY then break end
-- 	end

-- 	return count
-- end

-- --===========================================================================
-- function BJ.UnitInventorySizeBJ(whichUnit)
-- 	return UnitInventorySize(whichUnit)
-- end

-- --===========================================================================
-- function BJ.SetItemInvulnerableBJ(whichItem, flag)
-- 	SetItemInvulnerable(whichItem, flag)
-- end

-- --===========================================================================
-- function BJ.SetItemDropOnDeathBJ(whichItem, flag)
-- 	SetItemDropOnDeath(whichItem, flag)
-- end

-- --===========================================================================
-- function BJ.SetItemDroppableBJ(whichItem, flag)
-- 	SetItemDroppable(whichItem, flag)
-- end

-- --===========================================================================
-- function BJ.SetItemPlayerBJ(whichItem, whichPlayer, changeColor)
-- 	SetItemPlayer(whichItem, whichPlayer, changeColor)
-- end

-- --===========================================================================
-- function BJ.SetItemVisibleBJ(show, whichItem)
-- 	SetItemVisible(whichItem, show)
-- end

-- --===========================================================================
-- function BJ.IsItemHiddenBJ(whichItem)
-- 	return not IsItemVisible(whichItem)
-- end

-- --===========================================================================
-- function BJ.ChooseRandomItemBJ(level)
-- 	return ChooseRandomItem(level)
-- end

-- --===========================================================================
-- function BJ.ChooseRandomItemExBJ(level, whichType)
-- 	return CJ.ChooseRandomItemEx(whichType, level)
-- end

-- --===========================================================================
-- function BJ.ChooseRandomNPBuildingBJ()
-- 	return ChooseRandomNPBuilding()
-- end

-- --===========================================================================
-- function BJ.ChooseRandomCreepBJ(level)
-- 	return ChooseRandomCreep(level)
-- end

-- --===========================================================================
-- function BJ.EnumItemsInRectBJ(r, actionFunc)
-- 	EnumItemsInRect(r, nil, actionFunc)
-- end

-- --===========================================================================
-- -- See GroupPickRandomUnitEnum for the details of this algorithm.
-- --
-- function BJ.RandomItemInRectBJEnum()
-- 	bj_itemRandomConsidered = bj_itemRandomConsidered + 1
-- 	if CJ.GetRandomInt(1, bj_itemRandomConsidered) == 1 then
-- 		bj_itemRandomCurrentPick = GetEnumItem()
-- 	end
-- end

-- --===========================================================================
-- -- Picks a random item from within a rect, matching a condition
-- --
-- function BJ.RandomItemInRectBJ(r, filter)
-- 	bj_itemRandomConsidered = 0
-- 	bj_itemRandomCurrentPick = nil
-- 	EnumItemsInRect(r, filter, RandomItemInRectBJEnum)
-- 	CJ.DestroyBoolExpr(filter)
-- 	return bj_itemRandomCurrentPick
-- end

-- --===========================================================================
-- -- Picks a random item from within a rect
-- --
-- function BJ.RandomItemInRectSimpleBJ(r)
-- 	return RandomItemInRectBJ(r, nil)
-- end

-- --===========================================================================
-- function BJ.CheckItemStatus(whichItem, status)
-- 	if status == bj_ITEM_STATUS_HIDDEN then
-- 		return not IsItemVisible(whichItem)
-- 	elseif status == bj_ITEM_STATUS_OWNED then
-- 		return IsItemOwned(whichItem)
-- 	elseif status == bj_ITEM_STATUS_INVULNERABLE then
-- 		return IsItemInvulnerable(whichItem)
-- 	elseif status == bj_ITEM_STATUS_POWERUP then
-- 		return IsItemPowerup(whichItem)
-- 	elseif status == bj_ITEM_STATUS_SELLABLE then
-- 		return IsItemSellable(whichItem)
-- 	elseif status == bj_ITEM_STATUS_PAWNABLE then
-- 		return IsItemPawnable(whichItem)
-- 	else
-- 		-- Unrecognized status - return false
-- 		return false
-- 	end
-- end

-- --===========================================================================
-- function BJ.CheckItemcodeStatus(itemId, status)
-- 	if status == bj_ITEMCODE_STATUS_POWERUP then
-- 		return IsItemIdPowerup(itemId)
-- 	elseif status == bj_ITEMCODE_STATUS_SELLABLE then
-- 		return CJ.IsItemIdSellable(itemId)
-- 	elseif status == bj_ITEMCODE_STATUS_PAWNABLE then
-- 		return IsItemIdPawnable(itemId)
-- 	else
-- 		-- Unrecognized status - return false
-- 		return false
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Unit Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.UnitId2OrderIdBJ(unitId)
-- 	return unitId
-- end

-- --===========================================================================
-- function BJ.String2UnitIdBJ(unitIdString)
-- 	return CJ.UnitId(unitIdString)
-- end

-- --===========================================================================
-- function BJ.UnitId2StringBJ(unitId)
-- 	local unitString = UnitId2String(unitId)

-- 	if unitString ~= nil then
-- 		return unitString
-- 	end

-- 	-- The unitId was not recognized - return an empty string.
-- 	return ""
-- end

--===========================================================================
function BJ.String2OrderIdBJ(orderIdString)
	local orderId

	-- Check to see if it's a generic order.
	orderId = CJ.OrderId(orderIdString)
	if orderId ~= 0 then
		return orderId
	end

	-- Check to see if it's a (train) unit order.
	orderId = CJ.UnitId(orderIdString)
	if orderId ~= 0 then
		return orderId
	end

	-- Unrecognized - return 0
	return 0
end

-- --===========================================================================
-- function BJ.OrderId2StringBJ(orderId)
-- 	local orderString

-- 	-- Check to see if it's a generic order.
-- 	orderString = OrderId2String(orderId)
-- 	if orderString ~= nil then
-- 		return orderString
-- 	end

-- 	-- Check to see if it's a (train) unit order.
-- 	orderString = UnitId2String(orderId)
-- 	if orderString ~= nil then
-- 		return orderString
-- 	end

-- 	-- Unrecognized - return an empty string.
-- 	return ""
-- end

-- --===========================================================================
-- function BJ.GetIssuedOrderIdBJ()
-- 	return GetIssuedOrderId()
-- end

-- --===========================================================================
-- function BJ.GetKillingUnitBJ()
-- 	return GetKillingUnit()
-- end

-- ===========================================================================
function BJ.CreateUnitAtLocSaveLast(id, unitid, loc, face)
    if unitid == 1969713004 then
        BJ.bj_lastCreatedUnit = CJ.CreateBlightedGoldmine(id,
                                                          CJ.GetLocationX(loc),
                                                          CJ.GetLocationY(loc),
                                                          face)
    else
        BJ.bj_lastCreatedUnit = CJ.CreateUnitAtLoc(id, unitid, loc, face)
    end

    return BJ.bj_lastCreatedUnit
end

-- ===========================================================================
function BJ.GetLastCreatedUnit() return BJ.bj_lastCreatedUnit end

-- ===========================================================================
function BJ.CreateNUnitsAtLoc(count, unitId, whichPlayer, loc, face)
    CJ.GroupClear(BJ.bj_lastCreatedGroup)
    for index = 1, count do
        BJ.CreateUnitAtLocSaveLast(whichPlayer, unitId, loc, face)
        CJ.GroupAddUnit(BJ.bj_lastCreatedGroup, BJ.bj_lastCreatedUnit)
    end
    return BJ.bj_lastCreatedGroup
end

-- ===========================================================================
function BJ.CreateNUnitsAtLocFacingLocBJ(count, unitId, whichPlayer, loc, lookAt)
    return BJ.CreateNUnitsAtLoc(count, unitId, whichPlayer, loc,
                                BJ.AngleBetweenPoints(loc, lookAt))
end

-- --===========================================================================
-- function BJ.GetLastCreatedGroupEnum()
-- 	CJ.GroupAddUnit(bj_groupLastCreatedDest, CJ.GetEnumUnit())
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedGroup()
-- 	bj_groupLastCreatedDest = CJ.CreateGroup()
-- 	CJ.ForGroup(BJ.bj_lastCreatedGroup, GetLastCreatedGroupEnum)
-- 	return bj_groupLastCreatedDest
-- end

-- --===========================================================================
-- function BJ.CreateCorpseLocBJ(unitid, whichPlayer, loc)
-- 	BJ.bj_lastCreatedUnit = CJ.CreateCorpse(whichPlayer, unitid, CJ.GetLocationX(loc), CJ.GetLocationY(loc), CJ.GetRandomReal(0, 360))
-- 	return BJ.bj_lastCreatedUnit
-- end

-- --===========================================================================
-- function BJ.UnitSuspendDecayBJ(suspend, whichUnit)
-- 	CJ.UnitSuspendDecay(whichUnit, suspend)
-- end

-- ===========================================================================
function BJ.DelayedSuspendDecayStopAnimEnum()
    local enumUnit = CJ.GetEnumUnit()

    if CJ.GetUnitState(enumUnit, CJ.UNIT_STATE_LIFE) <= 0 then
        CJ.SetUnitTimeScale(enumUnit, 0.0001)
    end
end

-- ===========================================================================
function BJ.DelayedSuspendDecayBoneEnum()
    local enumUnit = CJ.GetEnumUnit()

    if CJ.GetUnitState(enumUnit, CJ.UNIT_STATE_LIFE) <= 0 then
        CJ.UnitSuspendDecay(enumUnit, true)
        CJ.SetUnitTimeScale(enumUnit, 0.0001)
    end
end

-- ===========================================================================
-- Game code explicitly sets the animation back to "decay bone" after the
-- initial corpse fades away, so we reset it now.  It's best not to show
-- off corpses thus created until after this grace period has passed.
--
function BJ.DelayedSuspendDecayFleshEnum()
    local enumUnit = CJ.GetEnumUnit()

    if CJ.GetUnitState(enumUnit, CJ.UNIT_STATE_LIFE) <= 0 then
        CJ.UnitSuspendDecay(enumUnit, true)
        CJ.SetUnitTimeScale(enumUnit, 10.0)
        CJ.SetUnitAnimation(enumUnit, "decay flesh")
    end
end

-- ===========================================================================
-- Waits a short period of time to ensure that the corpse is decaying, and
-- then suspend the animation and corpse decay.
--
function BJ.DelayedSuspendDecay()
    local boneGroup
    local fleshGroup

    -- Switch the global unit groups over to local variables and recreate
    -- the global versions, so that this function BJ.can handle overlapping
    -- calls.
    boneGroup = BJ.bj_suspendDecayBoneGroup
    fleshGroup = BJ.bj_suspendDecayFleshGroup
    BJ.bj_suspendDecayBoneGroup = CJ.CreateGroup()
    BJ.bj_suspendDecayFleshGroup = CJ.CreateGroup()

    CJ.ForGroup(fleshGroup, BJ.DelayedSuspendDecayStopAnimEnum)
    CJ.ForGroup(boneGroup, BJ.DelayedSuspendDecayStopAnimEnum)

    CJ.TriggerSleepAction(BJ.bj_CORPSE_MAX_DEATH_TIME)
    CJ.ForGroup(fleshGroup, BJ.DelayedSuspendDecayFleshEnum)
    CJ.ForGroup(boneGroup, BJ.DelayedSuspendDecayBoneEnum)

    CJ.TriggerSleepAction(0.05)
    CJ.ForGroup(fleshGroup, BJ.DelayedSuspendDecayStopAnimEnum)

    CJ.DestroyGroup(boneGroup)
    CJ.DestroyGroup(fleshGroup)
end

-- ===========================================================================
function BJ.DelayedSuspendDecayCreate()
    BJ.bj_delayedSuspendDecayTrig = CJ.CreateTrigger()
    CJ.TriggerRegisterTimerExpireEvent(BJ.bj_delayedSuspendDecayTrig,
                                       BJ.bj_delayedSuspendDecayTimer)
    CJ.TriggerAddAction(BJ.bj_delayedSuspendDecayTrig, BJ.DelayedSuspendDecay)
end

--===========================================================================
function BJ.CreatePermanentCorpseLocBJ(style, unitid, whichPlayer, loc, facing)
	BJ.bj_lastCreatedUnit = CJ.CreateCorpse(whichPlayer, unitid, CJ.GetLocationX(loc), CJ.GetLocationY(loc), facing)
	CJ.SetUnitBlendTime(BJ.bj_lastCreatedUnit, 0)

	if style == BJ.CORPSETYPE_FLESH then
		CJ.SetUnitAnimation(BJ.bj_lastCreatedUnit, "decay flesh")
		CJ.GroupAddUnit(BJ.bj_suspendDecayFleshGroup, BJ.bj_lastCreatedUnit)
	elseif style == BJ.CORPSETYPE_BONE then
		CJ.SetUnitAnimation(BJ.bj_lastCreatedUnit, "decay bone")
		CJ.GroupAddUnit(BJ.bj_suspendDecayBoneGroup, BJ.bj_lastCreatedUnit)
	else
		-- Unknown decay style - treat as skeletal.
		CJ.SetUnitAnimation(BJ.bj_lastCreatedUnit, "decay bone")
		CJ.GroupAddUnit(BJ.bj_suspendDecayBoneGroup, BJ.bj_lastCreatedUnit)
	end

	CJ.TimerStart(BJ.bj_delayedSuspendDecayTimer, 0.05, false, nil)
	return BJ.bj_lastCreatedUnit
end

-- ===========================================================================
function BJ.GetUnitStateSwap(whichState, whichUnit)
    return CJ.GetUnitState(whichUnit, whichState)
end

-- ===========================================================================
function BJ.GetUnitStatePercent(whichUnit, whichState, whichMaxState)
    local value = CJ.GetUnitState(whichUnit, whichState)
    local maxValue = CJ.GetUnitState(whichUnit, whichMaxState)

    -- Return 0 for null units.
    if whichUnit == nil or maxValue == 0 then return 0.0 end

    return value / maxValue * 100.0
end

-- ===========================================================================
function BJ.GetUnitLifePercent(whichUnit)
    return BJ.GetUnitStatePercent(whichUnit, CJ.UNIT_STATE_LIFE,
                                  CJ.UNIT_STATE_MAX_LIFE)
end

-- ===========================================================================
function BJ.GetUnitManaPercent(whichUnit)
    return BJ.GetUnitStatePercent(whichUnit, CJ.UNIT_STATE_MANA,
                                  CJ.UNIT_STATE_MAX_MANA)
end

-- --===========================================================================
-- function BJ.SelectUnitSingle(whichUnit)
-- 	CJ.ClearSelection()
-- 	CJ.SelectUnit(whichUnit, true)
-- end

-- --===========================================================================
-- function BJ.SelectGroupBJEnum()
-- 	CJ.SelectUnit(CJ.GetEnumUnit(), true)
-- end

-- --===========================================================================
-- function BJ.SelectGroupBJ(g)
-- 	CJ.ClearSelection()
-- 	CJ.ForGroup(g, SelectGroupBJEnum)
-- end

-- --===========================================================================
-- function BJ.SelectUnitAdd(whichUnit)
-- 	CJ.SelectUnit(whichUnit, true)
-- end

-- --===========================================================================
-- function BJ.SelectUnitRemove(whichUnit)
-- 	CJ.SelectUnit(whichUnit, false)
-- end

-- --===========================================================================
-- function BJ.ClearSelectionForPlayer(whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.ClearSelection()
-- 	end
-- end

-- ===========================================================================
function BJ.SelectUnitForPlayerSingle(whichUnit, whichPlayer)
    if CJ.GetLocalPlayer() == whichPlayer then
        -- Use only local code (no net traffic) within this block to avoid desyncs.
        CJ.ClearSelection()
        CJ.SelectUnit(whichUnit, true)
    end
end

-- --===========================================================================
-- function BJ.SelectGroupForPlayerBJ(g, whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.ClearSelection()
-- 		CJ.ForGroup(g, SelectGroupBJEnum)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SelectUnitAddForPlayer(whichUnit, whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.SelectUnit(whichUnit, true)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SelectUnitRemoveForPlayer(whichUnit, whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.SelectUnit(whichUnit, false)
-- 	end
-- end

-- ===========================================================================
function BJ.SetUnitLifeBJ(whichUnit, newValue)
    CJ.SetUnitState(whichUnit, CJ.UNIT_STATE_LIFE, BJ.RMaxBJ(0, newValue))
end

-- --===========================================================================
-- function BJ.SetUnitManaBJ(whichUnit, newValue)
-- 	CJ.SetUnitState(whichUnit, UNIT_STATE_MANA, BJ.RMaxBJ(0, newValue))
-- end

-- --===========================================================================
-- function BJ.SetUnitLifePercentBJ(whichUnit, percent)
-- 	CJ.SetUnitState(whichUnit, CJ.UNIT_STATE_LIFE, CJ.GetUnitState(whichUnit, UNIT_STATE_MAX_LIFE) * BJ.RMaxBJ(0, percent) * 0.01)
-- end

-- --===========================================================================
-- function BJ.SetUnitManaPercentBJ(whichUnit, percent)
-- 	CJ.SetUnitState(whichUnit, UNIT_STATE_MANA, CJ.GetUnitState(whichUnit, UNIT_STATE_MAX_MANA) * BJ.RMaxBJ(0, percent) * 0.01)
-- end

-- ===========================================================================
function BJ.IsUnitDeadBJ(whichUnit)
    return CJ.GetUnitState(whichUnit, CJ.UNIT_STATE_LIFE) <= 0.045
end

-- ===========================================================================
function BJ.IsUnitAliveBJ(whichUnit) return not BJ.IsUnitDeadBJ(whichUnit) end

-- --===========================================================================
-- function BJ.IsUnitGroupDeadBJEnum()
-- 	if not BJ.IsUnitDeadBJ(CJ.GetEnumUnit()) then
-- 		bj_isUnitGroupDeadResult = false
-- 	end
-- end

-- --===========================================================================
-- -- Returns true if every unit of the group is dead.
-- --
-- function BJ.IsUnitGroupDeadBJ(g)
-- 	-- If the user wants the group destroyed, remember that fact and clear
-- 	-- the flag, in case it is used again in the callback.
-- 	local wantDestroy = BJ.bj_wantDestroyGroup
-- 	BJ.bj_wantDestroyGroup = false

-- 	bj_isUnitGroupDeadResult = true
-- 	CJ.ForGroup(g, IsUnitGroupDeadBJEnum)

-- 	-- If the user wants the group destroyed, do so now.
-- 	if wantDestroy then
-- 		CJ.DestroyGroup(g)
-- 	end
-- 	return bj_isUnitGroupDeadResult
-- end

-- --===========================================================================
-- function BJ.IsUnitGroupEmptyBJEnum()
-- 	bj_isUnitGroupEmptyResult = false
-- end

-- --===========================================================================
-- -- Returns true if the group contains no units.
-- --
-- function BJ.IsUnitGroupEmptyBJ(g)
-- 	-- If the user wants the group destroyed, remember that fact and clear
-- 	-- the flag, in case it is used again in the callback.
-- 	local wantDestroy = BJ.bj_wantDestroyGroup
-- 	BJ.bj_wantDestroyGroup = false

-- 	bj_isUnitGroupEmptyResult = true
-- 	CJ.ForGroup(g, IsUnitGroupEmptyBJEnum)

-- 	-- If the user wants the group destroyed, do so now.
-- 	if wantDestroy then
-- 		CJ.DestroyGroup(g)
-- 	end
-- 	return bj_isUnitGroupEmptyResult
-- end

-- --===========================================================================
-- function BJ.IsUnitGroupInRectBJEnum()
-- 	if not RectContainsUnit(bj_isUnitGroupInRectRect, CJ.GetEnumUnit()) then
-- 		bj_isUnitGroupInRectResult = false
-- 	end
-- end

-- --===========================================================================
-- -- Returns true if every unit of the group is within the given rect.
-- --
-- function BJ.IsUnitGroupInRectBJ(g, r)
-- 	bj_isUnitGroupInRectResult = true
-- 	bj_isUnitGroupInRectRect = r
-- 	CJ.ForGroup(g, IsUnitGroupInRectBJEnum)
-- 	return bj_isUnitGroupInRectResult
-- end

-- --===========================================================================
-- function BJ.IsUnitHiddenBJ(whichUnit)
-- 	return CJ.IsUnitHidden(whichUnit)
-- end

-- --===========================================================================
-- function BJ.ShowUnitHide(whichUnit)
-- 	ShowUnit(whichUnit, false)
-- end

-- --===========================================================================
-- function BJ.ShowUnitShow(whichUnit)
-- 	-- Prevent dead heroes from being unhidden.
-- 	if CJ.IsUnitType(whichUnit, CJ.UNIT_TYPE_HERO) and BJ.IsUnitDeadBJ(whichUnit) then
-- 		return
-- 	end

-- 	ShowUnit(whichUnit, true)
-- end

-- ===========================================================================
function BJ.IssueHauntOrderAtLocBJFilter()
    return CJ.GetUnitTypeId(CJ.GetFilterUnit()) == 1852272492
end

-- --===========================================================================
-- function BJ.IssueHauntOrderAtLocBJ(whichPeon, loc)
-- 	local g = nil
-- 	local goldMine = nil

-- 	-- Search for a gold mine within a 1-cell radius of the specified location.
-- 	g = CJ.CreateGroup()
-- 	CJ.GroupEnumUnitsInRangeOfLoc(g, loc, 2 * bj_CELLWIDTH, BJ.filterIssueHauntOrderAtLocBJ)
-- 	goldMine = FirstOfGroup(g)
-- 	CJ.DestroyGroup(g)

-- 	-- If no mine was found, abort the request.
-- 	if goldMine == nil then
-- 		return false
-- 	end

-- 	-- Issue the Haunt Gold Mine order.
-- 	return IssueTargetOrderById(whichPeon, 1969713004, goldMine)
-- end

-- --===========================================================================
-- function BJ.IssueBuildOrderByIdLocBJ(whichPeon, unitId, loc)
-- 	if unitId == 1969713004 then
-- 		return IssueHauntOrderAtLocBJ(whichPeon, loc)
-- 	else
-- 		return IssueBuildOrderById(whichPeon, unitId, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- 	end
-- end

-- --===========================================================================
-- function BJ.IssueTrainOrderByIdBJ(whichUnit, unitId)
-- 	return IssueImmediateOrderById(whichUnit, unitId)
-- end

-- --===========================================================================
-- function BJ.GroupTrainOrderByIdBJ(g, unitId)
-- 	return GroupImmediateOrderById(g, unitId)
-- end

-- --===========================================================================
-- function BJ.IssueUpgradeOrderByIdBJ(whichUnit, techId)
-- 	return IssueImmediateOrderById(whichUnit, techId)
-- end

-- --===========================================================================
-- function BJ.GetAttackedUnitBJ()
-- 	return CJ.GetTriggerUnit()
-- end

-- --===========================================================================
-- function BJ.SetUnitFlyHeightBJ(whichUnit, newHeight, rate)
-- 	SetUnitFlyHeight(whichUnit, newHeight, rate)
-- end

-- --===========================================================================
-- function BJ.SetUnitTurnSpeedBJ(whichUnit, turnSpeed)
-- 	SetUnitTurnSpeed(whichUnit, turnSpeed)
-- end

-- --===========================================================================
-- function BJ.SetUnitPropWindowBJ(whichUnit, propWindow)
-- 	local angle = propWindow
-- 	if angle <= 0 then
-- 		angle = 1
-- 	elseif angle >= 360 then
-- 		angle = 359
-- 	end
-- 	angle = angle * BJ.bj_DEGTORAD

-- 	SetUnitPropWindow(whichUnit, angle)
-- end

-- --===========================================================================
-- function BJ.GetUnitPropWindowBJ(whichUnit)
-- 	return GetUnitPropWindow(whichUnit) * BJ.bj_RADTODEG
-- end

-- --===========================================================================
-- function BJ.GetUnitDefaultPropWindowBJ(whichUnit)
-- 	return GetUnitDefaultPropWindow(whichUnit)
-- end

-- --===========================================================================
-- function BJ.SetUnitBlendTimeBJ(whichUnit, blendTime)
-- 	CJ.SetUnitBlendTime(whichUnit, blendTime)
-- end

-- --===========================================================================
-- function BJ.SetUnitAcquireRangeBJ(whichUnit, acquireRange)
-- 	SetUnitAcquireRange(whichUnit, acquireRange)
-- end

-- --===========================================================================
-- function BJ.UnitSetCanSleepBJ(whichUnit, canSleep)
-- 	UnitAddSleep(whichUnit, canSleep)
-- end

-- --===========================================================================
-- function BJ.UnitCanSleepBJ(whichUnit)
-- 	return UnitCanSleep(whichUnit)
-- end

-- --===========================================================================
-- function BJ.UnitWakeUpBJ(whichUnit)
-- 	UnitWakeUp(whichUnit)
-- end

-- --===========================================================================
-- function BJ.UnitIsSleepingBJ(whichUnit)
-- 	return UnitIsSleeping(whichUnit)
-- end

-- --===========================================================================
-- function BJ.WakePlayerUnitsEnum()
-- 	UnitWakeUp(CJ.GetEnumUnit())
-- end

-- --===========================================================================
-- function BJ.WakePlayerUnits(whichPlayer)
-- 	local g = CJ.CreateGroup()
-- 	GroupEnumUnitsOfPlayer(g, whichPlayer, nil)
-- 	CJ.ForGroup(g, WakePlayerUnitsEnum)
-- 	CJ.DestroyGroup(g)
-- end

-- --===========================================================================
-- function BJ.EnableCreepSleepBJ(enable)
-- 	CJ.SetPlayerState(CJ.Player(CJ.PLAYER_NEUTRAL_AGGRESSIVE), PLAYER_STATE_NO_CREEP_SLEEP, IntegerTertiaryOp(enable, 0, 1))

-- 	-- If we're disabling, attempt to wake any already-sleeping creeps.
-- 	if not enable then
-- 		WakePlayerUnits(CJ.Player(CJ.PLAYER_NEUTRAL_AGGRESSIVE))
-- 	end
-- end

-- --===========================================================================
-- function BJ.UnitGenerateAlarms(whichUnit, generate)
-- 	return UnitIgnoreAlarm(whichUnit, not generate)
-- end

-- --===========================================================================
-- function BJ.DoesUnitGenerateAlarms(whichUnit)
-- 	return not UnitIgnoreAlarmToggled(whichUnit)
-- end

-- --===========================================================================
-- function BJ.PauseAllUnitsBJEnum()
-- 	PauseUnit(CJ.GetEnumUnit(), bj_pauseAllUnitsFlag)
-- end

-- --===========================================================================
-- -- Pause all units 
-- function BJ.PauseAllUnitsBJ(pause)
-- 	local index
-- 	local indexPlayer
-- 	local g

-- 	bj_pauseAllUnitsFlag = pause
-- 	g = CJ.CreateGroup()
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)

-- 		-- If this is a computer slot, pause/resume the AI.
-- 		if CJ.GetPlayerController(indexPlayer) == MAP_CONTROL_COMPUTER then
-- 			PauseCompAI(indexPlayer, pause)
-- 		end

-- 		-- Enumerate and unpause every unit owned by the player.
-- 		GroupEnumUnitsOfPlayer(g, indexPlayer, nil)
-- 		CJ.ForGroup(g, PauseAllUnitsBJEnum)
-- 		CJ.GroupClear(g)

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYER_SLOTS then break end
-- 	end
-- 	CJ.DestroyGroup(g)
-- end

-- --===========================================================================
-- function BJ.PauseUnitBJ(pause, whichUnit)
-- 	PauseUnit(whichUnit, pause)
-- end

-- --===========================================================================
-- function BJ.IsUnitPausedBJ(whichUnit)
-- 	return IsUnitPaused(whichUnit)
-- end

-- --===========================================================================
-- function BJ.UnitPauseTimedLifeBJ(flag, whichUnit)
-- 	UnitPauseTimedLife(whichUnit, flag)
-- end

-- --===========================================================================
-- function BJ.UnitApplyTimedLifeBJ(duration, buffId, whichUnit)
-- 	UnitApplyTimedLife(whichUnit, buffId, duration)
-- end

-- --===========================================================================
-- function BJ.UnitShareVisionBJ(share, whichUnit, whichPlayer)
-- 	UnitShareVision(whichUnit, whichPlayer, share)
-- end

-- --===========================================================================
-- function BJ.UnitRemoveBuffsBJ(buffType, whichUnit)
-- 	if buffType == bj_REMOVEBUFFS_POSITIVE then
-- 		UnitRemoveBuffs(whichUnit, true, false)
-- 	elseif buffType == bj_REMOVEBUFFS_NEGATIVE then
-- 		UnitRemoveBuffs(whichUnit, false, true)
-- 	elseif buffType == bj_REMOVEBUFFS_ALL then
-- 		UnitRemoveBuffs(whichUnit, true, true)
-- 	elseif buffType == bj_REMOVEBUFFS_NONTLIFE then
-- 		UnitRemoveBuffsEx(whichUnit, true, true, false, false, false, true, false)
-- 	else
-- 	-- Unrecognized dispel type - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.UnitRemoveBuffsExBJ(polarity, resist, whichUnit, bTLife, bAura)
-- 	local bPos = polarity == bj_BUFF_POLARITY_EITHER or polarity == bj_BUFF_POLARITY_POSITIVE
-- 	local bNeg = polarity == bj_BUFF_POLARITY_EITHER or polarity == bj_BUFF_POLARITY_NEGATIVE
-- 	local bMagic = resist == bj_BUFF_RESIST_BOTH or resist == bj_BUFF_RESIST_MAGIC
-- 	local bPhys = resist == bj_BUFF_RESIST_BOTH or resist == bj_BUFF_RESIST_PHYSICAL

-- 	UnitRemoveBuffsEx(whichUnit, bPos, bNeg, bMagic, bPhys, bTLife, bAura, false)
-- end

-- --===========================================================================
-- function BJ.UnitCountBuffsExBJ(polarity, resist, whichUnit, bTLife, bAura)
-- 	local bPos = polarity == bj_BUFF_POLARITY_EITHER or polarity == bj_BUFF_POLARITY_POSITIVE
-- 	local bNeg = polarity == bj_BUFF_POLARITY_EITHER or polarity == bj_BUFF_POLARITY_NEGATIVE
-- 	local bMagic = resist == bj_BUFF_RESIST_BOTH or resist == bj_BUFF_RESIST_MAGIC
-- 	local bPhys = resist == bj_BUFF_RESIST_BOTH or resist == bj_BUFF_RESIST_PHYSICAL

-- 	return UnitCountBuffsEx(whichUnit, bPos, bNeg, bMagic, bPhys, bTLife, bAura, false)
-- end

-- --===========================================================================
-- function BJ.UnitRemoveAbilityBJ(abilityId, whichUnit)
-- 	return UnitRemoveAbility(whichUnit, abilityId)
-- end

-- --===========================================================================
-- function BJ.UnitAddAbilityBJ(abilityId, whichUnit)
-- 	return UnitAddAbility(whichUnit, abilityId)
-- end

-- --===========================================================================
-- function BJ.UnitRemoveTypeBJ(whichType, whichUnit)
-- 	return UnitRemoveType(whichUnit, whichType)
-- end

-- --===========================================================================
-- function BJ.UnitAddTypeBJ(whichType, whichUnit)
-- 	return UnitAddType(whichUnit, whichType)
-- end

-- --===========================================================================
-- function BJ.UnitMakeAbilityPermanentBJ(permanent, abilityId, whichUnit)
-- 	return UnitMakeAbilityPermanent(whichUnit, permanent, abilityId)
-- end

-- --===========================================================================
-- function BJ.SetUnitExplodedBJ(whichUnit, exploded)
-- 	SetUnitExploded(whichUnit, exploded)
-- end

-- --===========================================================================
-- function BJ.ExplodeUnitBJ(whichUnit)
-- 	SetUnitExploded(whichUnit, true)
-- 	KillUnit(whichUnit)
-- end

-- --===========================================================================
-- function BJ.GetTransportUnitBJ()
-- 	return GetTransportUnit()
-- end

-- --===========================================================================
-- function BJ.GetLoadedUnitBJ()
-- 	return GetLoadedUnit()
-- end

-- --===========================================================================
-- function BJ.IsUnitInTransportBJ(whichUnit, whichTransport)
-- 	return IsUnitInTransport(whichUnit, whichTransport)
-- end

-- --===========================================================================
-- function BJ.IsUnitLoadedBJ(whichUnit)
-- 	return IsUnitLoaded(whichUnit)
-- end

-- --===========================================================================
-- function BJ.IsUnitIllusionBJ(whichUnit)
-- 	return IsUnitIllusion(whichUnit)
-- end

-- --===========================================================================
-- -- This attempts to replace a unit with a new unit type by creating a new
-- -- unit of the desired type using the old unit's location, facing, etc.
-- --
-- function BJ.ReplaceUnitBJ(whichUnit, newUnitId, unitStateMethod)
-- 	local oldUnit = whichUnit
-- 	local newUnit
-- 	local wasHidden
-- 	local index
-- 	local indexItem
-- 	local oldRatio

-- 	-- If we have bogus data, don't attempt the replace.
-- 	if oldUnit == nil then
-- 		bj_lastReplacedUnit = oldUnit
-- 		return oldUnit
-- 	end

-- 	-- Hide the original unit.
-- 	wasHidden = CJ.IsUnitHidden(oldUnit)
-- 	ShowUnit(oldUnit, false)

-- 	-- Create the replacement unit.
-- 	if newUnitId == 1969713004 then
-- 		newUnit = CJ.CreateBlightedGoldmine(CJ.GetOwningPlayer(oldUnit), CJ.GetUnitX(oldUnit), CJ.GetUnitY(oldUnit), GetUnitFacing(oldUnit))
-- 	else
-- 		newUnit = CreateUnit(CJ.GetOwningPlayer(oldUnit), newUnitId, CJ.GetUnitX(oldUnit), CJ.GetUnitY(oldUnit), GetUnitFacing(oldUnit))
-- 	end

-- 	-- Set the unit's life and mana according to the requested method.
-- 	if unitStateMethod == bj_UNIT_STATE_METHOD_RELATIVE then
-- 		-- Set the replacement's current/max life ratio to that of the old unit.
-- 		-- If both units have mana, do the same for mana.
-- 		if CJ.GetUnitState(oldUnit, UNIT_STATE_MAX_LIFE) > 0 then
-- 			oldRatio = CJ.GetUnitState(oldUnit, CJ.UNIT_STATE_LIFE) / CJ.GetUnitState(oldUnit, UNIT_STATE_MAX_LIFE)
-- 			CJ.SetUnitState(newUnit, CJ.UNIT_STATE_LIFE, oldRatio * CJ.GetUnitState(newUnit, UNIT_STATE_MAX_LIFE))
-- 		end

-- 		if CJ.GetUnitState(oldUnit, UNIT_STATE_MAX_MANA) > 0 and CJ.GetUnitState(newUnit, UNIT_STATE_MAX_MANA) > 0 then
-- 			oldRatio = CJ.GetUnitState(oldUnit, UNIT_STATE_MANA) / CJ.GetUnitState(oldUnit, UNIT_STATE_MAX_MANA)
-- 			CJ.SetUnitState(newUnit, UNIT_STATE_MANA, oldRatio * CJ.GetUnitState(newUnit, UNIT_STATE_MAX_MANA))
-- 		end
-- 	elseif unitStateMethod == bj_UNIT_STATE_METHOD_ABSOLUTE then
-- 		-- Set the replacement's current life to that of the old unit.
-- 		-- If the new unit has mana, do the same for mana.
-- 		CJ.SetUnitState(newUnit, CJ.UNIT_STATE_LIFE, CJ.GetUnitState(oldUnit, CJ.UNIT_STATE_LIFE))
-- 		if CJ.GetUnitState(newUnit, UNIT_STATE_MAX_MANA) > 0 then
-- 			CJ.SetUnitState(newUnit, UNIT_STATE_MANA, CJ.GetUnitState(oldUnit, UNIT_STATE_MANA))
-- 		end
-- 	elseif unitStateMethod == bj_UNIT_STATE_METHOD_DEFAULTS then
-- 	-- The newly created unit should already have default life and mana.
-- 	elseif unitStateMethod == bj_UNIT_STATE_METHOD_MAXIMUM then
-- 		-- Use max life and mana.
-- 		CJ.SetUnitState(newUnit, CJ.UNIT_STATE_LIFE, CJ.GetUnitState(newUnit, UNIT_STATE_MAX_LIFE))
-- 		CJ.SetUnitState(newUnit, UNIT_STATE_MANA, CJ.GetUnitState(newUnit, UNIT_STATE_MAX_MANA))
-- 	else
-- 	-- Unrecognized unit state method - ignore the request.
-- 	end

-- 	-- Mirror properties of the old unit onto the new unit.
-- 	--call PauseUnit(newUnit, IsUnitPaused(oldUnit))
-- 	SetResourceAmount(newUnit, GetResourceAmount(oldUnit))

-- 	-- If both the old and new units are heroes, handle their hero info.
-- 	if CJ.IsUnitType(oldUnit, CJ.UNIT_TYPE_HERO) and CJ.IsUnitType(newUnit, CJ.UNIT_TYPE_HERO) then
-- 		SetHeroXP(newUnit, GetHeroXP(oldUnit), false)

-- 		index = 0
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			indexItem = UnitItemInSlot(oldUnit, index)
-- 			if indexItem ~= nil then
-- 				UnitRemoveItem(oldUnit, indexItem)
-- 				UnitAddItem(newUnit, indexItem)
-- 			end

-- 			index = index + 1
-- 			if index >= bj_MAX_INVENTORY then break end
-- 		end
-- 	end

-- 	-- Remove or kill the original unit.  It is sometimes unsafe to remove
-- 	-- hidden units, so kill the original unit if it was previously hidden.
-- 	if wasHidden then
-- 		KillUnit(oldUnit)
-- 		RemoveUnit(oldUnit)
-- 	else
-- 		RemoveUnit(oldUnit)
-- 	end

-- 	bj_lastReplacedUnit = newUnit
-- 	return newUnit
-- end

-- --===========================================================================
-- function BJ.GetLastReplacedUnitBJ()
-- 	return bj_lastReplacedUnit
-- end

-- --===========================================================================
-- function BJ.SetUnitPositionLocFacingBJ(whichUnit, loc, facing)
-- 	CJ.SetUnitPositionLoc(whichUnit, loc)
-- 	CJ.SetUnitFacing(whichUnit, facing)
-- end

-- --===========================================================================
-- function BJ.SetUnitPositionLocFacingLocBJ(whichUnit, loc, lookAt)
-- 	CJ.SetUnitPositionLoc(whichUnit, loc)
-- 	CJ.SetUnitFacing(whichUnit, BJ.AngleBetweenPoints(loc, lookAt))
-- end

-- --===========================================================================
-- function BJ.AddItemToStockBJ(itemId, whichUnit, currentStock, stockMax)
-- 	CJ.AddItemToStock(whichUnit, itemId, currentStock, stockMax)
-- end

-- --===========================================================================
-- function BJ.AddUnitToStockBJ(unitId, whichUnit, currentStock, stockMax)
-- 	AddUnitToStock(whichUnit, unitId, currentStock, stockMax)
-- end

-- --===========================================================================
-- function BJ.RemoveItemFromStockBJ(itemId, whichUnit)
-- 	CJ.RemoveItemFromStock(whichUnit, itemId)
-- end

-- --===========================================================================
-- function BJ.RemoveUnitFromStockBJ(unitId, whichUnit)
-- 	RemoveUnitFromStock(whichUnit, unitId)
-- end

-- --===========================================================================
-- function BJ.SetUnitUseFoodBJ(enable, whichUnit)
-- 	SetUnitUseFood(whichUnit, enable)
-- end

-- ===========================================================================
function BJ.UnitDamagePointLoc(whichUnit, delay, radius, loc, amount,
                               whichAttack, whichDamage)
    return CJ.UnitDamagePoint(whichUnit, delay, radius, CJ.GetLocationX(loc),
                              CJ.GetLocationY(loc), amount, true, false,
                              whichAttack, whichDamage, CJ.WEAPON_TYPE_WHOKNOWS)
end

-- ===========================================================================
function BJ.UnitDamageTargetBJ(whichUnit, target, amount, whichAttack,
                               whichDamage)
    return CJ.UnitDamageTarget(whichUnit, target, amount, true, false,
                               whichAttack, whichDamage, CJ.WEAPON_TYPE_WHOKNOWS)
end

-- --***************************************************************************
-- --*
-- --*  Destructable Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.CreateDestructableLoc(objectid, loc, facing, scale, variation)
-- 	bj_lastCreatedDestructable = CreateDestructable(objectid, CJ.GetLocationX(loc), CJ.GetLocationY(loc), facing, scale, variation)
-- 	return bj_lastCreatedDestructable
-- end

-- --===========================================================================
-- function BJ.CreateDeadDestructableLocBJ(objectid, loc, facing, scale, variation)
-- 	bj_lastCreatedDestructable = CreateDeadDestructable(objectid, CJ.GetLocationX(loc), CJ.GetLocationY(loc), facing, scale, variation)
-- 	return bj_lastCreatedDestructable
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedDestructable()
-- 	return bj_lastCreatedDestructable
-- end

-- --===========================================================================
-- function BJ.ShowDestructableBJ(flag, d)
-- 	ShowDestructable(d, flag)
-- end

-- --===========================================================================
-- function BJ.SetDestructableInvulnerableBJ(d, flag)
-- 	SetDestructableInvulnerable(d, flag)
-- end

-- --===========================================================================
-- function BJ.IsDestructableInvulnerableBJ(d)
-- 	return IsDestructableInvulnerable(d)
-- end

-- ===========================================================================
function BJ.GetDestructableLoc(whichDestructable)
    return CJ.Location(CJ.GetDestructableX(whichDestructable),
                       CJ.GetDestructableY(whichDestructable))
end

-- --===========================================================================
-- function BJ.EnumDestructablesInRectAll(r, actionFunc)
-- 	EnumDestructablesInRect(r, nil, actionFunc)
-- end

-- ===========================================================================
function BJ.EnumDestructablesInCircleBJFilter()
    local destLoc = BJ.GetDestructableLoc(CJ.GetFilterDestructable())
    local result

    result = BJ.DistanceBetweenPoints(destLoc, BJ.bj_enumDestructableCenter) <=
                 BJ.bj_enumDestructableRadius
    CJ.RemoveLocation(destLoc)
    return result
end

-- --===========================================================================
-- function BJ.IsDestructableDeadBJ(d)
-- 	return GetDestructableLife(d) <= 0
-- end

-- --===========================================================================
-- function BJ.IsDestructableAliveBJ(d)
-- 	return not IsDestructableDeadBJ(d)
-- end

-- --===========================================================================
-- -- See GroupPickRandomUnitEnum for the details of this algorithm.
-- --
-- function BJ.RandomDestructableInRectBJEnum()
-- 	bj_destRandomConsidered = bj_destRandomConsidered + 1
-- 	if CJ.GetRandomInt(1, bj_destRandomConsidered) == 1 then
-- 		bj_destRandomCurrentPick = GetEnumDestructable()
-- 	end
-- end

-- --===========================================================================
-- -- Picks a random destructable from within a rect, matching a condition
-- --
-- function BJ.RandomDestructableInRectBJ(r, filter)
-- 	bj_destRandomConsidered = 0
-- 	bj_destRandomCurrentPick = nil
-- 	EnumDestructablesInRect(r, filter, RandomDestructableInRectBJEnum)
-- 	CJ.DestroyBoolExpr(filter)
-- 	return bj_destRandomCurrentPick
-- end

-- --===========================================================================
-- -- Picks a random destructable from within a rect
-- --
-- function BJ.RandomDestructableInRectSimpleBJ(r)
-- 	return RandomDestructableInRectBJ(r, nil)
-- end

-- --===========================================================================
-- -- Enumerates within a rect, with a filter to narrow the enumeration down
-- -- objects within a circular area.
-- --
-- function BJ.EnumDestructablesInCircleBJ(radius, loc, actionFunc)
-- 	local r

-- 	if radius >= 0 then
-- 		BJ.bj_enumDestructableCenter = loc
-- 		BJ.bj_enumDestructableRadius = radius
-- 		r = GetRectFromCircleBJ(loc, radius)
-- 		EnumDestructablesInRect(r, BJ.filterEnumDestructablesInCircleBJ, actionFunc)
-- 		RemoveRect(r)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetDestructableLifePercentBJ(d, percent)
-- 	SetDestructableLife(d, GetDestructableMaxLife(d) * percent * 0.01)
-- end

-- --===========================================================================
-- function BJ.SetDestructableMaxLifeBJ(d, max)
-- 	SetDestructableMaxLife(d, max)
-- end

-- --===========================================================================
-- function BJ.ModifyGateBJ(gateOperation, d)
-- 	if gateOperation == bj_GATEOPERATION_CLOSE then
-- 		if GetDestructableLife(d) <= 0 then
-- 			DestructableRestoreLife(d, GetDestructableMaxLife(d), true)
-- 		end
-- 		SetDestructableAnimation(d, "stand")
-- 	elseif gateOperation == bj_GATEOPERATION_OPEN then
-- 		if GetDestructableLife(d) > 0 then
-- 			KillDestructable(d)
-- 		end
-- 		SetDestructableAnimation(d, "death alternate")
-- 	elseif gateOperation == bj_GATEOPERATION_DESTROY then
-- 		if GetDestructableLife(d) > 0 then
-- 			KillDestructable(d)
-- 		end
-- 		SetDestructableAnimation(d, "death")
-- 	else
-- 	-- Unrecognized gate state - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- -- Determine the elevator's height from its occlusion height.
-- --
-- function BJ.GetElevatorHeight(d)
-- 	local height

-- 	height = 1 + CJ.R2I(GetDestructableOccluderHeight(d) / bj_CLIFFHEIGHT)
-- 	if height < 1 or height > 3 then
-- 		height = 1
-- 	end
-- 	return height
-- end

-- --===========================================================================
-- -- To properly animate an elevator, we must know not only what height we
-- -- want to change to, but also what height we are currently at.  This code
-- -- determines the elevator's current height from its occlusion height.
-- -- Arbitrarily changing an elevator's occlusion height is thus inadvisable.
-- --
-- function BJ.ChangeElevatorHeight(d, newHeight)
-- 	local oldHeight

-- 	-- Cap the new height within the supported range.
-- 	newHeight = IMaxBJ(1, newHeight)
-- 	newHeight = IMinBJ(3, newHeight)

-- 	-- Find out what height the elevator is already at.
-- 	oldHeight = GetElevatorHeight(d)

-- 	-- Set the elevator's occlusion height.
-- 	SetDestructableOccluderHeight(d, bj_CLIFFHEIGHT * (newHeight - 1))

-- 	if newHeight == 1 then
-- 		if oldHeight == 2 then
-- 			SetDestructableAnimation(d, "birth")
-- 			QueueDestructableAnimation(d, "stand")
-- 		elseif oldHeight == 3 then
-- 			SetDestructableAnimation(d, "birth third")
-- 			QueueDestructableAnimation(d, "stand")
-- 		else
-- 			-- Unrecognized old height - snap to new height.
-- 			SetDestructableAnimation(d, "stand")
-- 		end
-- 	elseif newHeight == 2 then
-- 		if oldHeight == 1 then
-- 			SetDestructableAnimation(d, "death")
-- 			QueueDestructableAnimation(d, "stand second")
-- 		elseif oldHeight == 3 then
-- 			SetDestructableAnimation(d, "birth second")
-- 			QueueDestructableAnimation(d, "stand second")
-- 		else
-- 			-- Unrecognized old height - snap to new height.
-- 			SetDestructableAnimation(d, "stand second")
-- 		end
-- 	elseif newHeight == 3 then
-- 		if oldHeight == 1 then
-- 			SetDestructableAnimation(d, "death third")
-- 			QueueDestructableAnimation(d, "stand third")
-- 		elseif oldHeight == 2 then
-- 			SetDestructableAnimation(d, "death second")
-- 			QueueDestructableAnimation(d, "stand third")
-- 		else
-- 			-- Unrecognized old height - snap to new height.
-- 			SetDestructableAnimation(d, "stand third")
-- 		end
-- 	else
-- 	-- Unrecognized new height - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- -- Grab the unit and throw his own coords in his face, forcing him to push
-- -- and shove until he finds a spot where noone will bother him.
-- --
-- function BJ.NudgeUnitsInRectEnum()
-- 	local nudgee = CJ.GetEnumUnit()

-- 	CJ.SetUnitPosition(nudgee, CJ.GetUnitX(nudgee), CJ.GetUnitY(nudgee))
-- end

-- --===========================================================================
-- function BJ.NudgeItemsInRectEnum()
-- 	local nudgee = GetEnumItem()

-- 	SetItemPosition(nudgee, GetItemX(nudgee), GetItemY(nudgee))
-- end

-- --===========================================================================
-- -- Nudge the items and units within a given rect ever so gently, so as to
-- -- encourage them to find locations where they can peacefully coexist with
-- -- pathing restrictions and live happy, fruitful lives.
-- --
-- function BJ.NudgeObjectsInRect(nudgeArea)
-- 	local g

-- 	g = CJ.CreateGroup()
-- 	GroupEnumUnitsInRect(g, nudgeArea, nil)
-- 	CJ.ForGroup(g, NudgeUnitsInRectEnum)
-- 	CJ.DestroyGroup(g)

-- 	EnumItemsInRect(nudgeArea, nil, NudgeItemsInRectEnum)
-- end

-- --===========================================================================
-- function BJ.NearbyElevatorExistsEnum()
-- 	local d = GetEnumDestructable()
-- 	local dType = GetDestructableTypeId(d)

-- 	if dType == bj_ELEVATOR_CODE01 or dType == bj_ELEVATOR_CODE02 then
-- 		bj_elevatorNeighbor = d
-- 	end
-- end

-- --===========================================================================
-- function BJ.NearbyElevatorExists(x, y)
-- 	local findThreshold = 32
-- 	local r

-- 	-- If another elevator is overlapping this one, ignore the wall.
-- 	r = CJ.Rect(x - findThreshold, y - findThreshold, x + findThreshold, y + findThreshold)
-- 	bj_elevatorNeighbor = nil
-- 	EnumDestructablesInRect(r, nil, NearbyElevatorExistsEnum)
-- 	RemoveRect(r)

-- 	return bj_elevatorNeighbor ~= nil
-- end

-- --===========================================================================
-- function BJ.FindElevatorWallBlockerEnum()
-- 	bj_elevatorWallBlocker = GetEnumDestructable()
-- end

-- --===========================================================================
-- -- This toggles pathing on or off for one wall of an elevator by killing
-- -- or reviving a pathing blocker at the appropriate location (and creating
-- -- the pathing blocker in the first place, if it does not yet exist).
-- --
-- function BJ.ChangeElevatorWallBlocker(x, y, facing, open)
-- 	local blocker = nil
-- 	local findThreshold = 32
-- 	local nudgeLength = 4.25 * bj_CELLWIDTH
-- 	local nudgeWidth = 1.25 * bj_CELLWIDTH
-- 	local r

-- 	-- Search for the pathing blocker within the general area.
-- 	r = CJ.Rect(x - findThreshold, y - findThreshold, x + findThreshold, y + findThreshold)
-- 	bj_elevatorWallBlocker = nil
-- 	EnumDestructablesInRect(r, nil, FindElevatorWallBlockerEnum)
-- 	RemoveRect(r)
-- 	blocker = bj_elevatorWallBlocker

-- 	-- Ensure that the blocker exists.
-- 	if blocker == nil then
-- 		blocker = CreateDeadDestructable(bj_ELEVATOR_BLOCKER_CODE, x, y, facing, 1, 0)
-- 	elseif GetDestructableTypeId(blocker) ~= bj_ELEVATOR_BLOCKER_CODE then
-- 		-- If a different destructible exists in the blocker's spot, ignore
-- 		-- the request.  (Two destructibles cannot occupy the same location
-- 		-- on the map, so we cannot create an elevator blocker here.)
-- 		return
-- 	end

-- 	if open then
-- 		-- Ensure that the blocker is dead.
-- 		if GetDestructableLife(blocker) > 0 then
-- 			KillDestructable(blocker)
-- 		end
-- 	else
-- 		-- Ensure that the blocker is alive.
-- 		if GetDestructableLife(blocker) <= 0 then
-- 			DestructableRestoreLife(blocker, GetDestructableMaxLife(blocker), false)
-- 		end

-- 		-- Nudge any objects standing in the blocker's way.
-- 		if facing == 0 then
-- 			r = CJ.Rect(x - nudgeWidth / 2, y - nudgeLength / 2, x + nudgeWidth / 2, y + nudgeLength / 2)
-- 			NudgeObjectsInRect(r)
-- 			RemoveRect(r)
-- 		elseif facing == 90 then
-- 			r = CJ.Rect(x - nudgeLength / 2, y - nudgeWidth / 2, x + nudgeLength / 2, y + nudgeWidth / 2)
-- 			NudgeObjectsInRect(r)
-- 			RemoveRect(r)
-- 		else
-- 		-- Unrecognized blocker angle - don't nudge anything.
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.ChangeElevatorWalls(open, walls, d)
-- 	local x = CJ.GetDestructableX(d)
-- 	local y = CJ.GetDestructableY(d)
-- 	local distToBlocker = 192
-- 	local distToNeighbor = 256

-- 	if walls == bj_ELEVATOR_WALL_TYPE_ALL or walls == bj_ELEVATOR_WALL_TYPE_EAST then
-- 		if not NearbyElevatorExists(x + distToNeighbor, y) then
-- 			ChangeElevatorWallBlocker(x + distToBlocker, y, 0, open)
-- 		end
-- 	end

-- 	if walls == bj_ELEVATOR_WALL_TYPE_ALL or walls == bj_ELEVATOR_WALL_TYPE_NORTH then
-- 		if not NearbyElevatorExists(x, y + distToNeighbor) then
-- 			ChangeElevatorWallBlocker(x, y + distToBlocker, 90, open)
-- 		end
-- 	end

-- 	if walls == bj_ELEVATOR_WALL_TYPE_ALL or walls == bj_ELEVATOR_WALL_TYPE_SOUTH then
-- 		if not NearbyElevatorExists(x, y - distToNeighbor) then
-- 			ChangeElevatorWallBlocker(x, y - distToBlocker, 90, open)
-- 		end
-- 	end

-- 	if walls == bj_ELEVATOR_WALL_TYPE_ALL or walls == bj_ELEVATOR_WALL_TYPE_WEST then
-- 		if not NearbyElevatorExists(x - distToNeighbor, y) then
-- 			ChangeElevatorWallBlocker(x - distToBlocker, y, 0, open)
-- 		end
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Neutral Building Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.WaygateActivateBJ(activate, waygate)
-- 	WaygateActivate(waygate, activate)
-- end

-- --===========================================================================
-- function BJ.WaygateIsActiveBJ(waygate)
-- 	return WaygateIsActive(waygate)
-- end

-- --===========================================================================
-- function BJ.WaygateSetDestinationLocBJ(waygate, loc)
-- 	WaygateSetDestination(waygate, CJ.GetLocationX(loc), CJ.GetLocationY(loc))
-- end

-- --===========================================================================
-- function BJ.WaygateGetDestinationLocBJ(waygate)
-- 	return CJ.Location(WaygateGetDestinationX(waygate), WaygateGetDestinationY(waygate))
-- end

-- --===========================================================================
-- function BJ.UnitSetUsesAltIconBJ(flag, whichUnit)
-- 	UnitSetUsesAltIcon(whichUnit, flag)
-- end

-- --***************************************************************************
-- --*
-- --*  UI Utility Functions
-- --*
-- --***************************************************************************

--===========================================================================
function BJ.ForceUIKeyBJ(whichPlayer, key)
	if CJ.GetLocalPlayer() == whichPlayer then
		-- Use only local code (no net traffic) within this block to avoid desyncs.
		CJ.ForceUIKey(key)
	end
end

--===========================================================================
function BJ.ForceUICancelBJ(whichPlayer)
	if CJ.GetLocalPlayer() == whichPlayer then
		-- Use only local code (no net traffic) within this block to avoid desyncs.
		CJ.ForceUICancel()
	end
end

-- --***************************************************************************
-- --*
-- --*  Group and Force Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
function BJ.ForGroupBJ(whichGroup, callback)
    -- If the user wants the group destroyed, remember that fact and clear
    -- the flag, in case it is used again in the callback.
    local wantDestroy = BJ.bj_wantDestroyGroup
    BJ.bj_wantDestroyGroup = false

    CJ.ForGroup(whichGroup, callback)

    -- If the user wants the group destroyed, do so now.
    if wantDestroy then CJ.DestroyGroup(whichGroup) end
end

-- --===========================================================================
-- function BJ.GroupAddUnitSimple(whichUnit, whichGroup)
-- 	CJ.GroupAddUnit(whichGroup, whichUnit)
-- end

-- --===========================================================================
-- function BJ.GroupRemoveUnitSimple(whichUnit, whichGroup)
-- 	GroupRemoveUnit(whichGroup, whichUnit)
-- end

-- --===========================================================================
-- function BJ.GroupAddGroupEnum()
-- 	CJ.GroupAddUnit(bj_groupAddGroupDest, CJ.GetEnumUnit())
-- end

-- --===========================================================================
-- function BJ.GroupAddGroup(sourceGroup, destGroup)
-- 	-- If the user wants the group destroyed, remember that fact and clear
-- 	-- the flag, in case it is used again in the callback.
-- 	local wantDestroy = BJ.bj_wantDestroyGroup
-- 	BJ.bj_wantDestroyGroup = false

-- 	bj_groupAddGroupDest = destGroup
-- 	CJ.ForGroup(sourceGroup, GroupAddGroupEnum)

-- 	-- If the user wants the group destroyed, do so now.
-- 	if wantDestroy then
-- 		CJ.DestroyGroup(sourceGroup)
-- 	end
-- end

-- --===========================================================================
-- function BJ.GroupRemoveGroupEnum()
-- 	GroupRemoveUnit(bj_groupRemoveGroupDest, CJ.GetEnumUnit())
-- end

-- --===========================================================================
-- function BJ.GroupRemoveGroup(sourceGroup, destGroup)
-- 	-- If the user wants the group destroyed, remember that fact and clear
-- 	-- the flag, in case it is used again in the callback.
-- 	local wantDestroy = BJ.bj_wantDestroyGroup
-- 	BJ.bj_wantDestroyGroup = false

-- 	bj_groupRemoveGroupDest = destGroup
-- 	CJ.ForGroup(sourceGroup, GroupRemoveGroupEnum)

-- 	-- If the user wants the group destroyed, do so now.
-- 	if wantDestroy then
-- 		CJ.DestroyGroup(sourceGroup)
-- 	end
-- end

-- --===========================================================================
-- function BJ.ForceAddPlayerSimple(whichPlayer, whichForce)
-- 	CJ.ForceAddPlayer(whichForce, whichPlayer)
-- end

-- --===========================================================================
-- function BJ.ForceRemovePlayerSimple(whichPlayer, whichForce)
-- 	ForceRemovePlayer(whichForce, whichPlayer)
-- end

-- --===========================================================================
-- -- Consider each unit, one at a time, keeping a "current pick".   Once all units
-- -- are considered, this "current pick" will be the resulting random unit.
-- --
-- -- The chance of picking a given unit over the "current pick" is 1/N, where N is
-- -- the number of units considered thusfar (including the current consideration).
-- --
-- function BJ.GroupPickRandomUnitEnum()
-- 	bj_groupRandomConsidered = bj_groupRandomConsidered + 1
-- 	if CJ.GetRandomInt(1, bj_groupRandomConsidered) == 1 then
-- 		bj_groupRandomCurrentPick = CJ.GetEnumUnit()
-- 	end
-- end

-- --===========================================================================
-- -- Picks a random unit from a group.
-- --
-- function BJ.GroupPickRandomUnit(whichGroup)
-- 	-- If the user wants the group destroyed, remember that fact and clear
-- 	-- the flag, in case it is used again in the callback.
-- 	local wantDestroy = BJ.bj_wantDestroyGroup
-- 	BJ.bj_wantDestroyGroup = false

-- 	bj_groupRandomConsidered = 0
-- 	bj_groupRandomCurrentPick = nil
-- 	CJ.ForGroup(whichGroup, GroupPickRandomUnitEnum)

-- 	-- If the user wants the group destroyed, do so now.
-- 	if wantDestroy then
-- 		CJ.DestroyGroup(whichGroup)
-- 	end
-- 	return bj_groupRandomCurrentPick
-- end

-- --===========================================================================
-- -- See GroupPickRandomUnitEnum for the details of this algorithm.
-- --
-- function BJ.ForcePickRandomPlayerEnum()
-- 	bj_forceRandomConsidered = bj_forceRandomConsidered + 1
-- 	if CJ.GetRandomInt(1, bj_forceRandomConsidered) == 1 then
-- 		bj_forceRandomCurrentPick = GetEnumPlayer()
-- 	end
-- end

-- --===========================================================================
-- -- Picks a random player from a force.
-- --
-- function BJ.ForcePickRandomPlayer(whichForce)
-- 	bj_forceRandomConsidered = 0
-- 	bj_forceRandomCurrentPick = nil
-- 	ForForce(whichForce, ForcePickRandomPlayerEnum)
-- 	return bj_forceRandomCurrentPick
-- end

-- --===========================================================================
-- function BJ.EnumUnitsSelected(whichPlayer, enumFilter, enumAction)
-- 	local g = CJ.CreateGroup()
-- 	SyncSelections()
-- 	GroupEnumUnitsSelected(g, whichPlayer, enumFilter)
-- 	CJ.DestroyBoolExpr(enumFilter)
-- 	CJ.ForGroup(g, enumAction)
-- 	CJ.DestroyGroup(g)
-- end

-- --===========================================================================
-- function BJ.GetUnitsInRectMatching(r, filter)
-- 	local g = CJ.CreateGroup()
-- 	GroupEnumUnitsInRect(g, r, filter)
-- 	CJ.DestroyBoolExpr(filter)
-- 	return g
-- end

-- --===========================================================================
-- function BJ.GetUnitsInRectAll(r)
-- 	return GetUnitsInRectMatching(r, nil)
-- end

-- ===========================================================================
function BJ.GetUnitsInRectOfPlayerFilter()
    return CJ.GetOwningPlayer(CJ.GetFilterUnit()) == BJ.bj_groupEnumOwningPlayer
end

-- --===========================================================================
-- function BJ.GetUnitsInRectOfPlayer(r, whichPlayer)
-- 	local g = CJ.CreateGroup()
-- 	BJ.bj_groupEnumOwningPlayer = whichPlayer
-- 	GroupEnumUnitsInRect(g, r, BJ.filterGetUnitsInRectOfPlayer)
-- 	return g
-- end

-- ===========================================================================
function BJ.GetUnitsInRangeOfLocMatching(radius, whichLocation, filter)
    local g = CJ.CreateGroup()
    CJ.GroupEnumUnitsInRangeOfLoc(g, whichLocation, radius, filter)
    CJ.DestroyBoolExpr(filter)
    return g
end

-- --===========================================================================
-- function BJ.GetUnitsInRangeOfLocAll(radius, whichLocation)
-- 	return GetUnitsInRangeOfLocMatching(radius, whichLocation, nil)
-- end

-- ===========================================================================
function BJ.GetUnitsOfTypeIdAllFilter()
    return CJ.GetUnitTypeId(CJ.GetFilterUnit()) == BJ.bj_groupEnumTypeId
end

-- --===========================================================================
-- function BJ.GetUnitsOfTypeIdAll(unitid)
-- 	local result = CJ.CreateGroup()
-- 	local g = CJ.CreateGroup()
-- 	local index

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		BJ.bj_groupEnumTypeId = unitid
-- 		CJ.GroupClear(g)
-- 		GroupEnumUnitsOfPlayer(g, CJ.Player(index), BJ.filterGetUnitsOfTypeIdAll)
-- 		GroupAddGroup(g, result)

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYER_SLOTS then break end
-- 	end
-- 	CJ.DestroyGroup(g)

-- 	return result
-- end

-- --===========================================================================
-- function BJ.GetUnitsOfPlayerMatching(whichPlayer, filter)
-- 	local g = CJ.CreateGroup()
-- 	GroupEnumUnitsOfPlayer(g, whichPlayer, filter)
-- 	CJ.DestroyBoolExpr(filter)
-- 	return g
-- end

-- --===========================================================================
-- function BJ.GetUnitsOfPlayerAll(whichPlayer)
-- 	return GetUnitsOfPlayerMatching(whichPlayer, nil)
-- end

-- ===========================================================================
function BJ.GetUnitsOfPlayerAndTypeIdFilter()
    return CJ.GetUnitTypeId(CJ.GetFilterUnit()) == BJ.bj_groupEnumTypeId
end

-- --===========================================================================
-- function BJ.GetUnitsOfPlayerAndTypeId(whichPlayer, unitid)
-- 	local g = CJ.CreateGroup()
-- 	BJ.bj_groupEnumTypeId = unitid
-- 	GroupEnumUnitsOfPlayer(g, whichPlayer, BJ.filterGetUnitsOfPlayerAndTypeId)
-- 	return g
-- end

-- --===========================================================================
-- function BJ.GetUnitsSelectedAll(whichPlayer)
-- 	local g = CJ.CreateGroup()
-- 	SyncSelections()
-- 	GroupEnumUnitsSelected(g, whichPlayer, nil)
-- 	return g
-- end

-- --===========================================================================
-- function BJ.GetForceOfPlayer(whichPlayer)
-- 	local f = CJ.CreateForce()
-- 	CJ.ForceAddPlayer(f, whichPlayer)
-- 	return f
-- end

-- ===========================================================================
function BJ.GetPlayersAll() return BJ.bj_FORCE_ALL_PLAYERS end

-- --===========================================================================
-- function BJ.GetPlayersByMapControl(whichControl)
-- 	local f = CJ.CreateForce()
-- 	local playerIndex
-- 	local indexPlayer

-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if CJ.GetPlayerController(indexPlayer) == whichControl then
-- 			CJ.ForceAddPlayer(f, indexPlayer)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYER_SLOTS then break end
-- 	end

-- 	return f
-- end

-- --===========================================================================
-- function BJ.GetPlayersAllies(whichPlayer)
-- 	local f = CJ.CreateForce()
-- 	ForceEnumAllies(f, whichPlayer, nil)
-- 	return f
-- end

-- --===========================================================================
-- function BJ.GetPlayersEnemies(whichPlayer)
-- 	local f = CJ.CreateForce()
-- 	ForceEnumEnemies(f, whichPlayer, nil)
-- 	return f
-- end

-- --===========================================================================
-- function BJ.GetPlayersMatching(filter)
-- 	local f = CJ.CreateForce()
-- 	CJ.ForceEnumPlayers(f, filter)
-- 	CJ.DestroyBoolExpr(filter)
-- 	return f
-- end

-- --===========================================================================
-- function BJ.CountUnitsInGroupEnum()
-- 	bj_groupCountUnits = bj_groupCountUnits + 1
-- end

-- --===========================================================================
-- function BJ.CountUnitsInGroup(g)
-- 	-- If the user wants the group destroyed, remember that fact and clear
-- 	-- the flag, in case it is used again in the callback.
-- 	local wantDestroy = BJ.bj_wantDestroyGroup
-- 	BJ.bj_wantDestroyGroup = false

-- 	bj_groupCountUnits = 0
-- 	CJ.ForGroup(g, CountUnitsInGroupEnum)

-- 	-- If the user wants the group destroyed, do so now.
-- 	if wantDestroy then
-- 		CJ.DestroyGroup(g)
-- 	end
-- 	return bj_groupCountUnits
-- end

-- --===========================================================================
-- function BJ.CountPlayersInForceEnum()
-- 	bj_forceCountPlayers = bj_forceCountPlayers + 1
-- end

-- --===========================================================================
-- function BJ.CountPlayersInForceBJ(f)
-- 	bj_forceCountPlayers = 0
-- 	ForForce(f, CountPlayersInForceEnum)
-- 	return bj_forceCountPlayers
-- end

-- --===========================================================================
-- function BJ.GetRandomSubGroupEnum()
-- 	if bj_randomSubGroupWant > 0 then
-- 		if bj_randomSubGroupWant >= bj_randomSubGroupTotal or CJ.GetRandomReal(0, 1) < bj_randomSubGroupChance then
-- 			-- We either need every remaining unit, or the unit passed its chance check.
-- 			CJ.GroupAddUnit(bj_randomSubGroupGroup, CJ.GetEnumUnit())
-- 			bj_randomSubGroupWant = bj_randomSubGroupWant - 1
-- 		end
-- 	end
-- 	bj_randomSubGroupTotal = bj_randomSubGroupTotal - 1
-- end

-- --===========================================================================
-- function BJ.GetRandomSubGroup(count, sourceGroup)
-- 	local g = CJ.CreateGroup()

-- 	bj_randomSubGroupGroup = g
-- 	bj_randomSubGroupWant = count
-- 	bj_randomSubGroupTotal = CountUnitsInGroup(sourceGroup)

-- 	if bj_randomSubGroupWant <= 0 or bj_randomSubGroupTotal <= 0 then
-- 		return g
-- 	end

-- 	bj_randomSubGroupChance = CJ.I2R(bj_randomSubGroupWant) / CJ.I2R(bj_randomSubGroupTotal)
-- 	CJ.ForGroup(sourceGroup, GetRandomSubGroupEnum)
-- 	return g
-- end

-- ===========================================================================
function BJ.LivingPlayerUnitsOfTypeIdFilter()
    local filterUnit = CJ.GetFilterUnit()
    return BJ.IsUnitAliveBJ(filterUnit) and CJ.GetUnitTypeId(filterUnit) ==
               BJ.bj_livingPlayerUnitsTypeId
end

-- --===========================================================================
-- function BJ.CountLivingPlayerUnitsOfTypeId(unitId, whichPlayer)
-- 	local g
-- 	local matchedCount

-- 	g = CJ.CreateGroup()
-- 	BJ.bj_livingPlayerUnitsTypeId = unitId
-- 	GroupEnumUnitsOfPlayer(g, whichPlayer, BJ.filterLivingPlayerUnitsOfTypeId)
-- 	matchedCount = CountUnitsInGroup(g)
-- 	CJ.DestroyGroup(g)

-- 	return matchedCount
-- end

-- --***************************************************************************
-- --*
-- --*  Animation Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.ResetUnitAnimation(whichUnit)
-- 	CJ.SetUnitAnimation(whichUnit, "stand")
-- end

-- --===========================================================================
-- function BJ.SetUnitTimeScalePercent(whichUnit, percentScale)
-- 	CJ.SetUnitTimeScale(whichUnit, percentScale * 0.01)
-- end

--===========================================================================
function BJ.SetUnitScalePercent(whichUnit, percentScaleX, percentScaleY, percentScaleZ)
	CJ.SetUnitScale(whichUnit, percentScaleX * 0.01, percentScaleY * 0.01, percentScaleZ * 0.01)
end

-- --===========================================================================
-- -- This version differs from the common.j interface in that the alpha value
-- -- is reversed so as to be displayed as transparency, and all four parameters
-- -- are treated as percentages rather than bytes.
-- --
-- function BJ.SetUnitVertexColorBJ(whichUnit, red, green, blue, transparency)
-- 	SetUnitVertexColor(whichUnit, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.UnitAddIndicatorBJ(whichUnit, red, green, blue, transparency)
-- 	AddIndicator(whichUnit, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.DestructableAddIndicatorBJ(whichDestructable, red, green, blue, transparency)
-- 	AddIndicator(whichDestructable, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.ItemAddIndicatorBJ(whichItem, red, green, blue, transparency)
-- 	AddIndicator(whichItem, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- -- Sets a unit's facing to point directly at a location.
-- --
-- function BJ.SetUnitFacingToFaceLocTimed(whichUnit, target, duration)
-- 	local unitLoc = CJ.GetUnitLoc(whichUnit)

-- 	CJ.SetUnitFacingTimed(whichUnit, BJ.AngleBetweenPoints(unitLoc, target), duration)
-- 	CJ.RemoveLocation(unitLoc)
-- end

-- --===========================================================================
-- -- Sets a unit's facing to point directly at another unit.
-- --
-- function BJ.SetUnitFacingToFaceUnitTimed(whichUnit, target, duration)
-- 	local unitLoc = CJ.GetUnitLoc(target)

-- 	SetUnitFacingToFaceLocTimed(whichUnit, unitLoc, duration)
-- 	CJ.RemoveLocation(unitLoc)
-- end

-- --===========================================================================
-- function BJ.QueueUnitAnimationBJ(whichUnit, whichAnimation)
-- 	QueueUnitAnimation(whichUnit, whichAnimation)
-- end

-- --===========================================================================
-- function BJ.SetDestructableAnimationBJ(d, whichAnimation)
-- 	SetDestructableAnimation(d, whichAnimation)
-- end

-- --===========================================================================
-- function BJ.QueueDestructableAnimationBJ(d, whichAnimation)
-- 	QueueDestructableAnimation(d, whichAnimation)
-- end

-- --===========================================================================
-- function BJ.SetDestAnimationSpeedPercent(d, percentScale)
-- 	SetDestructableAnimationSpeed(d, percentScale * 0.01)
-- end

-- --***************************************************************************
-- --*
-- --*  Dialog Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.DialogDisplayBJ(flag, whichDialog, whichPlayer)
-- 	CJ.DialogDisplay(whichPlayer, whichDialog, flag)
-- end

-- --===========================================================================
-- function BJ.DialogSetMessageBJ(whichDialog, message)
-- 	CJ.DialogSetMessage(whichDialog, message)
-- end

-- --===========================================================================
-- function BJ.DialogAddButtonBJ(whichDialog, buttonText)
-- 	bj_lastCreatedButton = CJ.DialogAddButton(whichDialog, buttonText, 0)
-- 	return bj_lastCreatedButton
-- end

-- --===========================================================================
-- function BJ.DialogAddButtonWithHotkeyBJ(whichDialog, buttonText, hotkey)
-- 	bj_lastCreatedButton = CJ.DialogAddButton(whichDialog, buttonText, hotkey)
-- 	return bj_lastCreatedButton
-- end

-- --===========================================================================
-- function BJ.DialogClearBJ(whichDialog)
-- 	DialogClear(whichDialog)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedButtonBJ()
-- 	return bj_lastCreatedButton
-- end

-- --===========================================================================
-- function BJ.GetClickedButtonBJ()
-- 	return GetClickedButton()
-- end

-- --===========================================================================
-- function BJ.GetClickedDialogBJ()
-- 	return GetClickedDialog()
-- end

-- --***************************************************************************
-- --*
-- --*  Alliance Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.SetPlayerAllianceBJ(sourcePlayer, whichAllianceSetting, value, otherPlayer)
-- 	-- Prevent players from attempting to ally with themselves.
-- 	if sourcePlayer == otherPlayer then
-- 		return
-- 	end

-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting, value)
-- end

-- --===========================================================================
-- -- Set all flags used by the in-game "Ally" checkbox.
-- --
-- function BJ.SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, CJ.ALLIANCE_PASSIVE, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_HELP_REQUEST, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_HELP_RESPONSE, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_XP, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_SPELLS, flag)
-- end

-- --===========================================================================
-- -- Set all flags used by the in-game "Shared Vision" checkbox.
-- --
-- function BJ.SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION, flag)
-- end

-- --===========================================================================
-- -- Set all flags used by the in-game "Shared Units" checkbox.
-- --
-- function BJ.SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL, flag)
-- end

-- --===========================================================================
-- -- Set all flags used by the in-game "Shared Units" checkbox with the Full
-- -- Shared Unit Control feature enabled.
-- --
-- function BJ.SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, flag)
-- 	CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, flag)
-- end

-- --===========================================================================
-- function BJ.SetPlayerAllianceStateBJ(sourcePlayer, otherPlayer, allianceState)
-- 	-- Prevent players from attempting to ally with themselves.
-- 	if sourcePlayer == otherPlayer then
-- 		return
-- 	end

-- 	if allianceState == bj_ALLIANCE_UNALLIED then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 	elseif allianceState == bj_ALLIANCE_UNALLIED_VISION then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 	elseif allianceState == bj_ALLIANCE_ALLIED then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 	elseif allianceState == bj_ALLIANCE_ALLIED_VISION then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 	elseif allianceState == bj_ALLIANCE_ALLIED_UNITS then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 	elseif allianceState == bj_ALLIANCE_ALLIED_ADVUNITS then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, true)
-- 	elseif allianceState == bj_ALLIANCE_NEUTRAL then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 		CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, CJ.ALLIANCE_PASSIVE, true)
-- 	elseif allianceState == bj_ALLIANCE_NEUTRAL_VISION then
-- 		SetPlayerAllianceStateAllyBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateVisionBJ(sourcePlayer, otherPlayer, true)
-- 		SetPlayerAllianceStateControlBJ(sourcePlayer, otherPlayer, false)
-- 		SetPlayerAllianceStateFullControlBJ(sourcePlayer, otherPlayer, false)
-- 		CJ.SetPlayerAlliance(sourcePlayer, otherPlayer, CJ.ALLIANCE_PASSIVE, true)
-- 	else
-- 	-- Unrecognized alliance state - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- -- Set the alliance states for an entire force towards another force.
-- --
-- function BJ.SetForceAllianceStateBJ(sourceForce, targetForce, allianceState)
-- 	local sourceIndex
-- 	local targetIndex

-- 	sourceIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do

-- 		if sourceForce == BJ.bj_FORCE_ALL_PLAYERS or CJ.IsPlayerInForce(CJ.Player(sourceIndex), sourceForce) then
-- 			targetIndex = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				if targetForce == BJ.bj_FORCE_ALL_PLAYERS or CJ.IsPlayerInForce(CJ.Player(targetIndex), targetForce) then
-- 					SetPlayerAllianceStateBJ(CJ.Player(sourceIndex), CJ.Player(targetIndex), allianceState)
-- 				end

-- 				targetIndex = targetIndex + 1
-- 				if targetIndex == BJ.bj_MAX_PLAYER_SLOTS then break end
-- 			end
-- 		end

-- 		sourceIndex = sourceIndex + 1
-- 		if sourceIndex == BJ.bj_MAX_PLAYER_SLOTS then break end
-- 	end
-- end

-- --===========================================================================
-- -- Test to see if two players are co-allied (allied with each other).
-- --
-- function BJ.PlayersAreCoAllied(playerA, playerB)
-- 	-- Players are considered to be allied with themselves.
-- 	if playerA == playerB then
-- 		return true
-- 	end

-- 	-- Co-allies are both allied with each other.
-- 	if GetPlayerAlliance(playerA, playerB, CJ.ALLIANCE_PASSIVE) then
-- 		if GetPlayerAlliance(playerB, playerA, CJ.ALLIANCE_PASSIVE) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

-- --===========================================================================
-- -- Force (whichPlayer) AI player to share vision and advanced unit control 
-- -- with all AI players of its allies.
-- --
-- function BJ.ShareEverythingWithTeamAI(whichPlayer)
-- 	local playerIndex
-- 	local indexPlayer

-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if PlayersAreCoAllied(whichPlayer, indexPlayer) and whichPlayer ~= indexPlayer then
-- 			if CJ.GetPlayerController(indexPlayer) == MAP_CONTROL_COMPUTER then
-- 				CJ.SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_VISION, true)
-- 				CJ.SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_CONTROL, true)
-- 				CJ.SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, true)
-- 			end
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --===========================================================================
-- -- Force (whichPlayer) to share vision and advanced unit control with all of his/her allies.
-- --
-- function BJ.ShareEverythingWithTeam(whichPlayer)
-- 	local playerIndex
-- 	local indexPlayer

-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if PlayersAreCoAllied(whichPlayer, indexPlayer) and whichPlayer ~= indexPlayer then
-- 			CJ.SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_VISION, true)
-- 			CJ.SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_CONTROL, true)
-- 			CJ.SetPlayerAlliance(indexPlayer, whichPlayer, ALLIANCE_SHARED_CONTROL, true)
-- 			CJ.SetPlayerAlliance(whichPlayer, indexPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, true)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- ===========================================================================
-- Creates a 'Neutral Victim' player slot.  This slot is passive towards all
-- other players, but all other players are aggressive towards him/her.
-- 
function BJ.ConfigureNeutralVictim()
    local index
    local indexPlayer
    local neutralVictim = CJ.Player(BJ.bj_PLAYER_NEUTRAL_VICTIM)

    index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        indexPlayer = CJ.Player(index)

        CJ.SetPlayerAlliance(neutralVictim, indexPlayer, CJ.ALLIANCE_PASSIVE,
                             true)
        CJ.SetPlayerAlliance(indexPlayer, neutralVictim, CJ.ALLIANCE_PASSIVE,
                             false)

        index = index + 1
        if index == BJ.bj_MAX_PLAYERS then break end
    end

    -- Neutral Victim and Neutral Aggressive should not fight each other.
    indexPlayer = CJ.Player(CJ.PLAYER_NEUTRAL_AGGRESSIVE)
    CJ.SetPlayerAlliance(neutralVictim, indexPlayer, CJ.ALLIANCE_PASSIVE, true)
    CJ.SetPlayerAlliance(indexPlayer, neutralVictim, CJ.ALLIANCE_PASSIVE, true)

    -- Neutral Victim does not give bounties.
    CJ.SetPlayerState(neutralVictim, CJ.PLAYER_STATE_GIVES_BOUNTY, 0)
end

-- --===========================================================================
-- function BJ.MakeUnitsPassiveForPlayerEnum()
-- 	CJ.SetUnitOwner(CJ.GetEnumUnit(), CJ.Player(BJ.bj_PLAYER_NEUTRAL_VICTIM), false)
-- end

-- --===========================================================================
-- -- Change ownership for every unit of (whichPlayer)'s team to neutral passive.
-- --
-- function BJ.MakeUnitsPassiveForPlayer(whichPlayer)
-- 	local playerUnits = CJ.CreateGroup()
-- 	CachePlayerHeroData(whichPlayer)
-- 	GroupEnumUnitsOfPlayer(playerUnits, whichPlayer, nil)
-- 	CJ.ForGroup(playerUnits, MakeUnitsPassiveForPlayerEnum)
-- 	CJ.DestroyGroup(playerUnits)
-- end

-- --===========================================================================
-- -- Change ownership for every unit of (whichPlayer)'s team to neutral passive.
-- --
-- function BJ.MakeUnitsPassiveForTeam(whichPlayer)
-- 	local playerIndex
-- 	local indexPlayer

-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if PlayersAreCoAllied(whichPlayer, indexPlayer) then
-- 			MakeUnitsPassiveForPlayer(indexPlayer)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- ===========================================================================
-- Determine whether or not victory/defeat is disabled via cheat codes.
--
function BJ.AllowVictoryDefeat(gameResult)
    if gameResult == CJ.PLAYER_GAME_RESULT_VICTORY then
        return not CJ.IsNoVictoryCheat()
    end
    if gameResult == CJ.PLAYER_GAME_RESULT_DEFEAT then
        return not CJ.IsNoDefeatCheat()
    end
    if gameResult == CJ.PLAYER_GAME_RESULT_NEUTRAL then
        return not CJ.IsNoVictoryCheat() and not CJ.IsNoDefeatCheat()
    end
    return true
end

-- --===========================================================================
function BJ.EndGameBJ()
	CJ.EndGame(true)
end

-- --===========================================================================
-- function BJ.MeleeVictoryDialogBJ(whichPlayer, leftGame)
-- 	local t = CJ.CreateTrigger()
-- 	local d = CJ.DialogCreate()
-- 	local formatString

-- 	-- Display "player was victorious" or "player has left the game" message
-- 	if leftGame then
-- 		formatString = CJ.GetLocalizedString("PLAYER_LEFT_GAME")
-- 	else
-- 		formatString = CJ.GetLocalizedString("PLAYER_VICTORIOUS")
-- 	end

-- 	CJ.DisplayTimedTextFromPlayer(whichPlayer, 0, 0, 60, formatString)

-- 	CJ.DialogSetMessage(d, CJ.GetLocalizedString("GAMEOVER_VICTORY_MSG"))
-- 	CJ.DialogAddButton(d, CJ.GetLocalizedString("GAMEOVER_CONTINUE_GAME"), CJ.GetLocalizedHotkey("GAMEOVER_CONTINUE_GAME"))

-- 	t = CJ.CreateTrigger()
-- 	CJ.TriggerRegisterDialogButtonEvent(t, DialogAddQuitButton(d, true, CJ.GetLocalizedString("GAMEOVER_QUIT_GAME"), CJ.GetLocalizedHotkey("GAMEOVER_QUIT_GAME")))

-- 	CJ.DialogDisplay(whichPlayer, d, true)
-- 	BJ.StartSoundForPlayerBJ(whichPlayer, BJ.bj_victoryDialogSound)
-- end

-- --===========================================================================
-- function BJ.MeleeDefeatDialogBJ(whichPlayer, leftGame)
-- 	local t = CJ.CreateTrigger()
-- 	local d = CJ.DialogCreate()
-- 	local formatString

-- 	-- Display "player was defeated" or "player has left the game" message
-- 	if leftGame then
-- 		formatString = CJ.GetLocalizedString("PLAYER_LEFT_GAME")
-- 	else
-- 		formatString = CJ.GetLocalizedString("PLAYER_DEFEATED")
-- 	end

-- 	CJ.DisplayTimedTextFromPlayer(whichPlayer, 0, 0, 60, formatString)

-- 	CJ.DialogSetMessage(d, CJ.GetLocalizedString("GAMEOVER_DEFEAT_MSG"))

-- 	-- Only show the continue button if the game is not over and observers on death are allowed
-- 	if not bj_meleeGameOver and IsMapFlagSet(MAP_OBSERVERS_ON_DEATH) then
-- 		CJ.DialogAddButton(d, CJ.GetLocalizedString("GAMEOVER_CONTINUE_OBSERVING"), CJ.GetLocalizedHotkey("GAMEOVER_CONTINUE_OBSERVING"))
-- 	end

-- 	t = CJ.CreateTrigger()
-- 	CJ.TriggerRegisterDialogButtonEvent(t, DialogAddQuitButton(d, true, CJ.GetLocalizedString("GAMEOVER_QUIT_GAME"), CJ.GetLocalizedHotkey("GAMEOVER_QUIT_GAME")))

-- 	CJ.DialogDisplay(whichPlayer, d, true)
-- 	BJ.StartSoundForPlayerBJ(whichPlayer, BJ.bj_defeatDialogSound)
-- end

-- --===========================================================================
-- function BJ.GameOverDialogBJ(whichPlayer, leftGame)
-- 	local t = CJ.CreateTrigger()
-- 	local d = CJ.DialogCreate()
-- 	local s

-- 	-- Display "player left the game" message
-- 	CJ.DisplayTimedTextFromPlayer(whichPlayer, 0, 0, 60, CJ.GetLocalizedString("PLAYER_LEFT_GAME"))

-- 	if GetIntegerGameState(GAME_STATE_DISCONNECTED) ~= 0 then
-- 		s = CJ.GetLocalizedString("GAMEOVER_DISCONNECTED")
-- 	else
-- 		s = CJ.GetLocalizedString("GAMEOVER_GAME_OVER")
-- 	end

-- 	CJ.DialogSetMessage(d, s)

-- 	t = CJ.CreateTrigger()
-- 	CJ.TriggerRegisterDialogButtonEvent(t, DialogAddQuitButton(d, true, CJ.GetLocalizedString("GAMEOVER_OK"), CJ.GetLocalizedHotkey("GAMEOVER_OK")))

-- 	CJ.DialogDisplay(whichPlayer, d, true)
-- 	BJ.StartSoundForPlayerBJ(whichPlayer, BJ.bj_defeatDialogSound)
-- end

-- --===========================================================================
-- function BJ.RemovePlayerPreserveUnitsBJ(whichPlayer, gameResult, leftGame)
-- 	if BJ.AllowVictoryDefeat(gameResult) then

-- 		CJ.RemovePlayer(whichPlayer, gameResult)

-- 		if gameResult == CJ.PLAYER_GAME_RESULT_VICTORY then
-- 			MeleeVictoryDialogBJ(whichPlayer, leftGame)
-- 			return
-- 		elseif gameResult == CJ.PLAYER_GAME_RESULT_DEFEAT then
-- 			MeleeDefeatDialogBJ(whichPlayer, leftGame)
-- 		else
-- 			GameOverDialogBJ(whichPlayer, leftGame)
-- 		end

-- 	end
-- end

--===========================================================================
function BJ.CustomVictoryOkBJ()
	if BJ.bj_isSinglePlayer then
		CJ.PauseGame(false)
		-- Bump the difficulty back up to the default.
		CJ.SetGameDifficulty(CJ.GetDefaultDifficulty())
	end

	if BJ.bj_changeLevelMapName == nil then
		CJ.EndGame(BJ.bj_changeLevelShowScores)
	else
		CJ.ChangeLevel(BJ.bj_changeLevelMapName, BJ.bj_changeLevelShowScores)
	end
end

--===========================================================================
function BJ.CustomVictoryQuitBJ()
	if BJ.bj_isSinglePlayer then
		CJ.PauseGame(false)
		-- Bump the difficulty back up to the default.
		CJ.SetGameDifficulty(CJ.GetDefaultDifficulty())
	end

	CJ.EndGame(BJ.bj_changeLevelShowScores)
end

--===========================================================================
function BJ.CustomVictoryDialogBJ(whichPlayer)
	local t = CJ.CreateTrigger()
	local d = CJ.DialogCreate()

	CJ.DialogSetMessage(d, CJ.GetLocalizedString("GAMEOVER_VICTORY_MSG"))

	t = CJ.CreateTrigger()
	CJ.TriggerRegisterDialogButtonEvent(t, CJ.DialogAddButton(d, CJ.GetLocalizedString("GAMEOVER_CONTINUE"), CJ.GetLocalizedHotkey("GAMEOVER_CONTINUE")))
	CJ.TriggerAddAction(t, BJ.CustomVictoryOkBJ)

	t = CJ.CreateTrigger()
	CJ.TriggerRegisterDialogButtonEvent(t, CJ.DialogAddButton(d, CJ.GetLocalizedString("GAMEOVER_QUIT_MISSION"), CJ.GetLocalizedHotkey("GAMEOVER_QUIT_MISSION")))
	CJ.TriggerAddAction(t, BJ.CustomVictoryQuitBJ)

	if CJ.GetLocalPlayer() == whichPlayer then
		CJ.EnableUserControl(true)
		if BJ.bj_isSinglePlayer then
			CJ.PauseGame(true)
		end
		CJ.EnableUserUI(false)
	end

	CJ.DialogDisplay(whichPlayer, d, true)
	BJ.VolumeGroupSetVolumeForPlayerBJ(whichPlayer, CJ.SOUND_VOLUMEGROUP_UI, 1.0)
	BJ.StartSoundForPlayerBJ(whichPlayer, BJ.bj_victoryDialogSound)
end

--===========================================================================
function BJ.CustomVictorySkipBJ(whichPlayer)
	if CJ.GetLocalPlayer() == whichPlayer then
		if BJ.bj_isSinglePlayer then
			-- Bump the difficulty back up to the default.
			CJ.SetGameDifficulty(CJ.GetDefaultDifficulty())
		end

		if BJ.bj_changeLevelMapName == nil then
			CJ.EndGame(BJ.bj_changeLevelShowScores)
		else
			CJ.ChangeLevel(BJ.bj_changeLevelMapName, BJ.bj_changeLevelShowScores)
		end
	end
end

--===========================================================================
function BJ.CustomVictoryBJ(whichPlayer, showDialog, showScores)
	if BJ.AllowVictoryDefeat(CJ.PLAYER_GAME_RESULT_VICTORY) then
		CJ.RemovePlayer(whichPlayer, CJ.PLAYER_GAME_RESULT_VICTORY)

		if not BJ.bj_isSinglePlayer then
			CJ.DisplayTimedTextFromPlayer(whichPlayer, 0, 0, 60, CJ.GetLocalizedString("PLAYER_VICTORIOUS"))
		end

		-- UI only needs to be displayed to users.
		if CJ.GetPlayerController(whichPlayer) == CJ.MAP_CONTROL_USER then
			BJ.bj_changeLevelShowScores = showScores
			if showDialog then
				BJ.CustomVictoryDialogBJ(whichPlayer)
			else
				BJ.CustomVictorySkipBJ(whichPlayer)
			end
		end
	end
end

-- ===========================================================================
function BJ.CustomDefeatRestartBJ()
    CJ.PauseGame(false)
    CJ.RestartGame(true)
end

-- ===========================================================================
function BJ.CustomDefeatReduceDifficultyBJ()
    local diff = CJ.GetGameDifficulty()

    CJ.PauseGame(false)

    -- Knock the difficulty down, if possible.
    if diff == CJ.MAP_DIFFICULTY_EASY then
        -- Sorry, but it doesn't get any easier than this.
    elseif diff == CJ.MAP_DIFFICULTY_NORMAL then
        CJ.SetGameDifficulty(CJ.MAP_DIFFICULTY_EASY)
    elseif diff == CJ.MAP_DIFFICULTY_HARD then
        CJ.SetGameDifficulty(CJ.MAP_DIFFICULTY_NORMAL)
    else
        -- Unrecognized difficulty
    end

    CJ.RestartGame(true)
end

-- ===========================================================================
function BJ.CustomDefeatLoadBJ()
    CJ.PauseGame(false)
    CJ.DisplayLoadDialog()
end

-- ===========================================================================
function BJ.CustomDefeatQuitBJ()
    if BJ.bj_isSinglePlayer then CJ.PauseGame(false) end

    -- Bump the difficulty back up to the default.
    CJ.SetGameDifficulty(CJ.GetDefaultDifficulty())
    CJ.EndGame(true)
end

-- ===========================================================================
function BJ.CustomDefeatDialogBJ(whichPlayer, message)
    local t = CJ.CreateTrigger()
    local d = CJ.DialogCreate()

    CJ.DialogSetMessage(d, message)

    if BJ.bj_isSinglePlayer then
        t = CJ.CreateTrigger()
        CJ.TriggerRegisterDialogButtonEvent(t,
                                            CJ.DialogAddButton(d,
                                                               CJ.GetLocalizedString(
                                                                   "GAMEOVER_RESTART"),
                                                               CJ.GetLocalizedHotkey(
                                                                   "GAMEOVER_RESTART")))
        CJ.TriggerAddAction(t, BJ.CustomDefeatRestartBJ)

        if CJ.GetGameDifficulty() ~= CJ.MAP_DIFFICULTY_EASY then
            t = CJ.CreateTrigger()
            CJ.TriggerRegisterDialogButtonEvent(t,
                                                CJ.DialogAddButton(d,
                                                                   CJ.GetLocalizedString(
                                                                       "GAMEOVER_REDUCE_DIFFICULTY"),
                                                                   CJ.GetLocalizedHotkey(
                                                                       "GAMEOVER_REDUCE_DIFFICULTY")))
            CJ.TriggerAddAction(t, BJ.CustomDefeatReduceDifficultyBJ)
        end

        t = CJ.CreateTrigger()
        CJ.TriggerRegisterDialogButtonEvent(t,
                                            CJ.DialogAddButton(d,
                                                               CJ.GetLocalizedString(
                                                                   "GAMEOVER_LOAD"),
                                                               CJ.GetLocalizedHotkey(
                                                                   "GAMEOVER_LOAD")))
        CJ.TriggerAddAction(t, BJ.CustomDefeatLoadBJ)
    end

    t = CJ.CreateTrigger()
    CJ.TriggerRegisterDialogButtonEvent(t,
                                        CJ.DialogAddButton(d,
                                                           CJ.GetLocalizedString(
                                                               "GAMEOVER_QUIT_MISSION"),
                                                           CJ.GetLocalizedHotkey(
                                                               "GAMEOVER_QUIT_MISSION")))
    CJ.TriggerAddAction(t, BJ.CustomDefeatQuitBJ)

    if CJ.GetLocalPlayer() == whichPlayer then
        CJ.EnableUserControl(true)
        if BJ.bj_isSinglePlayer then CJ.PauseGame(true) end
        CJ.EnableUserUI(false)
    end

    CJ.DialogDisplay(whichPlayer, d, true)
    BJ.VolumeGroupSetVolumeForPlayerBJ(whichPlayer, CJ.SOUND_VOLUMEGROUP_UI, 1.0)
    BJ.StartSoundForPlayerBJ(whichPlayer, BJ.bj_defeatDialogSound)
end

-- ===========================================================================
function BJ.CustomDefeatBJ(whichPlayer, message)
    if BJ.AllowVictoryDefeat(CJ.PLAYER_GAME_RESULT_DEFEAT) then
        CJ.RemovePlayer(whichPlayer, CJ.PLAYER_GAME_RESULT_DEFEAT)

        if not BJ.bj_isSinglePlayer then
            CJ.DisplayTimedTextFromPlayer(whichPlayer, 0, 0, 60,
                                          CJ.GetLocalizedString(
                                              "PLAYER_DEFEATED"))
        end

        -- UI only needs to be displayed to users.
        if CJ.GetPlayerController(whichPlayer) == CJ.MAP_CONTROL_USER then
            BJ.CustomDefeatDialogBJ(whichPlayer, message)
        end
    end
end

-- --===========================================================================
-- function BJ.SetNextLevelBJ(nextLevel)
-- 	if nextLevel == "" then
-- 		BJ.bj_changeLevelMapName = nil
-- 	else
-- 		BJ.bj_changeLevelMapName = nextLevel
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetPlayerOnScoreScreenBJ(flag, whichPlayer)
-- 	SetPlayerOnScoreScreen(whichPlayer, flag)
-- end

-- --***************************************************************************
-- --*
-- --*  Quest Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.CreateQuestBJ(questType, title, description, iconPath)
-- 	local required = questType == bj_QUESTTYPE_REQ_DISCOVERED or questType == bj_QUESTTYPE_REQ_UNDISCOVERED
-- 	local discovered = questType == bj_QUESTTYPE_REQ_DISCOVERED or questType == bj_QUESTTYPE_OPT_DISCOVERED

-- 	bj_lastCreatedQuest = CreateQuest()
-- 	QuestSetTitle(bj_lastCreatedQuest, title)
-- 	QuestSetDescription(bj_lastCreatedQuest, description)
-- 	QuestSetIconPath(bj_lastCreatedQuest, iconPath)
-- 	QuestSetRequired(bj_lastCreatedQuest, required)
-- 	QuestSetDiscovered(bj_lastCreatedQuest, discovered)
-- 	QuestSetCompleted(bj_lastCreatedQuest, false)
-- 	return bj_lastCreatedQuest
-- end

-- --===========================================================================
-- function BJ.DestroyQuestBJ(whichQuest)
-- 	DestroyQuest(whichQuest)
-- end

-- --===========================================================================
-- function BJ.QuestSetEnabledBJ(enabled, whichQuest)
-- 	QuestSetEnabled(whichQuest, enabled)
-- end

-- --===========================================================================
-- function BJ.QuestSetTitleBJ(whichQuest, title)
-- 	QuestSetTitle(whichQuest, title)
-- end

-- --===========================================================================
-- function BJ.QuestSetDescriptionBJ(whichQuest, description)
-- 	QuestSetDescription(whichQuest, description)
-- end

-- --===========================================================================
-- function BJ.QuestSetCompletedBJ(whichQuest, completed)
-- 	QuestSetCompleted(whichQuest, completed)
-- end

-- --===========================================================================
-- function BJ.QuestSetFailedBJ(whichQuest, failed)
-- 	QuestSetFailed(whichQuest, failed)
-- end

-- --===========================================================================
-- function BJ.QuestSetDiscoveredBJ(whichQuest, discovered)
-- 	QuestSetDiscovered(whichQuest, discovered)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedQuestBJ()
-- 	return bj_lastCreatedQuest
-- end

-- --===========================================================================
-- function BJ.CreateQuestItemBJ(whichQuest, description)
-- 	bj_lastCreatedQuestItem = QuestCreateItem(whichQuest)
-- 	QuestItemSetDescription(bj_lastCreatedQuestItem, description)
-- 	QuestItemSetCompleted(bj_lastCreatedQuestItem, false)
-- 	return bj_lastCreatedQuestItem
-- end

-- --===========================================================================
-- function BJ.QuestItemSetDescriptionBJ(whichQuestItem, description)
-- 	QuestItemSetDescription(whichQuestItem, description)
-- end

-- --===========================================================================
-- function BJ.QuestItemSetCompletedBJ(whichQuestItem, completed)
-- 	QuestItemSetCompleted(whichQuestItem, completed)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedQuestItemBJ()
-- 	return bj_lastCreatedQuestItem
-- end

-- --===========================================================================
-- function BJ.CreateDefeatConditionBJ(description)
-- 	bj_lastCreatedDefeatCondition = CreateDefeatCondition()
-- 	DefeatConditionSetDescription(bj_lastCreatedDefeatCondition, description)
-- 	return bj_lastCreatedDefeatCondition
-- end

-- --===========================================================================
-- function BJ.DestroyDefeatConditionBJ(whichCondition)
-- 	DestroyDefeatCondition(whichCondition)
-- end

-- --===========================================================================
-- function BJ.DefeatConditionSetDescriptionBJ(whichCondition, description)
-- 	DefeatConditionSetDescription(whichCondition, description)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedDefeatConditionBJ()
-- 	return bj_lastCreatedDefeatCondition
-- end

-- --===========================================================================
-- function BJ.FlashQuestDialogButtonBJ()
-- 	FlashQuestDialogButton()
-- end

-- --===========================================================================
-- function BJ.QuestMessageBJ(f, messageType, message)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), f) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 		if messageType == bj_QUESTMESSAGE_DISCOVERED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUEST, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUEST, message)
-- 			CJ.StartSound(BJ.bj_questDiscoveredSound)
-- 			FlashQuestDialogButton()

-- 		elseif messageType == bj_QUESTMESSAGE_UPDATED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTUPDATE, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTUPDATE, message)
-- 			CJ.StartSound(BJ.bj_questUpdatedSound)
-- 			FlashQuestDialogButton()

-- 		elseif messageType == bj_QUESTMESSAGE_COMPLETED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTDONE, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTDONE, message)
-- 			CJ.StartSound(BJ.bj_questCompletedSound)
-- 			FlashQuestDialogButton()

-- 		elseif messageType == bj_QUESTMESSAGE_FAILED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTFAILED, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTFAILED, message)
-- 			CJ.StartSound(BJ.bj_questFailedSound)
-- 			FlashQuestDialogButton()

-- 		elseif messageType == bj_QUESTMESSAGE_REQUIREMENT then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_QUESTREQUIREMENT, message)

-- 		elseif messageType == bj_QUESTMESSAGE_MISSIONFAILED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_MISSIONFAILED, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_MISSIONFAILED, message)
-- 			CJ.StartSound(BJ.bj_questFailedSound)

-- 		elseif messageType == bj_QUESTMESSAGE_HINT then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_HINT, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_HINT, message)
-- 			CJ.StartSound(BJ.bj_questHintSound)

-- 		elseif messageType == bj_QUESTMESSAGE_ALWAYSHINT then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_ALWAYSHINT, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_ALWAYSHINT, message)
-- 			CJ.StartSound(BJ.bj_questHintSound)

-- 		elseif messageType == bj_QUESTMESSAGE_SECRET then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_SECRET, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_SECRET, message)
-- 			CJ.StartSound(BJ.bj_questSecretSound)

-- 		elseif messageType == bj_QUESTMESSAGE_UNITACQUIRED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_UNITACQUIRED, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_UNITACQUIRED, message)
-- 			CJ.StartSound(BJ.bj_questHintSound)

-- 		elseif messageType == bj_QUESTMESSAGE_UNITAVAILABLE then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_UNITAVAILABLE, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_UNITAVAILABLE, message)
-- 			CJ.StartSound(BJ.bj_questHintSound)

-- 		elseif messageType == bj_QUESTMESSAGE_ITEMACQUIRED then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_ITEMACQUIRED, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_ITEMACQUIRED, message)
-- 			CJ.StartSound(BJ.bj_questItemAcquiredSound)

-- 		elseif messageType == bj_QUESTMESSAGE_WARNING then
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_WARNING, " ")
-- 			DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_TEXT_DELAY_WARNING, message)
-- 			CJ.StartSound(BJ.bj_questWarningSound)

-- 		else
-- 		-- Unrecognized message type - ignore the request.
-- 		end
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Timer Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.StartTimerBJ(t, periodic, timeout)
-- 	bj_lastStartedTimer = t
-- 	CJ.TimerStart(t, timeout, periodic, nil)
-- 	return bj_lastStartedTimer
-- end

-- --===========================================================================
-- function BJ.CreateTimerBJ(periodic, timeout)
-- 	bj_lastStartedTimer = CJ.CreateTimer()
-- 	CJ.TimerStart(bj_lastStartedTimer, timeout, periodic, nil)
-- 	return bj_lastStartedTimer
-- end

-- --===========================================================================
-- function BJ.DestroyTimerBJ(whichTimer)
-- 	CJ.DestroyTimer(whichTimer)
-- end

-- --===========================================================================
-- function BJ.PauseTimerBJ(pause, whichTimer)
-- 	if pause then
-- 		CJ.PauseTimer(whichTimer)
-- 	else
-- 		ResumeTimer(whichTimer)
-- 	end
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedTimerBJ()
-- 	return bj_lastStartedTimer
-- end

-- --===========================================================================
-- function BJ.CreateTimerDialogBJ(t, title)
-- 	bj_lastCreatedTimerDialog = CreateTimerDialog(t)
-- 	TimerDialogSetTitle(bj_lastCreatedTimerDialog, title)
-- 	TimerDialogDisplay(bj_lastCreatedTimerDialog, true)
-- 	return bj_lastCreatedTimerDialog
-- end

-- --===========================================================================
-- function BJ.DestroyTimerDialogBJ(td)
-- 	DestroyTimerDialog(td)
-- end

-- --===========================================================================
-- function BJ.TimerDialogSetTitleBJ(td, title)
-- 	TimerDialogSetTitle(td, title)
-- end

-- --===========================================================================
-- function BJ.TimerDialogSetTitleColorBJ(td, red, green, blue, transparency)
-- 	TimerDialogSetTitleColor(td, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.TimerDialogSetTimeColorBJ(td, red, green, blue, transparency)
-- 	TimerDialogSetTimeColor(td, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.TimerDialogSetSpeedBJ(td, speedMultFactor)
-- 	TimerDialogSetSpeed(td, speedMultFactor)
-- end

-- --===========================================================================
-- function BJ.TimerDialogDisplayForPlayerBJ(show, td, whichPlayer)
-- 	if CJ.GetLocalPlayer() == whichPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		TimerDialogDisplay(td, show)
-- 	end
-- end

-- --===========================================================================
-- function BJ.TimerDialogDisplayBJ(show, td)
-- 	TimerDialogDisplay(td, show)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedTimerDialogBJ()
-- 	return bj_lastCreatedTimerDialog
-- end

-- --***************************************************************************
-- --*
-- --*  Leaderboard Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.LeaderboardResizeBJ(lb)
-- 	local size = LeaderboardGetItemCount(lb)

-- 	if LeaderboardGetLabelText(lb) == "" then
-- 		size = size - 1
-- 	end
-- 	LeaderboardSetSizeByItemCount(lb, size)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetPlayerItemValueBJ(whichPlayer, lb, val)
-- 	LeaderboardSetItemValue(lb, LeaderboardGetPlayerIndex(lb, whichPlayer), val)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetPlayerItemLabelBJ(whichPlayer, lb, val)
-- 	LeaderboardSetItemLabel(lb, LeaderboardGetPlayerIndex(lb, whichPlayer), val)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetPlayerItemStyleBJ(whichPlayer, lb, showLabel, showValue, showIcon)
-- 	LeaderboardSetItemStyle(lb, LeaderboardGetPlayerIndex(lb, whichPlayer), showLabel, showValue, showIcon)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetPlayerItemLabelColorBJ(whichPlayer, lb, red, green, blue, transparency)
-- 	LeaderboardSetItemLabelColor(lb, LeaderboardGetPlayerIndex(lb, whichPlayer), BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetPlayerItemValueColorBJ(whichPlayer, lb, red, green, blue, transparency)
-- 	LeaderboardSetItemValueColor(lb, LeaderboardGetPlayerIndex(lb, whichPlayer), BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetLabelColorBJ(lb, red, green, blue, transparency)
-- 	LeaderboardSetLabelColor(lb, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetValueColorBJ(lb, red, green, blue, transparency)
-- 	LeaderboardSetValueColor(lb, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetLabelBJ(lb, label)
-- 	LeaderboardSetLabel(lb, label)
-- 	LeaderboardResizeBJ(lb)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSetStyleBJ(lb, showLabel, showNames, showValues, showIcons)
-- 	LeaderboardSetStyle(lb, showLabel, showNames, showValues, showIcons)
-- end

-- --===========================================================================
-- function BJ.LeaderboardGetItemCountBJ(lb)
-- 	return LeaderboardGetItemCount(lb)
-- end

-- --===========================================================================
-- function BJ.LeaderboardHasPlayerItemBJ(lb, whichPlayer)
-- 	return LeaderboardHasPlayerItem(lb, whichPlayer)
-- end

-- --===========================================================================
-- function BJ.ForceSetLeaderboardBJ(lb, toForce)
-- 	local index
-- 	local indexPlayer

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)
-- 		if CJ.IsPlayerInForce(indexPlayer, toForce) then
-- 			PlayerSetLeaderboard(indexPlayer, lb)
-- 		end
-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --===========================================================================
-- function BJ.CreateLeaderboardBJ(toForce, label)
-- 	bj_lastCreatedLeaderboard = CreateLeaderboard()
-- 	LeaderboardSetLabel(bj_lastCreatedLeaderboard, label)
-- 	ForceSetLeaderboardBJ(bj_lastCreatedLeaderboard, toForce)
-- 	LeaderboardDisplay(bj_lastCreatedLeaderboard, true)
-- 	return bj_lastCreatedLeaderboard
-- end

-- --===========================================================================
-- function BJ.DestroyLeaderboardBJ(lb)
-- 	DestroyLeaderboard(lb)
-- end

-- --===========================================================================
-- function BJ.LeaderboardDisplayBJ(show, lb)
-- 	LeaderboardDisplay(lb, show)
-- end

-- --===========================================================================
-- function BJ.LeaderboardAddItemBJ(whichPlayer, lb, label, value)
-- 	if LeaderboardHasPlayerItem(lb, whichPlayer) then
-- 		LeaderboardRemovePlayerItem(lb, whichPlayer)
-- 	end
-- 	LeaderboardAddItem(lb, label, value, whichPlayer)
-- 	LeaderboardResizeBJ(lb)
-- --call LeaderboardSetSizeByItemCount(lb, LeaderboardGetItemCount(lb))
-- end

-- --===========================================================================
-- function BJ.LeaderboardRemovePlayerItemBJ(whichPlayer, lb)
-- 	LeaderboardRemovePlayerItem(lb, whichPlayer)
-- 	LeaderboardResizeBJ(lb)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSortItemsBJ(lb, sortType, ascending)
-- 	if sortType == bj_SORTTYPE_SORTBYVALUE then
-- 		LeaderboardSortItemsByValue(lb, ascending)
-- 	elseif sortType == bj_SORTTYPE_SORTBYPLAYER then
-- 		LeaderboardSortItemsByPlayer(lb, ascending)
-- 	elseif sortType == bj_SORTTYPE_SORTBYLABEL then
-- 		LeaderboardSortItemsByLabel(lb, ascending)
-- 	else
-- 	-- Unrecognized sort type - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.LeaderboardSortItemsByPlayerBJ(lb, ascending)
-- 	LeaderboardSortItemsByPlayer(lb, ascending)
-- end

-- --===========================================================================
-- function BJ.LeaderboardSortItemsByLabelBJ(lb, ascending)
-- 	LeaderboardSortItemsByLabel(lb, ascending)
-- end

-- --===========================================================================
-- function BJ.LeaderboardGetPlayerIndexBJ(whichPlayer, lb)
-- 	return LeaderboardGetPlayerIndex(lb, whichPlayer) + 1
-- end

-- --===========================================================================
-- -- Returns the player who is occupying a specified position in a leaderboard.
-- -- The position parameter is expected in the range of 1..16.
-- --
-- function BJ.LeaderboardGetIndexedPlayerBJ(position, lb)
-- 	local index
-- 	local indexPlayer

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)
-- 		if LeaderboardGetPlayerIndex(lb, indexPlayer) == position - 1 then
-- 			return indexPlayer
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	return CJ.Player(CJ.PLAYER_NEUTRAL_PASSIVE)
-- end

-- --===========================================================================
-- function BJ.PlayerGetLeaderboardBJ(whichPlayer)
-- 	return PlayerGetLeaderboard(whichPlayer)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedLeaderboard()
-- 	return bj_lastCreatedLeaderboard
-- end

-- --***************************************************************************
-- --*
-- --*  Multiboard Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.CreateMultiboardBJ(cols, rows, title)
-- 	bj_lastCreatedMultiboard = CreateMultiboard()
-- 	MultiboardSetRowCount(bj_lastCreatedMultiboard, rows)
-- 	MultiboardSetColumnCount(bj_lastCreatedMultiboard, cols)
-- 	MultiboardSetTitleText(bj_lastCreatedMultiboard, title)
-- 	MultiboardDisplay(bj_lastCreatedMultiboard, true)
-- 	return bj_lastCreatedMultiboard
-- end

-- --===========================================================================
-- function BJ.DestroyMultiboardBJ(mb)
-- 	DestroyMultiboard(mb)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedMultiboard()
-- 	return bj_lastCreatedMultiboard
-- end

-- --===========================================================================
-- function BJ.MultiboardDisplayBJ(show, mb)
-- 	MultiboardDisplay(mb, show)
-- end

-- --===========================================================================
-- function BJ.MultiboardMinimizeBJ(minimize, mb)
-- 	MultiboardMinimize(mb, minimize)
-- end

-- --===========================================================================
-- function BJ.MultiboardSetTitleTextColorBJ(mb, red, green, blue, transparency)
-- 	MultiboardSetTitleTextColor(mb, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- end

-- --===========================================================================
-- function BJ.MultiboardAllowDisplayBJ(flag)
-- 	MultiboardSuppressDisplay(not flag)
-- end

-- --===========================================================================
-- function BJ.MultiboardSetItemStyleBJ(mb, col, row, showValue, showIcon)
-- 	local curRow = 0
-- 	local curCol = 0
-- 	local numRows = MultiboardGetRowCount(mb)
-- 	local numCols = MultiboardGetColumnCount(mb)
-- 	local mbitem = nil

-- 	-- Loop over rows, using 1-based index
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		curRow = curRow + 1
-- 		if curRow > numRows then break end

-- 		-- Apply setting to the requested row, or all rows (if row is 0)
-- 		if row == 0 or row == curRow then
-- 			-- Loop over columns, using 1-based index
-- 			curCol = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				curCol = curCol + 1
-- 				if curCol > numCols then break end

-- 				-- Apply setting to the requested column, or all columns (if col is 0)
-- 				if col == 0 or col == curCol then
-- 					mbitem = MultiboardGetItem(mb, curRow - 1, curCol - 1)
-- 					MultiboardSetItemStyle(mbitem, showValue, showIcon)
-- 					MultiboardReleaseItem(mbitem)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MultiboardSetItemValueBJ(mb, col, row, val)
-- 	local curRow = 0
-- 	local curCol = 0
-- 	local numRows = MultiboardGetRowCount(mb)
-- 	local numCols = MultiboardGetColumnCount(mb)
-- 	local mbitem = nil

-- 	-- Loop over rows, using 1-based index
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		curRow = curRow + 1
-- 		if curRow > numRows then break end

-- 		-- Apply setting to the requested row, or all rows (if row is 0)
-- 		if row == 0 or row == curRow then
-- 			-- Loop over columns, using 1-based index
-- 			curCol = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				curCol = curCol + 1
-- 				if curCol > numCols then break end

-- 				-- Apply setting to the requested column, or all columns (if col is 0)
-- 				if col == 0 or col == curCol then
-- 					mbitem = MultiboardGetItem(mb, curRow - 1, curCol - 1)
-- 					MultiboardSetItemValue(mbitem, val)
-- 					MultiboardReleaseItem(mbitem)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MultiboardSetItemColorBJ(mb, col, row, red, green, blue, transparency)
-- 	local curRow = 0
-- 	local curCol = 0
-- 	local numRows = MultiboardGetRowCount(mb)
-- 	local numCols = MultiboardGetColumnCount(mb)
-- 	local mbitem = nil

-- 	-- Loop over rows, using 1-based index
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		curRow = curRow + 1
-- 		if curRow > numRows then break end

-- 		-- Apply setting to the requested row, or all rows (if row is 0)
-- 		if row == 0 or row == curRow then
-- 			-- Loop over columns, using 1-based index
-- 			curCol = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				curCol = curCol + 1
-- 				if curCol > numCols then break end

-- 				-- Apply setting to the requested column, or all columns (if col is 0)
-- 				if col == 0 or col == curCol then
-- 					mbitem = MultiboardGetItem(mb, curRow - 1, curCol - 1)
-- 					MultiboardSetItemValueColor(mbitem, BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100.0 - transparency))
-- 					MultiboardReleaseItem(mbitem)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MultiboardSetItemWidthBJ(mb, col, row, width)
-- 	local curRow = 0
-- 	local curCol = 0
-- 	local numRows = MultiboardGetRowCount(mb)
-- 	local numCols = MultiboardGetColumnCount(mb)
-- 	local mbitem = nil

-- 	-- Loop over rows, using 1-based index
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		curRow = curRow + 1
-- 		if curRow > numRows then break end

-- 		-- Apply setting to the requested row, or all rows (if row is 0)
-- 		if row == 0 or row == curRow then
-- 			-- Loop over columns, using 1-based index
-- 			curCol = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				curCol = curCol + 1
-- 				if curCol > numCols then break end

-- 				-- Apply setting to the requested column, or all columns (if col is 0)
-- 				if col == 0 or col == curCol then
-- 					mbitem = MultiboardGetItem(mb, curRow - 1, curCol - 1)
-- 					MultiboardSetItemWidth(mbitem, width / 100.0)
-- 					MultiboardReleaseItem(mbitem)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MultiboardSetItemIconBJ(mb, col, row, iconFileName)
-- 	local curRow = 0
-- 	local curCol = 0
-- 	local numRows = MultiboardGetRowCount(mb)
-- 	local numCols = MultiboardGetColumnCount(mb)
-- 	local mbitem = nil

-- 	-- Loop over rows, using 1-based index
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		curRow = curRow + 1
-- 		if curRow > numRows then break end

-- 		-- Apply setting to the requested row, or all rows (if row is 0)
-- 		if row == 0 or row == curRow then
-- 			-- Loop over columns, using 1-based index
-- 			curCol = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				curCol = curCol + 1
-- 				if curCol > numCols then break end

-- 				-- Apply setting to the requested column, or all columns (if col is 0)
-- 				if col == 0 or col == curCol then
-- 					mbitem = MultiboardGetItem(mb, curRow - 1, curCol - 1)
-- 					MultiboardSetItemIcon(mbitem, iconFileName)
-- 					MultiboardReleaseItem(mbitem)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Text Tag Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
-- Scale the font size linearly such that size 10 equates to height 0.023.
-- Screen-relative font heights are harder to grasp and than font sizes.
--
function BJ.TextTagSize2Height(size) return size * 0.023 / 10 end

-- ===========================================================================
-- Scale the speed linearly such that speed 128 equates to 0.071.
-- Screen-relative speeds are hard to grasp.
--
function BJ.TextTagSpeed2Velocity(speed) return speed * 0.071 / 128 end

-- ===========================================================================
function BJ.SetTextTagColorBJ(tt, red, green, blue, transparency)
    CJ.SetTextTagColor(tt, BJ.PercentTo255(red), BJ.PercentTo255(green),
                       BJ.PercentTo255(blue),
                       BJ.PercentTo255(100.0 - transparency))
end

-- ===========================================================================
function BJ.SetTextTagVelocityBJ(tt, speed, angle)
    local vel = BJ.TextTagSpeed2Velocity(speed)
    local xvel = vel * CJ.Cos(angle * BJ.bj_DEGTORAD)
    local yvel = vel * CJ.Sin(angle * BJ.bj_DEGTORAD)

    CJ.SetTextTagVelocity(tt, xvel, yvel)
end

-- ===========================================================================
function BJ.SetTextTagTextBJ(tt, s, size)
    local textHeight = BJ.TextTagSize2Height(size)

    CJ.SetTextTagText(tt, s, textHeight)
end

-- --===========================================================================
-- function BJ.SetTextTagPosBJ(tt, loc, zOffset)
-- 	SetTextTagPos(tt, CJ.GetLocationX(loc), CJ.GetLocationY(loc), zOffset)
-- end

-- ===========================================================================
function BJ.SetTextTagPosUnitBJ(tt, whichUnit, zOffset)
    CJ.SetTextTagPosUnit(tt, whichUnit, zOffset)
end

-- --===========================================================================
-- function BJ.SetTextTagSuspendedBJ(tt, flag)
-- 	SetTextTagSuspended(tt, flag)
-- end

-- --===========================================================================
-- function BJ.SetTextTagPermanentBJ(tt, flag)
-- 	SetTextTagPermanent(tt, flag)
-- end

-- --===========================================================================
-- function BJ.SetTextTagAgeBJ(tt, age)
-- 	SetTextTagAge(tt, age)
-- end

-- --===========================================================================
-- function BJ.SetTextTagLifespanBJ(tt, lifespan)
-- 	SetTextTagLifespan(tt, lifespan)
-- end

-- --===========================================================================
-- function BJ.SetTextTagFadepointBJ(tt, fadepoint)
-- 	SetTextTagFadepoint(tt, fadepoint)
-- end

-- --===========================================================================
-- function BJ.CreateTextTagLocBJ(s, loc, zOffset, size, red, green, blue, transparency)
-- 	bj_lastCreatedTextTag = CreateTextTag()
-- 	BJ.SetTextTagTextBJ(bj_lastCreatedTextTag, s, size)
-- 	SetTextTagPosBJ(bj_lastCreatedTextTag, loc, zOffset)
-- 	BJ.SetTextTagColorBJ(bj_lastCreatedTextTag, red, green, blue, transparency)

-- 	return bj_lastCreatedTextTag
-- end

-- --===========================================================================
-- function BJ.CreateTextTagUnitBJ(s, whichUnit, zOffset, size, red, green, blue, transparency)
-- 	bj_lastCreatedTextTag = CreateTextTag()
-- 	BJ.SetTextTagTextBJ(bj_lastCreatedTextTag, s, size)
-- 	SetTextTagPosUnitBJ(bj_lastCreatedTextTag, whichUnit, zOffset)
-- 	BJ.SetTextTagColorBJ(bj_lastCreatedTextTag, red, green, blue, transparency)

-- 	return bj_lastCreatedTextTag
-- end

-- --===========================================================================
-- function BJ.DestroyTextTagBJ(tt)
-- 	DestroyTextTag(tt)
-- end

-- --===========================================================================
-- function BJ.ShowTextTagForceBJ(show, tt, whichForce)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		SetTextTagVisibility(tt, show)
-- 	end
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedTextTag()
-- 	return bj_lastCreatedTextTag
-- end

-- --***************************************************************************
-- --*
-- --*  Cinematic Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.PauseGameOn()
-- 	CJ.PauseGame(true)
-- end

-- --===========================================================================
-- function BJ.PauseGameOff()
-- 	CJ.PauseGame(false)
-- end

-- --===========================================================================
-- function BJ.SetUserControlForceOn(whichForce)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.EnableUserControl(true)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetUserControlForceOff(whichForce)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.EnableUserControl(false)
-- 	end
-- end

-- --===========================================================================
-- function BJ.ShowInterfaceForceOn(whichForce, fadeDuration)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.ShowInterface(true, fadeDuration)
-- 	end
-- end

-- --===========================================================================
-- function BJ.ShowInterfaceForceOff(whichForce, fadeDuration)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.ShowInterface(false, fadeDuration)
-- 	end
-- end

-- --===========================================================================
-- function BJ.PingMinimapForForce(whichForce, x, y, duration)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.PingMinimap(x, y, duration)
-- 	--call CJ.StartSound(bj_pingMinimapSound)
-- 	end
-- end

-- --===========================================================================
-- function BJ.PingMinimapLocForForce(whichForce, loc, duration)
-- 	PingMinimapForForce(whichForce, CJ.GetLocationX(loc), CJ.GetLocationY(loc), duration)
-- end

-- ===========================================================================
function BJ.PingMinimapForPlayer(whichPlayer, x, y, duration)
    if CJ.GetLocalPlayer() == whichPlayer then
        -- Use only local code (no net traffic) within this block to avoid desyncs.
        CJ.PingMinimap(x, y, duration)
        -- call CJ.StartSound(bj_pingMinimapSound)
    end
end

-- --===========================================================================
-- function BJ.PingMinimapLocForPlayer(whichPlayer, loc, duration)
-- 	BJ.PingMinimapForPlayer(whichPlayer, CJ.GetLocationX(loc), CJ.GetLocationY(loc), duration)
-- end

-- --===========================================================================
-- function BJ.PingMinimapForForceEx(whichForce, x, y, duration, style, red, green, blue)
-- 	local red255 = BJ.PercentTo255(red)
-- 	local green255 = BJ.PercentTo255(green)
-- 	local blue255 = BJ.PercentTo255(blue)

-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), whichForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 		-- Prevent 100% red simple and flashy pings, as they become "attack" pings.
-- 		if red255 == 255 and green255 == 0 and blue255 == 0 then
-- 			red255 = 254
-- 		end

-- 		if style == bj_MINIMAPPINGSTYLE_SIMPLE then
-- 			PingMinimapEx(x, y, duration, red255, green255, blue255, false)
-- 		elseif style == bj_MINIMAPPINGSTYLE_FLASHY then
-- 			PingMinimapEx(x, y, duration, red255, green255, blue255, true)
-- 		elseif style == bj_MINIMAPPINGSTYLE_ATTACK then
-- 			PingMinimapEx(x, y, duration, 255, 0, 0, false)
-- 		else
-- 		-- Unrecognized ping style - ignore the request.
-- 		end

-- 	--call CJ.StartSound(bj_pingMinimapSound)
-- 	end
-- end

-- --===========================================================================
-- function BJ.PingMinimapLocForForceEx(whichForce, loc, duration, style, red, green, blue)
-- 	PingMinimapForForceEx(whichForce, CJ.GetLocationX(loc), CJ.GetLocationY(loc), duration, style, red, green, blue)
-- end

-- --===========================================================================
-- function BJ.EnableWorldFogBoundaryBJ(enable, f)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), f) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.EnableWorldFogBoundary(enable)
-- 	end
-- end

-- --===========================================================================
-- function BJ.EnableOcclusionBJ(enable, f)
-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), f) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.
-- 		CJ.EnableOcclusion(enable)
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Cinematic Transmission Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
-- If cancelled, stop the sound and end the cinematic scene.
--
function BJ.CancelCineSceneBJ()
    BJ.StopSoundBJ(BJ.bj_cineSceneLastSound, true)
    CJ.EndCinematicScene()
end

-- ===========================================================================
-- Init a trigger to listen for END_CINEMATIC events and respond to them if
-- a cinematic scene is in progress.  For performance reasons, this should
-- only be called once a cinematic scene has been started, so that maps
-- lacking such scenes do not bother to register for these events.
--
function BJ.TryInitCinematicBehaviorBJ()
    local index

    if BJ.bj_cineSceneBeingSkipped == nil then
        BJ.bj_cineSceneBeingSkipped = CJ.CreateTrigger()
        index = 0
        for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
            CJ.TriggerRegisterPlayerEvent(BJ.bj_cineSceneBeingSkipped,
                                          CJ.Player(index),
                                          CJ.EVENT_PLAYER_END_CINEMATIC)
            index = index + 1
            if index == BJ.bj_MAX_PLAYERS then break end
        end
        CJ.TriggerAddAction(BJ.bj_cineSceneBeingSkipped, BJ.CancelCineSceneBJ)
    end
end

-- ===========================================================================
function BJ.SetCinematicSceneBJ(soundHandle, portraitUnitId, color,
                                speakerTitle, text, sceneDuration,
                                voiceoverDuration)
    BJ.bj_cineSceneLastSound = soundHandle
    BJ.PlaySoundBJ(soundHandle)
    CJ.SetCinematicScene(portraitUnitId, color, speakerTitle, text,
                         sceneDuration, voiceoverDuration)
end

-- ===========================================================================
function BJ.GetTransmissionDuration(soundHandle, timeType, timeVal)
    local duration

    if timeType == BJ.bj_TIMETYPE_ADD then
        duration = BJ.GetSoundDurationBJ(soundHandle) + timeVal
    elseif timeType == BJ.bj_TIMETYPE_SET then
        duration = timeVal
    elseif timeType == BJ.bj_TIMETYPE_SUB then
        duration = BJ.GetSoundDurationBJ(soundHandle) - timeVal
    else
        -- Unrecognized timeType - ignore timeVal.
        duration = BJ.GetSoundDurationBJ(soundHandle)
    end

    -- Make sure we have a non-negative duration.
    if duration < 0 then duration = 0 end
    return duration
end

-- ===========================================================================
function BJ.WaitTransmissionDuration(soundHandle, timeType, timeVal)
    if timeType == BJ.bj_TIMETYPE_SET then
        -- If we have a static duration wait, just perform the wait.
        CJ.TriggerSleepAction(timeVal)

    elseif soundHandle == nil then
        -- If the sound does not exist, perform a default length wait.
        CJ.TriggerSleepAction(BJ.bj_NOTHING_SOUND_DURATION)

    elseif timeType == BJ.bj_TIMETYPE_SUB then
        -- If the transmission is cutting off the sound, wait for the sound
        -- to be mostly finished.
        BJ.WaitForSoundBJ(soundHandle, timeVal)

    elseif timeType == BJ.bj_TIMETYPE_ADD then
        -- If the transmission is extending beyond the sound's length, wait
        -- for it to finish, and then wait the additional time.
        BJ.WaitForSoundBJ(soundHandle, 0)
        CJ.TriggerSleepAction(timeVal)

    else
        -- Unrecognized timeType - ignore.
    end
end

-- ===========================================================================
function BJ.DoTransmissionBasicsXYBJ(unitId, color, x, y, soundHandle, unitName,
                                     message, duration)
    BJ.SetCinematicSceneBJ(soundHandle, unitId, color, unitName, message,
                           duration + BJ.bj_TRANSMISSION_PORT_HANGTIME, duration)

    if unitId ~= 0 then
        CJ.PingMinimap(x, y, BJ.bj_TRANSMISSION_PING_TIME)
        -- call SetCameraQuickPosition(x, y)
    end
end

-- ===========================================================================
-- Display a text message to a CJ.Player Group with an accompanying sound,
-- portrait, speech indicator, and all that good stuff.
--   - Query duration of sound
--   - Play sound
--   - Display text message for duration
--   - Display animating portrait for duration
--   - Display a speech indicator for the unit
--   - Ping the minimap
--
function BJ.TransmissionFromUnitWithNameBJ(toForce, whichUnit, unitName,
                                           soundHandle, message, timeType,
                                           timeVal, wait)
    BJ.TryInitCinematicBehaviorBJ()

    -- Ensure that the time value is non-negative.
    timeVal = BJ.RMaxBJ(timeVal, 0)

    BJ.bj_lastTransmissionDuration = BJ.GetTransmissionDuration(soundHandle,
                                                                timeType,
                                                                timeVal)
    BJ.bj_lastPlayedSound = soundHandle

    if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), toForce) then
        -- Use only local code (no net traffic) within this block to avoid desyncs.

        if whichUnit == nil then
            -- If the unit reference is invalid, send the transmission from the center of the map with no portrait.
            BJ.DoTransmissionBasicsXYBJ(0, CJ.PLAYER_COLOR_RED, 0, 0,
                                        soundHandle, unitName, message,
                                        BJ.bj_lastTransmissionDuration)
        else
            BJ.DoTransmissionBasicsXYBJ(CJ.GetUnitTypeId(whichUnit),
                                        CJ.GetPlayerColor(
                                            CJ.GetOwningPlayer(whichUnit)),
                                        CJ.GetUnitX(whichUnit),
                                        CJ.GetUnitY(whichUnit), soundHandle,
                                        unitName, message,
                                        BJ.bj_lastTransmissionDuration)
            if not CJ.IsUnitHidden(whichUnit) then
                CJ.UnitAddIndicator(whichUnit, BJ.bj_TRANSMISSION_IND_RED,
                                    BJ.bj_TRANSMISSION_IND_BLUE,
                                    BJ.bj_TRANSMISSION_IND_GREEN,
                                    BJ.bj_TRANSMISSION_IND_ALPHA)
            end
        end
    end

    if wait and BJ.bj_lastTransmissionDuration > 0 then
        -- call CJ.TriggerSleepAction(BJ.bj_lastTransmissionDuration)
        BJ.WaitTransmissionDuration(soundHandle, timeType, timeVal)
    end

end

-- --===========================================================================
-- -- This operates like BJ.TransmissionFromUnitWithNameBJ, but for a unit type
-- -- rather than a unit instance.  As such, no speech indicator is employed.
-- --
-- function BJ.TransmissionFromUnitTypeWithNameBJ(toForce, fromPlayer, unitId, unitName, loc, soundHandle, message, timeType, timeVal, wait)
-- 	BJ.TryInitCinematicBehaviorBJ()

-- 	-- Ensure that the time value is non-negative.
-- 	timeVal = BJ.RMaxBJ(timeVal, 0)

-- 	BJ.bj_lastTransmissionDuration = BJ.GetTransmissionDuration(soundHandle, timeType, timeVal)
-- 	BJ.bj_lastPlayedSound = soundHandle

-- 	if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), toForce) then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 		BJ.DoTransmissionBasicsXYBJ(unitId, CJ.GetPlayerColor(fromPlayer), CJ.GetLocationX(loc), CJ.GetLocationY(loc), soundHandle, unitName, message, BJ.bj_lastTransmissionDuration)
-- 	end

-- 	if wait and BJ.bj_lastTransmissionDuration > 0 then
-- 		-- call CJ.TriggerSleepAction(BJ.bj_lastTransmissionDuration)
-- 		BJ.WaitTransmissionDuration(soundHandle, timeType, timeVal)
-- 	end

-- end

-- --===========================================================================
-- function BJ.GetLastTransmissionDurationBJ()
-- 	return BJ.bj_lastTransmissionDuration
-- end

-- --===========================================================================
-- function BJ.ForceCinematicSubtitlesBJ(flag)
-- 	ForceCinematicSubtitles(flag)
-- end

-- --***************************************************************************
-- --*
-- --*  Cinematic Mode Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- -- Makes many common UI settings changes at once, for use when beginning and
-- -- ending cinematic sequences.  Note that some affects apply to all players,
-- -- such as game speed.  This is unavoidable.
-- --   - Clear the screen of text messages
-- --   - Hide interface UI (letterbox mode)
-- --   - Hide game messages (ally under attack, etc.)
-- --   - Disable user control
-- --   - Disable occlusion
-- --   - Set game speed (for all players)
-- --   - Lock game speed (for all players)
-- --   - Disable black mask (for all players)
-- --   - Disable fog of war (for all players)
-- --   - Disable world boundary fog (for all players)
-- --   - Dim non-speech sound channels
-- --   - End any outstanding music themes
-- --   - Fix the random seed to a set value
-- --   - Reset the camera smoothing factor
-- --
function BJ.CinematicModeExBJ(cineMode, forForce, interfaceFadeTime)
    -- If the game hasn't started yet, perform interface fades immediately
    if not BJ.bj_gameStarted then interfaceFadeTime = 0 end

    if cineMode then
        -- Save the UI state so that we can restore it later.
        if not BJ.bj_cineModeAlreadyIn then
            BJ.bj_cineModeAlreadyIn = true
            BJ.bj_cineModePriorSpeed = CJ.GetGameSpeed()
            BJ.bj_cineModePriorFogSetting = CJ.IsFogEnabled()
            BJ.bj_cineModePriorMaskSetting = CJ.IsFogMaskEnabled()
            BJ.bj_cineModePriorDawnDusk = BJ.IsDawnDuskEnabled()
            BJ.bj_cineModeSavedSeed = CJ.GetRandomInt(0, 1000000)
        end

        -- Perform local changes
        if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), forForce) then
            -- Use only local code (no net traffic) within this block to avoid desyncs.
            CJ.ClearTextMessages()
            CJ.ShowInterface(false, interfaceFadeTime)
            CJ.EnableUserControl(false)
            CJ.EnableOcclusion(false)
            BJ.SetCineModeVolumeGroupsBJ()
        end

        -- Perform global changes
        CJ.SetGameSpeed(BJ.bj_CINEMODE_GAMESPEED)
        CJ.SetMapFlag(CJ.MAP_LOCK_SPEED, true)
        CJ.FogMaskEnable(false)
        CJ.FogEnable(false)
        CJ.EnableWorldFogBoundary(false)
        BJ.EnableDawnDusk(false)

        -- Use a fixed random seed, so that cinematics play consistently.
        CJ.SetRandomSeed(0)
    else
        BJ.bj_cineModeAlreadyIn = false

        -- Perform local changes
        if CJ.IsPlayerInForce(CJ.GetLocalPlayer(), forForce) then
            -- Use only local code (no net traffic) within this block to avoid desyncs.
            CJ.ShowInterface(true, interfaceFadeTime)
            CJ.EnableUserControl(true)
            CJ.EnableOcclusion(true)
            CJ.VolumeGroupReset()
            CJ.EndThematicMusic()
            BJ.CameraResetSmoothingFactorBJ()
        end

        -- Perform global changes
        CJ.SetMapFlag(CJ.MAP_LOCK_SPEED, false)
        CJ.SetGameSpeed(BJ.bj_cineModePriorSpeed)
        CJ.FogMaskEnable(BJ.bj_cineModePriorMaskSetting)
        CJ.FogEnable(BJ.bj_cineModePriorFogSetting)
        CJ.EnableWorldFogBoundary(true)
        BJ.EnableDawnDusk(BJ.bj_cineModePriorDawnDusk)
        CJ.SetRandomSeed(BJ.bj_cineModeSavedSeed)
    end
end

-- ===========================================================================
function BJ.CinematicModeBJ(cineMode, forForce)
    BJ.CinematicModeExBJ(cineMode, forForce, BJ.bj_CINEMODE_INTERFACEFADE)
end

-- --***************************************************************************
-- --*
-- --*  Cinematic CJ.Filter Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.DisplayCineFilterBJ(flag)
-- 	DisplayCineFilter(flag)
-- end

-- --===========================================================================
-- function BJ.CinematicFadeCommonBJ(red, green, blue, duration, tex, startTrans, endTrans)
-- 	if duration == 0 then
-- 		-- If the fade is instant, use the same starting and ending values,
-- 		-- so that we effectively do a set rather than a fade.
-- 		startTrans = endTrans
-- 	end
-- 	CJ.EnableUserUI(false)
-- 	SetCineFilterTexture(tex)
-- 	SetCineFilterBlendMode(BLEND_MODE_BLEND)
-- 	SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
-- 	SetCineFilterStartUV(0, 0, 1, 1)
-- 	SetCineFilterEndUV(0, 0, 1, 1)
-- 	SetCineFilterStartColor(BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100 - startTrans))
-- 	SetCineFilterEndColor(BJ.PercentTo255(red), BJ.PercentTo255(green), BJ.PercentTo255(blue), BJ.PercentTo255(100 - endTrans))
-- 	SetCineFilterDuration(duration)
-- 	DisplayCineFilter(true)
-- end

-- --===========================================================================
-- function BJ.FinishCinematicFadeBJ()
-- 	CJ.DestroyTimer(bj_cineFadeFinishTimer)
-- 	bj_cineFadeFinishTimer = nil
-- 	DisplayCineFilter(false)
-- 	CJ.EnableUserUI(true)
-- end

-- --===========================================================================
-- function BJ.FinishCinematicFadeAfterBJ(duration)
-- 	-- Create a timer to end the cinematic fade.
-- 	bj_cineFadeFinishTimer = CJ.CreateTimer()
-- 	CJ.TimerStart(bj_cineFadeFinishTimer, duration, false, FinishCinematicFadeBJ)
-- end

-- --===========================================================================
-- function BJ.ContinueCinematicFadeBJ()
-- 	CJ.DestroyTimer(bj_cineFadeContinueTimer)
-- 	bj_cineFadeContinueTimer = nil
-- 	CinematicFadeCommonBJ(bj_cineFadeContinueRed, bj_cineFadeContinueGreen, bj_cineFadeContinueBlue, bj_cineFadeContinueDuration, bj_cineFadeContinueTex, bj_cineFadeContinueTrans, 100)
-- end

-- --===========================================================================
-- function BJ.ContinueCinematicFadeAfterBJ(duration, red, green, blue, trans, tex)
-- 	bj_cineFadeContinueRed = red
-- 	bj_cineFadeContinueGreen = green
-- 	bj_cineFadeContinueBlue = blue
-- 	bj_cineFadeContinueTrans = trans
-- 	bj_cineFadeContinueDuration = duration
-- 	bj_cineFadeContinueTex = tex

-- 	-- Create a timer to continue the cinematic fade.
-- 	bj_cineFadeContinueTimer = CJ.CreateTimer()
-- 	CJ.TimerStart(bj_cineFadeContinueTimer, duration, false, ContinueCinematicFadeBJ)
-- end

-- --===========================================================================
-- function BJ.AbortCinematicFadeBJ()
-- 	if bj_cineFadeContinueTimer ~= nil then
-- 		CJ.DestroyTimer(bj_cineFadeContinueTimer)
-- 	end

-- 	if bj_cineFadeFinishTimer ~= nil then
-- 		CJ.DestroyTimer(bj_cineFadeFinishTimer)
-- 	end
-- end

-- --===========================================================================
-- function BJ.CinematicFadeBJ(fadetype, duration, tex, red, green, blue, trans)
-- 	if fadetype == bj_CINEFADETYPE_FADEOUT then
-- 		-- Fade out to the requested color.
-- 		AbortCinematicFadeBJ()
-- 		CinematicFadeCommonBJ(red, green, blue, duration, tex, 100, trans)
-- 	elseif fadetype == bj_CINEFADETYPE_FADEIN then
-- 		-- Fade in from the requested color.
-- 		AbortCinematicFadeBJ()
-- 		CinematicFadeCommonBJ(red, green, blue, duration, tex, trans, 100)
-- 		FinishCinematicFadeAfterBJ(duration)
-- 	elseif fadetype == bj_CINEFADETYPE_FADEOUTIN then
-- 		-- Fade out to the requested color, and then fade back in from it.
-- 		if duration > 0 then
-- 			AbortCinematicFadeBJ()
-- 			CinematicFadeCommonBJ(red, green, blue, duration * 0.5, tex, 100, trans)
-- 			ContinueCinematicFadeAfterBJ(duration * 0.5, red, green, blue, trans, tex)
-- 			FinishCinematicFadeAfterBJ(duration)
-- 		end
-- 	else
-- 	-- Unrecognized fadetype - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.CinematicFilterGenericBJ(duration, bmode, tex, red0, green0, blue0, trans0, red1, green1, blue1, trans1)
-- 	AbortCinematicFadeBJ()
-- 	SetCineFilterTexture(tex)
-- 	SetCineFilterBlendMode(bmode)
-- 	SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
-- 	SetCineFilterStartUV(0, 0, 1, 1)
-- 	SetCineFilterEndUV(0, 0, 1, 1)
-- 	SetCineFilterStartColor(BJ.PercentTo255(red0), BJ.PercentTo255(green0), BJ.PercentTo255(blue0), BJ.PercentTo255(100 - trans0))
-- 	SetCineFilterEndColor(BJ.PercentTo255(red1), BJ.PercentTo255(green1), BJ.PercentTo255(blue1), BJ.PercentTo255(100 - trans1))
-- 	SetCineFilterDuration(duration)
-- 	DisplayCineFilter(true)
-- end

-- --***************************************************************************
-- --*
-- --*  Rescuable Unit Utility Functions
-- --*
-- --***************************************************************************

-- ===========================================================================
-- Rescues a unit for a player.  This performs the default rescue behavior,
-- including a rescue sound, flashing selection circle, ownership change,
-- and optionally a unit color change.
--
function BJ.RescueUnitBJ(whichUnit, rescuer, changeColor)
    if BJ.IsUnitDeadBJ(whichUnit) or CJ.GetOwningPlayer(whichUnit) == rescuer then
        return
    end

    CJ.StartSound(BJ.bj_rescueSound)
    CJ.SetUnitOwner(whichUnit, rescuer, changeColor)
    CJ.UnitAddIndicator(whichUnit, 0, 255, 0, 255)
    BJ.PingMinimapForPlayer(rescuer, CJ.GetUnitX(whichUnit),
                            CJ.GetUnitY(whichUnit), BJ.bj_RESCUE_PING_TIME)
end

-- ===========================================================================
function BJ.TriggerActionUnitRescuedBJ()
    local theUnit = CJ.GetTriggerUnit()

    if CJ.IsUnitType(theUnit, CJ.UNIT_TYPE_STRUCTURE) then
        BJ.RescueUnitBJ(theUnit, CJ.GetOwningPlayer(CJ.GetRescuer()),
                        BJ.bj_rescueChangeColorBldg)
    else
        BJ.RescueUnitBJ(theUnit, CJ.GetOwningPlayer(CJ.GetRescuer()),
                        BJ.bj_rescueChangeColorUnit)
    end
end

-- ===========================================================================
-- Attempt to init triggers for default rescue behavior.  For performance
-- reasons, this should only be attempted if a player is set to Rescuable,
-- or if a specific unit is thus flagged.
--
function BJ.TryInitRescuableTriggersBJ()
    local index

    if BJ.bj_rescueUnitBehavior == nil then
        BJ.bj_rescueUnitBehavior = CJ.CreateTrigger()
        index = 0
        for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
            CJ.TriggerRegisterPlayerUnitEvent(BJ.bj_rescueUnitBehavior,
                                              CJ.Player(index),
                                              CJ.EVENT_PLAYER_UNIT_RESCUED, nil)
            index = index + 1
            if index == BJ.bj_MAX_PLAYER_SLOTS then break end
        end
        CJ.TriggerAddAction(BJ.bj_rescueUnitBehavior,
                            BJ.TriggerActionUnitRescuedBJ)
    end
end

-- --===========================================================================
-- -- Determines whether or not rescued units automatically change color upon
-- -- being rescued.
-- --
-- function BJ.SetRescueUnitColorChangeBJ(changeColor)
-- 	BJ.bj_rescueChangeColorUnit = changeColor
-- end

-- --===========================================================================
-- -- Determines whether or not rescued buildings automatically change color
-- -- upon being rescued.
-- --
-- function BJ.SetRescueBuildingColorChangeBJ(changeColor)
-- 	BJ.bj_rescueChangeColorBldg = changeColor
-- end

-- --===========================================================================
-- function BJ.MakeUnitRescuableToForceBJEnum()
-- 	BJ.TryInitRescuableTriggersBJ()
-- 	SetUnitRescuable(bj_makeUnitRescuableUnit, GetEnumPlayer(), bj_makeUnitRescuableFlag)
-- end

-- --===========================================================================
-- function BJ.MakeUnitRescuableToForceBJ(whichUnit, isRescuable, whichForce)
-- 	-- Flag the unit as rescuable/unrescuable for the appropriate players.
-- 	bj_makeUnitRescuableUnit = whichUnit
-- 	bj_makeUnitRescuableFlag = isRescuable
-- 	ForForce(whichForce, MakeUnitRescuableToForceBJEnum)
-- end

-- ===========================================================================
function BJ.InitRescuableBehaviorBJ()
    local index

    index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        -- If at least one player slot is "Rescuable"-controlled, init the
        -- rescue behavior triggers.
        if CJ.GetPlayerController(CJ.Player(index)) == CJ.MAP_CONTROL_RESCUABLE then
            BJ.TryInitRescuableTriggersBJ()
            return
        end
        index = index + 1
        if index == BJ.bj_MAX_PLAYERS then break end
    end
end

-- --***************************************************************************
-- --*
-- --*  Research and Upgrade Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.SetPlayerTechResearchedSwap(techid, levels, whichPlayer)
-- 	SetPlayerTechResearched(whichPlayer, techid, levels)
-- end

-- --===========================================================================
-- function BJ.SetPlayerTechMaxAllowedSwap(techid, maximum, whichPlayer)
-- 	CJ.SetPlayerTechMaxAllowed(whichPlayer, techid, maximum)
-- end

-- --===========================================================================
-- function BJ.SetPlayerMaxHeroesAllowed(maximum, whichPlayer)
-- 	CJ.SetPlayerTechMaxAllowed(whichPlayer, 1212502607, maximum)
-- end

-- --===========================================================================
-- function BJ.GetPlayerTechCountSimple(techid, whichPlayer)
-- 	return GetPlayerTechCount(whichPlayer, techid, true)
-- end

-- --===========================================================================
-- function BJ.GetPlayerTechMaxAllowedSwap(techid, whichPlayer)
-- 	return GetPlayerTechMaxAllowed(whichPlayer, techid)
-- end

-- --===========================================================================
-- function BJ.SetPlayerAbilityAvailableBJ(avail, abilid, whichPlayer)
-- 	SetPlayerAbilityAvailable(whichPlayer, abilid, avail)
-- end

-- --***************************************************************************
-- --*
-- --*  Campaign Utility Functions
-- --*
-- --***************************************************************************

-- function BJ.SetCampaignMenuRaceBJ(campaignNumber)
-- 	if campaignNumber == bj_CAMPAIGN_INDEX_T then
-- 		SetCampaignMenuRace(RACE_OTHER)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_H then
-- 		SetCampaignMenuRace(RACE_HUMAN)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_U then
-- 		SetCampaignMenuRace(RACE_UNDEAD)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_O then
-- 		SetCampaignMenuRace(RACE_ORC)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_N then
-- 		SetCampaignMenuRace(RACE_NIGHTELF)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XN then
-- 		SetCampaignMenuRaceEx(bj_CAMPAIGN_OFFSET_XN)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XH then
-- 		SetCampaignMenuRaceEx(bj_CAMPAIGN_OFFSET_XH)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XU then
-- 		SetCampaignMenuRaceEx(bj_CAMPAIGN_OFFSET_XU)
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XO then
-- 		SetCampaignMenuRaceEx(bj_CAMPAIGN_OFFSET_XO)
-- 	else
-- 	-- Unrecognized campaign - ignore the request
-- 	end
-- end

-- --===========================================================================
-- -- Converts a single campaign mission designation into campaign and mission
-- -- numbers.  The 1000's digit is considered the campaign index, and the 1's
-- -- digit is considered the mission index within that campaign.  This is done
-- -- so that the trigger for this can use a single drop-down to list all of
-- -- the campaign missions.
-- --
-- function BJ.SetMissionAvailableBJ(available, missionIndex)
-- 	local campaignNumber = missionIndex // 1000
-- 	local missionNumber = missionIndex - campaignNumber * 1000

-- 	SetMissionAvailable(campaignNumber, missionNumber, available)
-- end

-- --===========================================================================
-- function BJ.SetCampaignAvailableBJ(available, campaignNumber)
-- 	local campaignOffset

-- 	if campaignNumber == bj_CAMPAIGN_INDEX_H then
-- 		SetTutorialCleared(true)
-- 	end

-- 	if campaignNumber == bj_CAMPAIGN_INDEX_XN then
-- 		campaignOffset = bj_CAMPAIGN_OFFSET_XN
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XH then
-- 		campaignOffset = bj_CAMPAIGN_OFFSET_XH
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XU then
-- 		campaignOffset = bj_CAMPAIGN_OFFSET_XU
-- 	elseif campaignNumber == bj_CAMPAIGN_INDEX_XO then
-- 		campaignOffset = bj_CAMPAIGN_OFFSET_XO
-- 	else
-- 		campaignOffset = campaignNumber
-- 	end

-- 	SetCampaignAvailable(campaignOffset, available)
-- 	SetCampaignMenuRaceBJ(campaignNumber)
-- 	ForceCampaignSelectScreen()
-- end

-- --===========================================================================
-- function BJ.SetCinematicAvailableBJ(available, cinematicIndex)
-- 	if cinematicIndex == bj_CINEMATICINDEX_TOP then
-- 		SetOpCinematicAvailable(bj_CAMPAIGN_INDEX_T, available)
-- 		PlayCinematic("TutorialOp")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_HOP then
-- 		SetOpCinematicAvailable(bj_CAMPAIGN_INDEX_H, available)
-- 		PlayCinematic("HumanOp")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_HED then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_H, available)
-- 		PlayCinematic("HumanEd")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_OOP then
-- 		SetOpCinematicAvailable(bj_CAMPAIGN_INDEX_O, available)
-- 		PlayCinematic("OrcOp")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_OED then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_O, available)
-- 		PlayCinematic("OrcEd")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_UOP then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_U, available)
-- 		PlayCinematic("UndeadOp")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_UED then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_U, available)
-- 		PlayCinematic("UndeadEd")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_NOP then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_N, available)
-- 		PlayCinematic("NightElfOp")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_NED then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_N, available)
-- 		PlayCinematic("NightElfEd")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_XOP then
-- 		SetOpCinematicAvailable(bj_CAMPAIGN_OFFSET_XN, available)
-- 		PlayCinematic("IntroX")
-- 	elseif cinematicIndex == bj_CINEMATICINDEX_XED then
-- 		SetEdCinematicAvailable(bj_CAMPAIGN_OFFSET_XU, available)
-- 		PlayCinematic("OutroX")
-- 	else
-- 	-- Unrecognized cinematic - ignore the request.
-- 	end
-- end

-- --===========================================================================
-- function BJ.InitGameCacheBJ(campaignFile)
-- 	bj_lastCreatedGameCache = InitGameCache(campaignFile)
-- 	return bj_lastCreatedGameCache
-- end

-- --===========================================================================
-- function BJ.SaveGameCacheBJ(cache)
-- 	return SaveGameCache(cache)
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedGameCacheBJ()
-- 	return bj_lastCreatedGameCache
-- end

-- --===========================================================================
-- function BJ.InitHashtableBJ()
-- 	bj_lastCreatedHashtable = InitHashtable()
-- 	return bj_lastCreatedHashtable
-- end

-- --===========================================================================
-- function BJ.GetLastCreatedHashtableBJ()
-- 	return bj_lastCreatedHashtable
-- end

-- --===========================================================================
-- function BJ.StoreRealBJ(value, key, missionKey, cache)
-- 	StoreReal(cache, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.StoreIntegerBJ(value, key, missionKey, cache)
-- 	StoreInteger(cache, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.StoreBooleanBJ(value, key, missionKey, cache)
-- 	StoreBoolean(cache, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.StoreStringBJ(value, key, missionKey, cache)
-- 	return StoreString(cache, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.StoreUnitBJ(whichUnit, key, missionKey, cache)
-- 	return StoreUnit(cache, missionKey, key, whichUnit)
-- end

-- --===========================================================================
-- function BJ.SaveRealBJ(value, key, missionKey, table)
-- 	SaveReal(table, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.SaveIntegerBJ(value, key, missionKey, table)
-- 	SaveInteger(table, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.SaveBooleanBJ(value, key, missionKey, table)
-- 	SaveBoolean(table, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.SaveStringBJ(value, key, missionKey, table)
-- 	return SaveStr(table, missionKey, key, value)
-- end

-- --===========================================================================
-- function BJ.SavePlayerHandleBJ(whichPlayer, key, missionKey, table)
-- 	return SavePlayerHandle(table, missionKey, key, whichPlayer)
-- end

-- --===========================================================================
-- function BJ.SaveWidgetHandleBJ(whichWidget, key, missionKey, table)
-- 	return SaveWidgetHandle(table, missionKey, key, whichWidget)
-- end

-- --===========================================================================
-- function BJ.SaveDestructableHandleBJ(whichDestructable, key, missionKey, table)
-- 	return SaveDestructableHandle(table, missionKey, key, whichDestructable)
-- end

-- --===========================================================================
-- function BJ.SaveItemHandleBJ(whichItem, key, missionKey, table)
-- 	return SaveItemHandle(table, missionKey, key, whichItem)
-- end

-- --===========================================================================
-- function BJ.SaveUnitHandleBJ(whichUnit, key, missionKey, table)
-- 	return SaveUnitHandle(table, missionKey, key, whichUnit)
-- end

-- --===========================================================================
-- function BJ.SaveAbilityHandleBJ(whichAbility, key, missionKey, table)
-- 	return SaveAbilityHandle(table, missionKey, key, whichAbility)
-- end

-- --===========================================================================
-- function BJ.SaveTimerHandleBJ(whichTimer, key, missionKey, table)
-- 	return SaveTimerHandle(table, missionKey, key, whichTimer)
-- end

-- --===========================================================================
-- function BJ.SaveTriggerHandleBJ(whichTrigger, key, missionKey, table)
-- 	return SaveTriggerHandle(table, missionKey, key, whichTrigger)
-- end

-- --===========================================================================
-- function BJ.SaveTriggerConditionHandleBJ(whichTriggercondition, key, missionKey, table)
-- 	return SaveTriggerConditionHandle(table, missionKey, key, whichTriggercondition)
-- end

-- --===========================================================================
-- function BJ.SaveTriggerActionHandleBJ(whichTriggeraction, key, missionKey, table)
-- 	return SaveTriggerActionHandle(table, missionKey, key, whichTriggeraction)
-- end

-- --===========================================================================
-- function BJ.SaveTriggerEventHandleBJ(whichEvent, key, missionKey, table)
-- 	return SaveTriggerEventHandle(table, missionKey, key, whichEvent)
-- end

-- --===========================================================================
-- function BJ.SaveForceHandleBJ(whichForce, key, missionKey, table)
-- 	return SaveForceHandle(table, missionKey, key, whichForce)
-- end

-- --===========================================================================
-- function BJ.SaveGroupHandleBJ(whichGroup, key, missionKey, table)
-- 	return SaveGroupHandle(table, missionKey, key, whichGroup)
-- end

-- --===========================================================================
-- function BJ.SaveLocationHandleBJ(whichLocation, key, missionKey, table)
-- 	return SaveLocationHandle(table, missionKey, key, whichLocation)
-- end

-- --===========================================================================
-- function BJ.SaveRectHandleBJ(whichRect, key, missionKey, table)
-- 	return SaveRectHandle(table, missionKey, key, whichRect)
-- end

-- --===========================================================================
-- function BJ.SaveBooleanExprHandleBJ(whichBoolexpr, key, missionKey, table)
-- 	return SaveBooleanExprHandle(table, missionKey, key, whichBoolexpr)
-- end

-- --===========================================================================
-- function BJ.SaveSoundHandleBJ(whichSound, key, missionKey, table)
-- 	return SaveSoundHandle(table, missionKey, key, whichSound)
-- end

-- --===========================================================================
-- function BJ.SaveEffectHandleBJ(whichEffect, key, missionKey, table)
-- 	return SaveEffectHandle(table, missionKey, key, whichEffect)
-- end

-- --===========================================================================
-- function BJ.SaveUnitPoolHandleBJ(whichUnitpool, key, missionKey, table)
-- 	return SaveUnitPoolHandle(table, missionKey, key, whichUnitpool)
-- end

-- --===========================================================================
-- function BJ.SaveItemPoolHandleBJ(whichItempool, key, missionKey, table)
-- 	return SaveItemPoolHandle(table, missionKey, key, whichItempool)
-- end

-- --===========================================================================
-- function BJ.SaveQuestHandleBJ(whichQuest, key, missionKey, table)
-- 	return SaveQuestHandle(table, missionKey, key, whichQuest)
-- end

-- --===========================================================================
-- function BJ.SaveQuestItemHandleBJ(whichQuestitem, key, missionKey, table)
-- 	return SaveQuestItemHandle(table, missionKey, key, whichQuestitem)
-- end

-- --===========================================================================
-- function BJ.SaveDefeatConditionHandleBJ(whichDefeatcondition, key, missionKey, table)
-- 	return SaveDefeatConditionHandle(table, missionKey, key, whichDefeatcondition)
-- end

-- --===========================================================================
-- function BJ.SaveTimerDialogHandleBJ(whichTimerdialog, key, missionKey, table)
-- 	return SaveTimerDialogHandle(table, missionKey, key, whichTimerdialog)
-- end

-- --===========================================================================
-- function BJ.SaveLeaderboardHandleBJ(whichLeaderboard, key, missionKey, table)
-- 	return SaveLeaderboardHandle(table, missionKey, key, whichLeaderboard)
-- end

-- --===========================================================================
-- function BJ.SaveMultiboardHandleBJ(whichMultiboard, key, missionKey, table)
-- 	return SaveMultiboardHandle(table, missionKey, key, whichMultiboard)
-- end

-- --===========================================================================
-- function BJ.SaveMultiboardItemHandleBJ(whichMultiboarditem, key, missionKey, table)
-- 	return SaveMultiboardItemHandle(table, missionKey, key, whichMultiboarditem)
-- end

-- --===========================================================================
-- function BJ.SaveTrackableHandleBJ(whichTrackable, key, missionKey, table)
-- 	return SaveTrackableHandle(table, missionKey, key, whichTrackable)
-- end

-- --===========================================================================
-- function BJ.SaveDialogHandleBJ(whichDialog, key, missionKey, table)
-- 	return SaveDialogHandle(table, missionKey, key, whichDialog)
-- end

-- --===========================================================================
-- function BJ.SaveButtonHandleBJ(whichButton, key, missionKey, table)
-- 	return SaveButtonHandle(table, missionKey, key, whichButton)
-- end

-- --===========================================================================
-- function BJ.SaveTextTagHandleBJ(whichTexttag, key, missionKey, table)
-- 	return SaveTextTagHandle(table, missionKey, key, whichTexttag)
-- end

-- --===========================================================================
-- function BJ.SaveLightningHandleBJ(whichLightning, key, missionKey, table)
-- 	return SaveLightningHandle(table, missionKey, key, whichLightning)
-- end

-- --===========================================================================
-- function BJ.SaveImageHandleBJ(whichImage, key, missionKey, table)
-- 	return SaveImageHandle(table, missionKey, key, whichImage)
-- end

-- --===========================================================================
-- function BJ.SaveUbersplatHandleBJ(whichUbersplat, key, missionKey, table)
-- 	return SaveUbersplatHandle(table, missionKey, key, whichUbersplat)
-- end

-- --===========================================================================
-- function BJ.SaveRegionHandleBJ(whichRegion, key, missionKey, table)
-- 	return SaveRegionHandle(table, missionKey, key, whichRegion)
-- end

-- --===========================================================================
-- function BJ.SaveFogStateHandleBJ(whichFogState, key, missionKey, table)
-- 	return SaveFogStateHandle(table, missionKey, key, whichFogState)
-- end

-- --===========================================================================
-- function BJ.SaveFogModifierHandleBJ(whichFogModifier, key, missionKey, table)
-- 	return SaveFogModifierHandle(table, missionKey, key, whichFogModifier)
-- end

-- --===========================================================================
-- function BJ.SaveAgentHandleBJ(whichAgent, key, missionKey, table)
-- 	return SaveAgentHandle(table, missionKey, key, whichAgent)
-- end

-- --===========================================================================
-- function BJ.SaveHashtableHandleBJ(whichHashtable, key, missionKey, table)
-- 	return SaveHashtableHandle(table, missionKey, key, whichHashtable)
-- end

-- --===========================================================================
-- function BJ.GetStoredRealBJ(key, missionKey, cache)
-- 	--call SyncStoredReal(cache, missionKey, key)
-- 	return GetStoredReal(cache, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.GetStoredIntegerBJ(key, missionKey, cache)
-- 	--call SyncStoredInteger(cache, missionKey, key)
-- 	return GetStoredInteger(cache, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.GetStoredBooleanBJ(key, missionKey, cache)
-- 	--call SyncStoredBoolean(cache, missionKey, key)
-- 	return GetStoredBoolean(cache, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.GetStoredStringBJ(key, missionKey, cache)
-- 	local s

-- 	--call SyncStoredString(cache, missionKey, key)
-- 	s = GetStoredString(cache, missionKey, key)
-- 	if s == nil then
-- 		return ""
-- 	else
-- 		return s
-- 	end
-- end

-- --===========================================================================
-- function BJ.LoadRealBJ(key, missionKey, table)
-- 	--call SyncStoredReal(table, missionKey, key)
-- 	return LoadReal(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadIntegerBJ(key, missionKey, table)
-- 	--call SyncStoredInteger(table, missionKey, key)
-- 	return LoadInteger(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadBooleanBJ(key, missionKey, table)
-- 	--call SyncStoredBoolean(table, missionKey, key)
-- 	return LoadBoolean(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadStringBJ(key, missionKey, table)
-- 	local s

-- 	--call SyncStoredString(table, missionKey, key)
-- 	s = LoadStr(table, missionKey, key)
-- 	if s == nil then
-- 		return ""
-- 	else
-- 		return s
-- 	end
-- end

-- --===========================================================================
-- function BJ.LoadPlayerHandleBJ(key, missionKey, table)
-- 	return LoadPlayerHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadWidgetHandleBJ(key, missionKey, table)
-- 	return LoadWidgetHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadDestructableHandleBJ(key, missionKey, table)
-- 	return LoadDestructableHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadItemHandleBJ(key, missionKey, table)
-- 	return LoadItemHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadUnitHandleBJ(key, missionKey, table)
-- 	return LoadUnitHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadAbilityHandleBJ(key, missionKey, table)
-- 	return LoadAbilityHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTimerHandleBJ(key, missionKey, table)
-- 	return LoadTimerHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTriggerHandleBJ(key, missionKey, table)
-- 	return LoadTriggerHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTriggerConditionHandleBJ(key, missionKey, table)
-- 	return LoadTriggerConditionHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTriggerActionHandleBJ(key, missionKey, table)
-- 	return LoadTriggerActionHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTriggerEventHandleBJ(key, missionKey, table)
-- 	return LoadTriggerEventHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadForceHandleBJ(key, missionKey, table)
-- 	return LoadForceHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadGroupHandleBJ(key, missionKey, table)
-- 	return LoadGroupHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadLocationHandleBJ(key, missionKey, table)
-- 	return LoadLocationHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadRectHandleBJ(key, missionKey, table)
-- 	return LoadRectHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadBooleanExprHandleBJ(key, missionKey, table)
-- 	return LoadBooleanExprHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadSoundHandleBJ(key, missionKey, table)
-- 	return LoadSoundHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadEffectHandleBJ(key, missionKey, table)
-- 	return LoadEffectHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadUnitPoolHandleBJ(key, missionKey, table)
-- 	return LoadUnitPoolHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadItemPoolHandleBJ(key, missionKey, table)
-- 	return LoadItemPoolHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadQuestHandleBJ(key, missionKey, table)
-- 	return LoadQuestHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadQuestItemHandleBJ(key, missionKey, table)
-- 	return LoadQuestItemHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadDefeatConditionHandleBJ(key, missionKey, table)
-- 	return LoadDefeatConditionHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTimerDialogHandleBJ(key, missionKey, table)
-- 	return LoadTimerDialogHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadLeaderboardHandleBJ(key, missionKey, table)
-- 	return LoadLeaderboardHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadMultiboardHandleBJ(key, missionKey, table)
-- 	return LoadMultiboardHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadMultiboardItemHandleBJ(key, missionKey, table)
-- 	return LoadMultiboardItemHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTrackableHandleBJ(key, missionKey, table)
-- 	return LoadTrackableHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadDialogHandleBJ(key, missionKey, table)
-- 	return LoadDialogHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadButtonHandleBJ(key, missionKey, table)
-- 	return LoadButtonHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadTextTagHandleBJ(key, missionKey, table)
-- 	return LoadTextTagHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadLightningHandleBJ(key, missionKey, table)
-- 	return LoadLightningHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadImageHandleBJ(key, missionKey, table)
-- 	return LoadImageHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadUbersplatHandleBJ(key, missionKey, table)
-- 	return LoadUbersplatHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadRegionHandleBJ(key, missionKey, table)
-- 	return LoadRegionHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadFogStateHandleBJ(key, missionKey, table)
-- 	return LoadFogStateHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadFogModifierHandleBJ(key, missionKey, table)
-- 	return LoadFogModifierHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.LoadHashtableHandleBJ(key, missionKey, table)
-- 	return LoadHashtableHandle(table, missionKey, key)
-- end

-- --===========================================================================
-- function BJ.RestoreUnitLocFacingAngleBJ(key, missionKey, cache, forWhichPlayer, loc, facing)
-- 	--call SyncStoredUnit(cache, missionKey, key)
-- 	bj_lastLoadedUnit = RestoreUnit(cache, missionKey, key, forWhichPlayer, CJ.GetLocationX(loc), CJ.GetLocationY(loc), facing)
-- 	return bj_lastLoadedUnit
-- end

-- --===========================================================================
-- function BJ.RestoreUnitLocFacingPointBJ(key, missionKey, cache, forWhichPlayer, loc, lookAt)
-- 	--call SyncStoredUnit(cache, missionKey, key)
-- 	return RestoreUnitLocFacingAngleBJ(key, missionKey, cache, forWhichPlayer, loc, BJ.AngleBetweenPoints(loc, lookAt))
-- end

-- --===========================================================================
-- function BJ.GetLastRestoredUnitBJ()
-- 	return bj_lastLoadedUnit
-- end

-- --===========================================================================
-- function BJ.FlushGameCacheBJ(cache)
-- 	FlushGameCache(cache)
-- end

-- --===========================================================================
-- function BJ.FlushStoredMissionBJ(missionKey, cache)
-- 	FlushStoredMission(cache, missionKey)
-- end

-- --===========================================================================
-- function BJ.FlushParentHashtableBJ(table)
-- 	FlushParentHashtable(table)
-- end

-- --===========================================================================
-- function BJ.FlushChildHashtableBJ(missionKey, table)
-- 	FlushChildHashtable(table, missionKey)
-- end

-- --===========================================================================
-- function BJ.HaveStoredValue(key, valueType, missionKey, cache)
-- 	if valueType == bj_GAMECACHE_BOOLEAN then
-- 		return HaveStoredBoolean(cache, missionKey, key)
-- 	elseif valueType == bj_GAMECACHE_INTEGER then
-- 		return HaveStoredInteger(cache, missionKey, key)
-- 	elseif valueType == bj_GAMECACHE_REAL then
-- 		return HaveStoredReal(cache, missionKey, key)
-- 	elseif valueType == bj_GAMECACHE_UNIT then
-- 		return HaveStoredUnit(cache, missionKey, key)
-- 	elseif valueType == bj_GAMECACHE_STRING then
-- 		return HaveStoredString(cache, missionKey, key)
-- 	else
-- 		-- Unrecognized value type - ignore the request.
-- 		return false
-- 	end
-- end

-- --===========================================================================
-- function BJ.HaveSavedValue(key, valueType, missionKey, table)
-- 	if valueType == bj_HASHTABLE_BOOLEAN then
-- 		return HaveSavedBoolean(table, missionKey, key)
-- 	elseif valueType == bj_HASHTABLE_INTEGER then
-- 		return HaveSavedInteger(table, missionKey, key)
-- 	elseif valueType == bj_HASHTABLE_REAL then
-- 		return HaveSavedReal(table, missionKey, key)
-- 	elseif valueType == bj_HASHTABLE_STRING then
-- 		return HaveSavedString(table, missionKey, key)
-- 	elseif valueType == bj_HASHTABLE_HANDLE then
-- 		return HaveSavedHandle(table, missionKey, key)
-- 	else
-- 		-- Unrecognized value type - ignore the request.
-- 		return false
-- 	end
-- end

-- --===========================================================================
-- function BJ.ShowCustomCampaignButton(show, whichButton)
-- 	SetCustomCampaignButtonVisible(whichButton - 1, show)
-- end

-- --===========================================================================
-- function BJ.IsCustomCampaignButtonVisibile(whichButton)
-- 	return GetCustomCampaignButtonVisible(whichButton - 1)
-- end

-- --===========================================================================
-- function BJ.LoadGameBJ(loadFileName, doScoreScreen)
-- 	LoadGame(loadFileName, doScoreScreen)
-- end

-- --===========================================================================
-- function BJ.SaveAndChangeLevelBJ(saveFileName, newLevel, doScoreScreen)
-- 	SaveGame(saveFileName)
-- 	CJ.ChangeLevel(newLevel, doScoreScreen)
-- end

-- --===========================================================================
-- function BJ.SaveAndLoadGameBJ(saveFileName, loadFileName, doScoreScreen)
-- 	SaveGame(saveFileName)
-- 	LoadGame(loadFileName, doScoreScreen)
-- end

-- --===========================================================================
-- function BJ.RenameSaveDirectoryBJ(sourceDirName, destDirName)
-- 	return RenameSaveDirectory(sourceDirName, destDirName)
-- end

-- --===========================================================================
-- function BJ.RemoveSaveDirectoryBJ(sourceDirName)
-- 	return RemoveSaveDirectory(sourceDirName)
-- end

-- --===========================================================================
-- function BJ.CopySaveGameBJ(sourceSaveName, destSaveName)
-- 	return CopySaveGame(sourceSaveName, destSaveName)
-- end

-- --***************************************************************************
-- --*
-- --*  Miscellaneous Utility Functions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.GetPlayerStartLocationX(whichPlayer)
-- 	return GetStartLocationX(GetPlayerStartLocation(whichPlayer))
-- end

-- --===========================================================================
-- function BJ.GetPlayerStartLocationY(whichPlayer)
-- 	return GetStartLocationY(GetPlayerStartLocation(whichPlayer))
-- end

-- --===========================================================================
-- function BJ.GetPlayerStartLocationLoc(whichPlayer)
-- 	return GetStartLocationLoc(GetPlayerStartLocation(whichPlayer))
-- end

-- ===========================================================================
function BJ.GetRectCenter(whichRect)
    return CJ.Location(CJ.GetRectCenterX(whichRect),
                       CJ.GetRectCenterY(whichRect))
end

-- --===========================================================================
-- function BJ.IsPlayerSlotState(whichPlayer, whichState)
-- 	return CJ.GetPlayerSlotState(whichPlayer) == whichState
-- end

-- --===========================================================================
-- function BJ.GetFadeFromSeconds(seconds)
-- 	if seconds ~= 0 then
-- 		return 128 // CJ.R2I(seconds)
-- 	end
-- 	return 10000
-- end

-- --===========================================================================
-- function BJ.GetFadeFromSecondsAsReal(seconds)
-- 	if seconds ~= 0 then
-- 		return 128.0 / seconds
-- 	end
-- 	return 10000.0
-- end

-- --===========================================================================
-- function BJ.AdjustPlayerStateSimpleBJ(whichPlayer, whichPlayerState, delta)
-- 	CJ.SetPlayerState(whichPlayer, whichPlayerState, GetPlayerState(whichPlayer, whichPlayerState) + delta)
-- end

-- --===========================================================================
-- function BJ.AdjustPlayerStateBJ(delta, whichPlayer, whichPlayerState)
-- 	-- If the change was positive, apply the difference to the player's
-- 	-- gathered resources property as well.
-- 	if delta > 0 then
-- 		if whichPlayerState == PLAYER_STATE_RESOURCE_GOLD then
-- 			AdjustPlayerStateSimpleBJ(whichPlayer, PLAYER_STATE_GOLD_GATHERED, delta)
-- 		elseif whichPlayerState == PLAYER_STATE_RESOURCE_LUMBER then
-- 			AdjustPlayerStateSimpleBJ(whichPlayer, PLAYER_STATE_LUMBER_GATHERED, delta)
-- 		end
-- 	end

-- 	AdjustPlayerStateSimpleBJ(whichPlayer, whichPlayerState, delta)
-- end

-- --===========================================================================
-- function BJ.SetPlayerStateBJ(whichPlayer, whichPlayerState, value)
-- 	local oldValue = GetPlayerState(whichPlayer, whichPlayerState)
-- 	AdjustPlayerStateBJ(value - oldValue, whichPlayer, whichPlayerState)
-- end

-- --===========================================================================
-- function BJ.SetPlayerFlagBJ(whichPlayerFlag, flag, whichPlayer)
-- 	CJ.SetPlayerState(whichPlayer, whichPlayerFlag, IntegerTertiaryOp(flag, 1, 0))
-- end

-- --===========================================================================
-- function BJ.SetPlayerTaxRateBJ(rate, whichResource, sourcePlayer, otherPlayer)
-- 	SetPlayerTaxRate(sourcePlayer, otherPlayer, whichResource, rate)
-- end

-- --===========================================================================
-- function BJ.GetPlayerTaxRateBJ(whichResource, sourcePlayer, otherPlayer)
-- 	return GetPlayerTaxRate(sourcePlayer, otherPlayer, whichResource)
-- end

-- --===========================================================================
-- function BJ.IsPlayerFlagSetBJ(whichPlayerFlag, whichPlayer)
-- 	return GetPlayerState(whichPlayer, whichPlayerFlag) == 1
-- end

-- --===========================================================================
-- function BJ.AddResourceAmountBJ(delta, whichUnit)
-- 	AddResourceAmount(whichUnit, delta)
-- end

-- ===========================================================================
function BJ.GetConvertedPlayerId(whichPlayer)
    return CJ.GetPlayerId(whichPlayer) + 1
end

-- ===========================================================================
function BJ.ConvertedPlayer(convertedPlayerId)
    return CJ.Player(convertedPlayerId - 1)
end

-- --===========================================================================
-- function BJ.GetRectWidthBJ(r)
-- 	return CJ.GetRectMaxX(r) - CJ.GetRectMinX(r)
-- end

-- --===========================================================================
-- function BJ.GetRectHeightBJ(r)
-- 	return CJ.GetRectMaxY(r) - CJ.GetRectMinY(r)
-- end

-- --===========================================================================
-- -- Replaces a gold mine with a blighted gold mine for the given player.
-- --
-- function BJ.BlightGoldMineForPlayerBJ(goldMine, whichPlayer)
-- 	local mineX
-- 	local mineY
-- 	local mineGold
-- 	local newMine

-- 	-- Make sure we're replacing a Gold Mine and not some other type of unit.
-- 	if CJ.GetUnitTypeId(goldMine) ~= 1852272492 then
-- 		return nil
-- 	end

-- 	-- Save the Gold Mine's properties and remove it.
-- 	mineX = CJ.GetUnitX(goldMine)
-- 	mineY = CJ.GetUnitY(goldMine)
-- 	mineGold = GetResourceAmount(goldMine)
-- 	RemoveUnit(goldMine)

-- 	-- Create a Haunted Gold Mine to replace the Gold Mine.
-- 	newMine = CJ.CreateBlightedGoldmine(whichPlayer, mineX, mineY, BJ.bj_UNIT_FACING)
-- 	SetResourceAmount(newMine, mineGold)
-- 	return newMine
-- end

-- --===========================================================================
-- function BJ.BlightGoldMineForPlayer(goldMine, whichPlayer)
-- 	bj_lastHauntedGoldMine = BlightGoldMineForPlayerBJ(goldMine, whichPlayer)
-- 	return bj_lastHauntedGoldMine
-- end

-- --===========================================================================
-- function BJ.GetLastHauntedGoldMine()
-- 	return bj_lastHauntedGoldMine
-- end

-- --===========================================================================
-- function BJ.IsPointBlightedBJ(where)
-- 	return IsPointBlighted(CJ.GetLocationX(where), CJ.GetLocationY(where))
-- end

-- --===========================================================================
-- function BJ.SetPlayerColorBJEnum()
-- 	SetUnitColor(CJ.GetEnumUnit(), bj_setPlayerTargetColor)
-- end

-- --===========================================================================
-- function BJ.SetPlayerColorBJ(whichPlayer, color, changeExisting)
-- 	local g

-- 	SetPlayerColor(whichPlayer, color)
-- 	if changeExisting then
-- 		bj_setPlayerTargetColor = color
-- 		g = CJ.CreateGroup()
-- 		GroupEnumUnitsOfPlayer(g, whichPlayer, nil)
-- 		CJ.ForGroup(g, SetPlayerColorBJEnum)
-- 		CJ.DestroyGroup(g)
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetPlayerUnitAvailableBJ(unitId, allowed, whichPlayer)
-- 	if allowed then
-- 		CJ.SetPlayerTechMaxAllowed(whichPlayer, unitId, -1)
-- 	else
-- 		CJ.SetPlayerTechMaxAllowed(whichPlayer, unitId, 0)
-- 	end
-- end

--===========================================================================
function BJ.LockGameSpeedBJ()
	CJ.SetMapFlag(CJ.MAP_LOCK_SPEED, true)
end

--===========================================================================
function BJ.UnlockGameSpeedBJ()
	CJ.SetMapFlag(CJ.MAP_LOCK_SPEED, false)
end

-- --===========================================================================
-- function BJ.IssueTargetOrderBJ(whichUnit, order, targetWidget)
-- 	return IssueTargetOrder(whichUnit, order, targetWidget)
-- end

-- --===========================================================================
-- function BJ.IssuePointOrderLocBJ(whichUnit, order, whichLocation)
-- 	return CJ.IssuePointOrderLoc(whichUnit, order, whichLocation)
-- end

-- --===========================================================================
-- -- Two distinct trigger actions can't share the same function BJ.name, so this
-- -- dummy function BJ.simply mimics the behavior of an existing call.
-- --
-- function BJ.IssueTargetDestructableOrder(whichUnit, order, targetWidget)
-- 	return IssueTargetOrder(whichUnit, order, targetWidget)
-- end

-- function BJ.IssueTargetItemOrder(whichUnit, order, targetWidget)
-- 	return IssueTargetOrder(whichUnit, order, targetWidget)
-- end

-- --===========================================================================
-- function BJ.IssueImmediateOrderBJ(whichUnit, order)
-- 	return IssueImmediateOrder(whichUnit, order)
-- end

-- --===========================================================================
-- function BJ.GroupTargetOrderBJ(whichGroup, order, targetWidget)
-- 	return GroupTargetOrder(whichGroup, order, targetWidget)
-- end

-- --===========================================================================
-- function BJ.GroupPointOrderLocBJ(whichGroup, order, whichLocation)
-- 	return GroupPointOrderLoc(whichGroup, order, whichLocation)
-- end

-- --===========================================================================
-- function BJ.GroupImmediateOrderBJ(whichGroup, order)
-- 	return GroupImmediateOrder(whichGroup, order)
-- end

-- --===========================================================================
-- -- Two distinct trigger actions can't share the same function BJ.name, so this
-- -- dummy function BJ.simply mimics the behavior of an existing call.
-- --
-- function BJ.GroupTargetDestructableOrder(whichGroup, order, targetWidget)
-- 	return GroupTargetOrder(whichGroup, order, targetWidget)
-- end

-- function BJ.GroupTargetItemOrder(whichGroup, order, targetWidget)
-- 	return GroupTargetOrder(whichGroup, order, targetWidget)
-- end

-- --===========================================================================
-- function BJ.GetDyingDestructable()
-- 	return GetTriggerDestructable()
-- end

-- --===========================================================================
-- -- Rally point setting
-- --
-- function BJ.SetUnitRallyPoint(whichUnit, targPos)
-- 	IssuePointOrderLocBJ(whichUnit, "setrally", targPos)
-- end

-- --===========================================================================
-- function BJ.SetUnitRallyUnit(whichUnit, targUnit)
-- 	IssueTargetOrder(whichUnit, "setrally", targUnit)
-- end

-- --===========================================================================
-- function BJ.SetUnitRallyDestructable(whichUnit, targDest)
-- 	IssueTargetOrder(whichUnit, "setrally", targDest)
-- end

-- --===========================================================================
-- -- Utility function BJ.for use by editor-generated item drop table triggers.
-- -- This function BJ.is added as an action to all destructable drop triggers,
-- -- so that a widget drop may be differentiated from a unit drop.
-- --
-- function BJ.SaveDyingWidget()
-- 	bj_lastDyingWidget = GetTriggerWidget()
-- end

-- --===========================================================================
-- function BJ.SetBlightRectBJ(addBlight, whichPlayer, r)
-- 	SetBlightRect(whichPlayer, r, addBlight)
-- end

-- --===========================================================================
-- function BJ.SetBlightRadiusLocBJ(addBlight, whichPlayer, loc, radius)
-- 	SetBlightLoc(whichPlayer, loc, radius, addBlight)
-- end

-- --===========================================================================
-- function BJ.GetAbilityName(abilcode)
-- 	return GetObjectName(abilcode)
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Visibility Settings
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.MeleeStartingVisibility()
-- 	-- Start by setting the ToD.
-- 	SetFloatGameState(CJ.GAME_STATE_TIME_OF_DAY, bj_MELEE_STARTING_TOD)

-- -- call CJ.FogMaskEnable(true)
-- -- call CJ.FogEnable(true)
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Starting Resources
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.MeleeStartingResources()
-- 	local index
-- 	local indexPlayer
-- 	local v
-- 	local startingGold
-- 	local startingLumber

-- 	v = CJ.VersionGet()
-- 	if v == CJ.VERSION_REIGN_OF_CHAOS then
-- 		startingGold = bj_MELEE_STARTING_GOLD_V0
-- 		startingLumber = bj_MELEE_STARTING_LUMBER_V0
-- 	else
-- 		startingGold = bj_MELEE_STARTING_GOLD_V1
-- 		startingLumber = bj_MELEE_STARTING_LUMBER_V1
-- 	end

-- 	-- Set each player's starting resources.
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)
-- 		if CJ.GetPlayerSlotState(indexPlayer) == CJ.PLAYER_SLOT_STATE_PLAYING then
-- 			CJ.SetPlayerState(indexPlayer, PLAYER_STATE_RESOURCE_GOLD, startingGold)
-- 			CJ.SetPlayerState(indexPlayer, PLAYER_STATE_RESOURCE_LUMBER, startingLumber)
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Hero Limit
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.ReducePlayerTechMaxAllowed(whichPlayer, techId, limit)
-- 	local oldMax = GetPlayerTechMaxAllowed(whichPlayer, techId)

-- 	-- A value of -1 is used to indicate no limit, so check for that as well.
-- 	if oldMax < 0 or oldMax > limit then
-- 		CJ.SetPlayerTechMaxAllowed(whichPlayer, techId, limit)
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeStartingHeroLimit()
-- 	local index

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		-- max heroes per player
-- 		SetPlayerMaxHeroesAllowed(bj_MELEE_HERO_LIMIT, CJ.Player(index))

-- 		-- each player is restricted to a limit per hero type as well
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1214344551, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1215130471, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1215324524, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1214409837, bj_MELEE_HERO_TYPE_LIMIT)

-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1331850337, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1332109682, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1333027688, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1332963428, bj_MELEE_HERO_TYPE_LIMIT)

-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1164207469, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1164666213, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1164799855, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1165451634, bj_MELEE_HERO_TYPE_LIMIT)

-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1432642913, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1432646245, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1433168227, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1432580716, bj_MELEE_HERO_TYPE_LIMIT)

-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315988077, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315074670, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315858291, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315990632, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315074932, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315007587, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1316252014, bj_MELEE_HERO_TYPE_LIMIT)
-- 		ReducePlayerTechMaxAllowed(CJ.Player(index), 1315334514, bj_MELEE_HERO_TYPE_LIMIT)

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- ***************************************************************************
-- *
-- *  Melee Template Granted Hero Items
-- *
-- ***************************************************************************

-- ===========================================================================
function BJ.MeleeTrainedUnitIsHeroBJFilter()
    return CJ.IsUnitType(CJ.GetFilterUnit(), CJ.UNIT_TYPE_HERO)
end

-- --===========================================================================
-- -- The first N heroes trained or hired for each player start off with a
-- -- standard set of items.  This is currently:
-- --   - 1x Scroll of Town Portal
-- --
-- function BJ.MeleeGrantItemsToHero(whichUnit)
-- 	local owner = CJ.GetPlayerId(CJ.GetOwningPlayer(whichUnit))

-- 	-- If we haven't twinked N heroes for this player yet, twink away.
-- 	if bj_meleeTwinkedHeroes[owner] < BJ.bj_MELEE_MAX_TWINKED_HEROES then
-- 		UnitAddItemById(whichUnit, 1937012592)
-- 		bj_meleeTwinkedHeroes[owner] = bj_meleeTwinkedHeroes[owner] + 1
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeGrantItemsToTrainedHero()
-- 	MeleeGrantItemsToHero(GetTrainedUnit())
-- end

-- --===========================================================================
-- function BJ.MeleeGrantItemsToHiredHero()
-- 	MeleeGrantItemsToHero(GetSoldUnit())
-- end

-- --===========================================================================
-- function BJ.MeleeGrantHeroItems()
-- 	local index
-- 	local trig

-- 	-- Initialize the twinked hero counts.
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		bj_meleeTwinkedHeroes[index] = 0

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYER_SLOTS then break end
-- 	end

-- 	-- Register for an event whenever a hero is trained, so that we can give
-- 	-- him/her their starting items.
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		trig = CJ.CreateTrigger()
-- 		CJ.TriggerRegisterPlayerUnitEvent(trig, CJ.Player(index), EVENT_PLAYER_UNIT_TRAIN_FINISH, BJ.filterMeleeTrainedUnitIsHeroBJ)
-- 		CJ.TriggerAddAction(trig, MeleeGrantItemsToTrainedHero)

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	-- Register for an event whenever a neutral hero is hired, so that we
-- 	-- can give him/her their starting items.
-- 	trig = CJ.CreateTrigger()
-- 	CJ.TriggerRegisterPlayerUnitEvent(trig, CJ.Player(CJ.PLAYER_NEUTRAL_PASSIVE), EVENT_PLAYER_UNIT_SELL, BJ.filterMeleeTrainedUnitIsHeroBJ)
-- 	CJ.TriggerAddAction(trig, MeleeGrantItemsToHiredHero)

-- 	-- Flag that we are giving starting items to heroes, so that the melee
-- 	-- starting units code can create them as necessary.
-- 	bj_meleeGrantHeroItems = true
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Clear Start Locations
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.MeleeClearExcessUnit()
-- 	local theUnit = CJ.GetEnumUnit()
-- 	local owner = CJ.GetPlayerId(CJ.GetOwningPlayer(theUnit))

-- 	if owner == CJ.PLAYER_NEUTRAL_AGGRESSIVE then
-- 		-- Remove any Neutral Hostile units from the area.
-- 		RemoveUnit(CJ.GetEnumUnit())
-- 	elseif owner == CJ.PLAYER_NEUTRAL_PASSIVE then
-- 		-- Remove non-structure Neutral Passive units from the area.
-- 		if not CJ.IsUnitType(theUnit, CJ.UNIT_TYPE_STRUCTURE) then
-- 			RemoveUnit(CJ.GetEnumUnit())
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeClearNearbyUnits(x, y, range)
-- 	local nearbyUnits

-- 	nearbyUnits = CJ.CreateGroup()
-- 	GroupEnumUnitsInRange(nearbyUnits, x, y, range, nil)
-- 	CJ.ForGroup(nearbyUnits, MeleeClearExcessUnit)
-- 	CJ.DestroyGroup(nearbyUnits)
-- end

-- --===========================================================================
-- function BJ.MeleeClearExcessUnits()
-- 	local index
-- 	local locX
-- 	local locY
-- 	local indexPlayer

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)

-- 		-- If the player slot is being used, clear any nearby creeps.
-- 		if CJ.GetPlayerSlotState(indexPlayer) == CJ.PLAYER_SLOT_STATE_PLAYING then
-- 			locX = GetStartLocationX(GetPlayerStartLocation(indexPlayer))
-- 			locY = GetStartLocationY(GetPlayerStartLocation(indexPlayer))

-- 			MeleeClearNearbyUnits(locX, locY, bj_MELEE_CLEAR_UNITS_RADIUS)
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Starting Units
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.MeleeEnumFindNearestMine()
-- 	local enumUnit = CJ.GetEnumUnit()
-- 	local dist
-- 	local unitLoc

-- 	if CJ.GetUnitTypeId(enumUnit) == 1852272492 then
-- 		unitLoc = CJ.GetUnitLoc(enumUnit)
-- 		dist = BJ.DistanceBetweenPoints(unitLoc, bj_meleeNearestMineToLoc)
-- 		CJ.RemoveLocation(unitLoc)

-- 		-- If this is our first mine, or the closest thusfar, use it instead.
-- 		if bj_meleeNearestMineDist < 0 or dist < bj_meleeNearestMineDist then
-- 			bj_meleeNearestMine = enumUnit
-- 			bj_meleeNearestMineDist = dist
-- 		end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeFindNearestMine(src, range)
-- 	local nearbyMines

-- 	bj_meleeNearestMine = nil
-- 	bj_meleeNearestMineDist = -1
-- 	bj_meleeNearestMineToLoc = src

-- 	nearbyMines = CJ.CreateGroup()
-- 	CJ.GroupEnumUnitsInRangeOfLoc(nearbyMines, src, range, nil)
-- 	CJ.ForGroup(nearbyMines, MeleeEnumFindNearestMine)
-- 	CJ.DestroyGroup(nearbyMines)

-- 	return bj_meleeNearestMine
-- end

-- --===========================================================================
-- function BJ.MeleeRandomHeroLoc(p, id1, id2, id3, id4, loc)
-- 	local hero = nil
-- 	local roll
-- 	local pick
-- 	local v

-- 	-- The selection of heroes is dependant on the game version.
-- 	v = CJ.VersionGet()
-- 	if v == CJ.VERSION_REIGN_OF_CHAOS then
-- 		roll = CJ.GetRandomInt(1, 3)
-- 	else
-- 		roll = CJ.GetRandomInt(1, 4)
-- 	end

-- 	-- Translate the roll into a unitid.
-- 	if roll == 1 then
-- 		pick = id1
-- 	elseif roll == 2 then
-- 		pick = id2
-- 	elseif roll == 3 then
-- 		pick = id3
-- 	elseif roll == 4 then
-- 		pick = id4
-- 	else
-- 		-- Unrecognized id index - pick the first hero in the list.
-- 		pick = id1
-- 	end

-- 	-- Create the hero.
-- 	hero = CJ.CreateUnitAtLoc(p, pick, loc, BJ.bj_UNIT_FACING)
-- 	if bj_meleeGrantHeroItems then
-- 		MeleeGrantItemsToHero(hero)
-- 	end
-- 	return hero
-- end

-- --===========================================================================
-- -- Returns a location which is (distance) away from (src) in the direction of (targ).
-- --
-- function BJ.MeleeGetProjectedLoc(src, targ, distance, deltaAngle)
-- 	local srcX = CJ.GetLocationX(src)
-- 	local srcY = CJ.GetLocationY(src)
-- 	local direction = CJ.Atan2(CJ.GetLocationY(targ) - srcY, CJ.GetLocationX(targ) - srcX) + deltaAngle
-- 	return CJ.Location(srcX + distance * CJ.Cos(direction), srcY + distance * CJ.Sin(direction))
-- end

-- --===========================================================================
-- function BJ.MeleeGetNearestValueWithin(val, minVal, maxVal)
-- 	if val < minVal then
-- 		return minVal
-- 	elseif val > maxVal then
-- 		return maxVal
-- 	else
-- 		return val
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeGetLocWithinRect(src, r)
-- 	local withinX = MeleeGetNearestValueWithin(CJ.GetLocationX(src), CJ.GetRectMinX(r), CJ.GetRectMaxX(r))
-- 	local withinY = MeleeGetNearestValueWithin(CJ.GetLocationY(src), CJ.GetRectMinY(r), CJ.GetRectMaxY(r))
-- 	return CJ.Location(withinX, withinY)
-- end

-- --===========================================================================
-- -- Starting Units for Human Players
-- --   - 1 Town Hall, placed at start location
-- --   - 5 Peasants, placed between start location and nearest gold mine
-- --
-- function BJ.MeleeStartingUnitsHuman(whichPlayer, startLoc, doHeroes, doCamera, doPreload)
-- 	local useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
-- 	local unitSpacing = 64.0
-- 	local nearestMine
-- 	local nearMineLoc
-- 	local heroLoc
-- 	local peonX
-- 	local peonY
-- 	local townHall = nil

-- 	if doPreload then
-- 		Preloader("scripts\\HumanMelee.pld")
-- 	end

-- 	nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
-- 	if nearestMine ~= nil then
-- 		-- Spawn Town Hall at the start location.
-- 		townHall = CJ.CreateUnitAtLoc(whichPlayer, 1752461175, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Spawn Peasants near the mine.
-- 		nearMineLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 320, 0)
-- 		peonX = CJ.GetLocationX(nearMineLoc)
-- 		peonY = CJ.GetLocationY(nearMineLoc)
-- 		CreateUnit(whichPlayer, 1752196449, peonX + 0.0 * unitSpacing, peonY + 1.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX + 1.0 * unitSpacing, peonY + 0.15 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX - 1.0 * unitSpacing, peonY + 0.15 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX + 0.6 * unitSpacing, peonY - 1.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX - 0.6 * unitSpacing, peonY - 1.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Set random hero spawn point to be off to the side of the start location.
-- 		heroLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 384, 45)
-- 	else
-- 		-- Spawn Town Hall at the start location.
-- 		townHall = CJ.CreateUnitAtLoc(whichPlayer, 1752461175, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Spawn Peasants directly south of the town hall.
-- 		peonX = CJ.GetLocationX(startLoc)
-- 		peonY = CJ.GetLocationY(startLoc) - 224.0
-- 		CreateUnit(whichPlayer, 1752196449, peonX + 2.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX + 1.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX + 0.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX - 1.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1752196449, peonX - 2.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Set random hero spawn point to be just south of the start location.
-- 		heroLoc = CJ.Location(peonX, peonY - 2.0 * unitSpacing)
-- 	end

-- 	if townHall ~= nil then
-- 		UnitAddAbilityBJ(1097689443, townHall)
-- 		UnitMakeAbilityPermanentBJ(true, 1097689443, townHall)
-- 	end

-- 	if doHeroes then
-- 		-- If the "Random Hero" option is set, start the player with a random hero.
-- 		-- Otherwise, give them a "free hero" token.
-- 		if useRandomHero then
-- 			MeleeRandomHeroLoc(whichPlayer, 1214344551, 1215130471, 1215324524, 1214409837, heroLoc)
-- 		else
-- 			CJ.SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
-- 		end
-- 	end

-- 	if doCamera then
-- 		-- Center the camera on the initial Peasants.
-- 		SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
-- 		SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
-- 	end
-- end

-- --===========================================================================
-- -- Starting Units for Orc Players
-- --   - 1 Great Hall, placed at start location
-- --   - 5 Peons, placed between start location and nearest gold mine
-- --
-- function BJ.MeleeStartingUnitsOrc(whichPlayer, startLoc, doHeroes, doCamera, doPreload)
-- 	local useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
-- 	local unitSpacing = 64.0
-- 	local nearestMine
-- 	local nearMineLoc
-- 	local heroLoc
-- 	local peonX
-- 	local peonY

-- 	if doPreload then
-- 		Preloader("scripts\\OrcMelee.pld")
-- 	end

-- 	nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
-- 	if nearestMine ~= nil then
-- 		-- Spawn Great Hall at the start location.
-- 		CJ.CreateUnitAtLoc(whichPlayer, 1869050469, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Spawn Peons near the mine.
-- 		nearMineLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 320, 0)
-- 		peonX = CJ.GetLocationX(nearMineLoc)
-- 		peonY = CJ.GetLocationY(nearMineLoc)
-- 		CreateUnit(whichPlayer, 1869636975, peonX + 0.0 * unitSpacing, peonY + 1.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX + 1.0 * unitSpacing, peonY + 0.15 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX - 1.0 * unitSpacing, peonY + 0.15 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX + 0.6 * unitSpacing, peonY - 1.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX - 0.6 * unitSpacing, peonY - 1.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Set random hero spawn point to be off to the side of the start location.
-- 		heroLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 384, 45)
-- 	else
-- 		-- Spawn Great Hall at the start location.
-- 		CJ.CreateUnitAtLoc(whichPlayer, 1869050469, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Spawn Peons directly south of the town hall.
-- 		peonX = CJ.GetLocationX(startLoc)
-- 		peonY = CJ.GetLocationY(startLoc) - 224.0
-- 		CreateUnit(whichPlayer, 1869636975, peonX + 2.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX + 1.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX + 0.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX - 1.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1869636975, peonX - 2.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Set random hero spawn point to be just south of the start location.
-- 		heroLoc = CJ.Location(peonX, peonY - 2.0 * unitSpacing)
-- 	end

-- 	if doHeroes then
-- 		-- If the "Random Hero" option is set, start the player with a random hero.
-- 		-- Otherwise, give them a "free hero" token.
-- 		if useRandomHero then
-- 			MeleeRandomHeroLoc(whichPlayer, 1331850337, 1332109682, 1333027688, 1332963428, heroLoc)
-- 		else
-- 			CJ.SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
-- 		end
-- 	end

-- 	if doCamera then
-- 		-- Center the camera on the initial Peons.
-- 		SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
-- 		SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
-- 	end
-- end

-- --===========================================================================
-- -- Starting Units for Undead Players
-- --   - 1 Necropolis, placed at start location
-- --   - 1 Haunted Gold Mine, placed on nearest gold mine
-- --   - 3 Acolytes, placed between start location and nearest gold mine
-- --   - 1 Ghoul, placed between start location and nearest gold mine
-- --   - Blight, centered on nearest gold mine, spread across a "large area"
-- --
-- function BJ.MeleeStartingUnitsUndead(whichPlayer, startLoc, doHeroes, doCamera, doPreload)
-- 	local useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
-- 	local unitSpacing = 64.0
-- 	local nearestMine
-- 	local nearMineLoc
-- 	local nearTownLoc
-- 	local heroLoc
-- 	local peonX
-- 	local peonY
-- 	local ghoulX
-- 	local ghoulY

-- 	if doPreload then
-- 		Preloader("scripts\\UndeadMelee.pld")
-- 	end

-- 	nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
-- 	if nearestMine ~= nil then
-- 		-- Spawn Necropolis at the start location.
-- 		CJ.CreateUnitAtLoc(whichPlayer, 1970172012, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Replace the nearest gold mine with a blighted version.
-- 		nearestMine = BlightGoldMineForPlayerBJ(nearestMine, whichPlayer)

-- 		-- Spawn Ghoul near the Necropolis.
-- 		nearTownLoc = MeleeGetProjectedLoc(startLoc, CJ.GetUnitLoc(nearestMine), 288, 0)
-- 		ghoulX = CJ.GetLocationX(nearTownLoc)
-- 		ghoulY = CJ.GetLocationY(nearTownLoc)
-- 		bj_ghoul[CJ.GetPlayerId(whichPlayer)] = CreateUnit(whichPlayer, 1969711215, ghoulX + 0.0 * unitSpacing, ghoulY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Spawn Acolytes near the mine.
-- 		nearMineLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 320, 0)
-- 		peonX = CJ.GetLocationX(nearMineLoc)
-- 		peonY = CJ.GetLocationY(nearMineLoc)
-- 		CreateUnit(whichPlayer, 1969316719, peonX + 0.0 * unitSpacing, peonY + 0.5 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1969316719, peonX + 0.65 * unitSpacing, peonY - 0.5 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1969316719, peonX - 0.65 * unitSpacing, peonY - 0.5 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Create a patch of blight around the gold mine.
-- 		SetBlightLoc(whichPlayer, nearMineLoc, 768, true)

-- 		-- Set random hero spawn point to be off to the side of the start location.
-- 		heroLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 384, 45)
-- 	else
-- 		-- Spawn Necropolis at the start location.
-- 		CJ.CreateUnitAtLoc(whichPlayer, 1970172012, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Spawn Acolytes and Ghoul directly south of the Necropolis.
-- 		peonX = CJ.GetLocationX(startLoc)
-- 		peonY = CJ.GetLocationY(startLoc) - 224.0
-- 		CreateUnit(whichPlayer, 1969316719, peonX - 1.5 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1969316719, peonX - 0.5 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1969316719, peonX + 0.5 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1969711215, peonX + 1.5 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Create a patch of blight around the start location.
-- 		SetBlightLoc(whichPlayer, startLoc, 768, true)

-- 		-- Set random hero spawn point to be just south of the start location.
-- 		heroLoc = CJ.Location(peonX, peonY - 2.0 * unitSpacing)
-- 	end

-- 	if doHeroes then
-- 		-- If the "Random Hero" option is set, start the player with a random hero.
-- 		-- Otherwise, give them a "free hero" token.
-- 		if useRandomHero then
-- 			MeleeRandomHeroLoc(whichPlayer, 1432642913, 1432646245, 1433168227, 1432580716, heroLoc)
-- 		else
-- 			CJ.SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
-- 		end
-- 	end

-- 	if doCamera then
-- 		-- Center the camera on the initial Acolytes.
-- 		SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
-- 		SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
-- 	end
-- end

-- --===========================================================================
-- -- Starting Units for Night Elf Players
-- --   - 1 Tree of Life, placed by nearest gold mine, already entangled
-- --   - 5 Wisps, placed between Tree of Life and nearest gold mine
-- --
-- function BJ.MeleeStartingUnitsNightElf(whichPlayer, startLoc, doHeroes, doCamera, doPreload)
-- 	local useRandomHero = IsMapFlagSet(MAP_RANDOM_HERO)
-- 	local unitSpacing = 64.0
-- 	local minTreeDist = 3.5 * bj_CELLWIDTH
-- 	local minWispDist = 1.75 * bj_CELLWIDTH
-- 	local nearestMine
-- 	local nearMineLoc
-- 	local wispLoc
-- 	local heroLoc
-- 	local peonX
-- 	local peonY
-- 	local tree

-- 	if doPreload then
-- 		Preloader("scripts\\NightElfMelee.pld")
-- 	end

-- 	nearestMine = MeleeFindNearestMine(startLoc, bj_MELEE_MINE_SEARCH_RADIUS)
-- 	if nearestMine ~= nil then
-- 		-- Spawn Tree of Life near the mine and have it entangle the mine.
-- 		-- Project the Tree's coordinates from the gold mine, and then snap
-- 		-- the X and Y values to within minTreeDist of the Gold Mine.
-- 		nearMineLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 650, 0)
-- 		nearMineLoc = MeleeGetLocWithinRect(nearMineLoc, GetRectFromCircleBJ(CJ.GetUnitLoc(nearestMine), minTreeDist))
-- 		tree = CJ.CreateUnitAtLoc(whichPlayer, 1702129516, nearMineLoc, BJ.bj_UNIT_FACING)
-- 		IssueTargetOrder(tree, "entangleinstant", nearestMine)

-- 		-- Spawn Wisps at the start location.
-- 		wispLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 320, 0)
-- 		wispLoc = MeleeGetLocWithinRect(wispLoc, GetRectFromCircleBJ(CJ.GetUnitLoc(nearestMine), minWispDist))
-- 		peonX = CJ.GetLocationX(wispLoc)
-- 		peonY = CJ.GetLocationY(wispLoc)
-- 		CreateUnit(whichPlayer, 1702327152, peonX + 0.0 * unitSpacing, peonY + 1.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX + 1.0 * unitSpacing, peonY + 0.15 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX - 1.0 * unitSpacing, peonY + 0.15 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX + 0.58 * unitSpacing, peonY - 1.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX - 0.58 * unitSpacing, peonY - 1.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Set random hero spawn point to be off to the side of the start location.
-- 		heroLoc = MeleeGetProjectedLoc(CJ.GetUnitLoc(nearestMine), startLoc, 384, 45)
-- 	else
-- 		-- Spawn Tree of Life at the start location.
-- 		CJ.CreateUnitAtLoc(whichPlayer, 1702129516, startLoc, BJ.bj_UNIT_FACING)

-- 		-- Spawn Wisps directly south of the town hall.
-- 		peonX = CJ.GetLocationX(startLoc)
-- 		peonY = CJ.GetLocationY(startLoc) - 224.0
-- 		CreateUnit(whichPlayer, 1702327152, peonX - 2.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX - 1.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX + 0.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX + 1.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)
-- 		CreateUnit(whichPlayer, 1702327152, peonX + 2.0 * unitSpacing, peonY + 0.0 * unitSpacing, BJ.bj_UNIT_FACING)

-- 		-- Set random hero spawn point to be just south of the start location.
-- 		heroLoc = CJ.Location(peonX, peonY - 2.0 * unitSpacing)
-- 	end

-- 	if doHeroes then
-- 		-- If the "Random Hero" option is set, start the player with a random hero.
-- 		-- Otherwise, give them a "free hero" token.
-- 		if useRandomHero then
-- 			MeleeRandomHeroLoc(whichPlayer, 1164207469, 1164666213, 1164799855, 1165451634, heroLoc)
-- 		else
-- 			CJ.SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
-- 		end
-- 	end

-- 	if doCamera then
-- 		-- Center the camera on the initial Wisps.
-- 		SetCameraPositionForPlayer(whichPlayer, peonX, peonY)
-- 		SetCameraQuickPositionForPlayer(whichPlayer, peonX, peonY)
-- 	end
-- end

-- --===========================================================================
-- -- Starting Units for Players Whose Race is Unknown
-- --   - 12 Sheep, placed randomly around the start location
-- --
-- function BJ.MeleeStartingUnitsUnknownRace(whichPlayer, startLoc, doHeroes, doCamera, doPreload)
-- 	local index

-- 	if doPreload then
-- 	end

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		CreateUnit(whichPlayer, 1853057125, CJ.GetLocationX(startLoc) + CJ.GetRandomReal(-256, 256), CJ.GetLocationY(startLoc) + CJ.GetRandomReal(-256, 256), CJ.GetRandomReal(0, 360))
-- 		index = index + 1
-- 		if index == 12 then break end
-- 	end

-- 	if doHeroes then
-- 		-- Give them a "free hero" token, out of pity.
-- 		CJ.SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_HERO_TOKENS, bj_MELEE_STARTING_HERO_TOKENS)
-- 	end

-- 	if doCamera then
-- 		-- Center the camera on the initial sheep.
-- 		SetCameraPositionLocForPlayer(whichPlayer, startLoc)
-- 		SetCameraQuickPositionLocForPlayer(whichPlayer, startLoc)
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeStartingUnits()
-- 	local index
-- 	local indexPlayer
-- 	local indexStartLoc
-- 	local indexRace

-- 	Preloader("scripts\\SharedMelee.pld")

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)
-- 		if CJ.GetPlayerSlotState(indexPlayer) == CJ.PLAYER_SLOT_STATE_PLAYING then
-- 			indexStartLoc = GetStartLocationLoc(GetPlayerStartLocation(indexPlayer))
-- 			indexRace = GetPlayerRace(indexPlayer)

-- 			-- Create initial race-specific starting units
-- 			if indexRace == RACE_HUMAN then
-- 				MeleeStartingUnitsHuman(indexPlayer, indexStartLoc, true, true, true)
-- 			elseif indexRace == RACE_ORC then
-- 				MeleeStartingUnitsOrc(indexPlayer, indexStartLoc, true, true, true)
-- 			elseif indexRace == RACE_UNDEAD then
-- 				MeleeStartingUnitsUndead(indexPlayer, indexStartLoc, true, true, true)
-- 			elseif indexRace == RACE_NIGHTELF then
-- 				MeleeStartingUnitsNightElf(indexPlayer, indexStartLoc, true, true, true)
-- 			else
-- 				MeleeStartingUnitsUnknownRace(indexPlayer, indexStartLoc, true, true, true)
-- 			end
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- end

-- --===========================================================================
-- function BJ.MeleeStartingUnitsForPlayer(whichRace, whichPlayer, loc, doHeroes)
-- 	-- Create initial race-specific starting units
-- 	if whichRace == RACE_HUMAN then
-- 		MeleeStartingUnitsHuman(whichPlayer, loc, doHeroes, false, false)
-- 	elseif whichRace == RACE_ORC then
-- 		MeleeStartingUnitsOrc(whichPlayer, loc, doHeroes, false, false)
-- 	elseif whichRace == RACE_UNDEAD then
-- 		MeleeStartingUnitsUndead(whichPlayer, loc, doHeroes, false, false)
-- 	elseif whichRace == RACE_NIGHTELF then
-- 		MeleeStartingUnitsNightElf(whichPlayer, loc, doHeroes, false, false)
-- 	else
-- 	-- Unrecognized race - ignore the request.
-- 	end
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Starting AI Scripts
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.PickMeleeAI(num, s1, s2, s3)
-- 	local pick

-- 	-- easy difficulty never uses any custom AI scripts
-- 	-- that are designed to be a bit more challenging
-- 	--
-- 	if GetAIDifficulty(num) == AI_DIFFICULTY_NEWBIE then
-- 		StartMeleeAI(num, s1)
-- 		return
-- 	end

-- 	if s2 == nil then
-- 		pick = 1
-- 	elseif s3 == nil then
-- 		pick = CJ.GetRandomInt(1, 2)
-- 	else
-- 		pick = CJ.GetRandomInt(1, 3)
-- 	end

-- 	if pick == 1 then
-- 		StartMeleeAI(num, s1)
-- 	elseif pick == 2 then
-- 		StartMeleeAI(num, s2)
-- 	else
-- 		StartMeleeAI(num, s3)
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeStartingAI()
-- 	local index
-- 	local indexPlayer
-- 	local indexRace

-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)
-- 		if CJ.GetPlayerSlotState(indexPlayer) == CJ.PLAYER_SLOT_STATE_PLAYING then
-- 			indexRace = GetPlayerRace(indexPlayer)
-- 			if CJ.GetPlayerController(indexPlayer) == MAP_CONTROL_COMPUTER then
-- 				-- Run a race-specific melee AI script.
-- 				if indexRace == RACE_HUMAN then
-- 					PickMeleeAI(indexPlayer, "human.ai", nil, nil)
-- 				elseif indexRace == RACE_ORC then
-- 					PickMeleeAI(indexPlayer, "orc.ai", nil, nil)
-- 				elseif indexRace == RACE_UNDEAD then
-- 					PickMeleeAI(indexPlayer, "undead.ai", nil, nil)
-- 					RecycleGuardPosition(bj_ghoul[index])
-- 				elseif indexRace == RACE_NIGHTELF then
-- 					PickMeleeAI(indexPlayer, "elf.ai", nil, nil)
-- 				else
-- 				-- Unrecognized race.
-- 				end
-- 				ShareEverythingWithTeamAI(indexPlayer)
-- 			end
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- function BJ.LockGuardPosition(targ)
-- 	SetUnitCreepGuard(targ, true)
-- end

-- --***************************************************************************
-- --*
-- --*  Melee Template Victory / Defeat Conditions
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.MeleePlayerIsOpponent(playerIndex, opponentIndex)
-- 	local thePlayer = CJ.Player(playerIndex)
-- 	local theOpponent = CJ.Player(opponentIndex)

-- 	-- The player himself is not an opponent.
-- 	if playerIndex == opponentIndex then
-- 		return false
-- 	end

-- 	-- Unused player slots are not opponents.
-- 	if CJ.GetPlayerSlotState(theOpponent) ~= CJ.PLAYER_SLOT_STATE_PLAYING then
-- 		return false
-- 	end

-- 	-- Players who are already defeated are not opponents.
-- 	if bj_meleeDefeated[opponentIndex] then
-- 		return false
-- 	end

-- 	-- Allied players with allied victory set are not opponents.
-- 	if GetPlayerAlliance(thePlayer, theOpponent, CJ.ALLIANCE_PASSIVE) then
-- 		if GetPlayerAlliance(theOpponent, thePlayer, CJ.ALLIANCE_PASSIVE) then
-- 			if GetPlayerState(thePlayer, PLAYER_STATE_ALLIED_VICTORY) == 1 then
-- 				if GetPlayerState(theOpponent, PLAYER_STATE_ALLIED_VICTORY) == 1 then
-- 					return false
-- 				end
-- 			end
-- 		end
-- 	end

-- 	return true
-- end

-- --===========================================================================
-- -- Count buildings currently owned by all allies, including the player themself.
-- --
-- function BJ.MeleeGetAllyStructureCount(whichPlayer)
-- 	local playerIndex
-- 	local buildingCount
-- 	local indexPlayer

-- 	-- Count the number of buildings controlled by all not-yet-defeated co-allies.
-- 	buildingCount = 0
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)

-- 		-- uncomment to cause defeat even if you have control of ally structures, but yours have been nixed
-- 		--if (PlayersAreCoAllied(whichPlayer, indexPlayer) and not bj_meleeDefeated[playerIndex]) then
-- 		if PlayersAreCoAllied(whichPlayer, indexPlayer) then
-- 			buildingCount = buildingCount + GetPlayerStructureCount(indexPlayer, true)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	return buildingCount
-- end

-- --===========================================================================
-- -- Count allies, excluding dead players and the player themself.
-- --
-- function BJ.MeleeGetAllyCount(whichPlayer)
-- 	local playerIndex
-- 	local playerCount
-- 	local indexPlayer

-- 	-- Count the number of not-yet-defeated co-allies.
-- 	playerCount = 0
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if PlayersAreCoAllied(whichPlayer, indexPlayer) and not bj_meleeDefeated[playerIndex] and whichPlayer ~= indexPlayer then
-- 			playerCount = playerCount + 1
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	return playerCount
-- end

-- --===========================================================================
-- -- Counts key structures owned by a player and his or her allies, including
-- -- structures currently upgrading or under construction.
-- --
-- -- Key structures: Town Hall, Great Hall, Tree of Life, Necropolis
-- --
-- function BJ.MeleeGetAllyKeyStructureCount(whichPlayer)
-- 	local playerIndex
-- 	local indexPlayer
-- 	local keyStructs

-- 	-- Count the number of buildings controlled by all not-yet-defeated co-allies.
-- 	keyStructs = 0
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if PlayersAreCoAllied(whichPlayer, indexPlayer) then
-- 			keyStructs = keyStructs + GetPlayerTypedUnitCount(indexPlayer, "townhall", true, true)
-- 			keyStructs = keyStructs + GetPlayerTypedUnitCount(indexPlayer, "greathall", true, true)
-- 			keyStructs = keyStructs + GetPlayerTypedUnitCount(indexPlayer, "treeoflife", true, true)
-- 			keyStructs = keyStructs + GetPlayerTypedUnitCount(indexPlayer, "necropolis", true, true)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	return keyStructs
-- end

-- --===========================================================================
-- -- Enum: Draw out a specific player.
-- --
-- function BJ.MeleeDoDrawEnum()
-- 	local thePlayer = GetEnumPlayer()

-- 	CachePlayerHeroData(thePlayer)
-- 	RemovePlayerPreserveUnitsBJ(thePlayer, PLAYER_GAME_RESULT_TIE, false)
-- end

-- --===========================================================================
-- -- Enum: Victory out a specific player.
-- --
-- function BJ.MeleeDoVictoryEnum()
-- 	local thePlayer = GetEnumPlayer()
-- 	local playerIndex = CJ.GetPlayerId(thePlayer)

-- 	if not bj_meleeVictoried[playerIndex] then
-- 		bj_meleeVictoried[playerIndex] = true
-- 		CachePlayerHeroData(thePlayer)
-- 		RemovePlayerPreserveUnitsBJ(thePlayer, CJ.PLAYER_GAME_RESULT_VICTORY, false)
-- 	end
-- end

-- --===========================================================================
-- -- Defeat out a specific player.
-- --
-- function BJ.MeleeDoDefeat(whichPlayer)
-- 	bj_meleeDefeated[CJ.GetPlayerId(whichPlayer)] = true
-- 	RemovePlayerPreserveUnitsBJ(whichPlayer, CJ.PLAYER_GAME_RESULT_DEFEAT, false)
-- end

-- --===========================================================================
-- -- Enum: Defeat out a specific player.
-- --
-- function BJ.MeleeDoDefeatEnum()
-- 	local thePlayer = GetEnumPlayer()

-- 	-- needs to happen before ownership change
-- 	CachePlayerHeroData(thePlayer)
-- 	MakeUnitsPassiveForTeam(thePlayer)
-- 	MeleeDoDefeat(thePlayer)
-- end

-- --===========================================================================
-- -- A specific player left the game.
-- --
-- function BJ.MeleeDoLeave(whichPlayer)
-- 	if GetIntegerGameState(GAME_STATE_DISCONNECTED) ~= 0 then
-- 		GameOverDialogBJ(whichPlayer, true)
-- 	else
-- 		bj_meleeDefeated[CJ.GetPlayerId(whichPlayer)] = true
-- 		RemovePlayerPreserveUnitsBJ(whichPlayer, CJ.PLAYER_GAME_RESULT_DEFEAT, true)
-- 	end
-- end

-- --===========================================================================
-- -- Remove all observers
-- -- 
-- function BJ.MeleeRemoveObservers()
-- 	local playerIndex
-- 	local indexPlayer

-- 	-- Give all observers the game over dialog
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)

-- 		if IsPlayerObserver(indexPlayer) then
-- 			RemovePlayerPreserveUnitsBJ(indexPlayer, CJ.PLAYER_GAME_RESULT_NEUTRAL, false)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --===========================================================================
-- -- Test all players to determine if a team has won.  For a team to win, all
-- -- remaining (read: undefeated) players need to be co-allied with all other
-- -- remaining players.  If even one player is not allied towards another,
-- -- everyone must be denied victory.
-- --
-- function BJ.MeleeCheckForVictors()
-- 	local playerIndex
-- 	local opponentIndex
-- 	local opponentlessPlayers = CJ.CreateForce()
-- 	local gameOver = false

-- 	-- Check to see if any players have opponents remaining.
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		if not bj_meleeDefeated[playerIndex] then
-- 			-- Determine whether or not this player has any remaining opponents.
-- 			opponentIndex = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				-- If anyone has an opponent, noone can be victorious yet.
-- 				if MeleePlayerIsOpponent(playerIndex, opponentIndex) then
-- 					return CJ.CreateForce()
-- 				end

-- 				opponentIndex = opponentIndex + 1
-- 				if opponentIndex == BJ.bj_MAX_PLAYERS then break end
-- 			end

-- 			-- Keep track of each opponentless player so that we can give
-- 			-- them a victory later.
-- 			CJ.ForceAddPlayer(opponentlessPlayers, CJ.Player(playerIndex))
-- 			gameOver = true
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	-- Set the game over global flag
-- 	bj_meleeGameOver = gameOver

-- 	return opponentlessPlayers
-- end

-- --===========================================================================
-- -- Test each player to determine if anyone has been defeated.
-- --
-- function BJ.MeleeCheckForLosersAndVictors()
-- 	local playerIndex
-- 	local indexPlayer
-- 	local defeatedPlayers = CJ.CreateForce()
-- 	local victoriousPlayers
-- 	local gameOver = false

-- 	-- If the game is already over, do nothing
-- 	if bj_meleeGameOver then
-- 		return
-- 	end

-- 	-- If the game was disconnected then it is over, in this case we
-- 	-- don't want to report results for anyone as they will most likely
-- 	-- conflict with the actual game results
-- 	if GetIntegerGameState(GAME_STATE_DISCONNECTED) ~= 0 then
-- 		bj_meleeGameOver = true
-- 		return
-- 	end

-- 	-- Check each player to see if he or she has been defeated yet.
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)

-- 		if not bj_meleeDefeated[playerIndex] and not bj_meleeVictoried[playerIndex] then
-- 			--call DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, 60, "CJ.Player"+I2S(playerIndex)+" has "+I2S(MeleeGetAllyStructureCount(indexPlayer))+" ally buildings.")
-- 			if MeleeGetAllyStructureCount(indexPlayer) <= 0 then

-- 				-- Keep track of each defeated player so that we can give
-- 				-- them a defeat later.
-- 				CJ.ForceAddPlayer(defeatedPlayers, CJ.Player(playerIndex))

-- 				-- Set their defeated flag now so MeleeCheckForVictors
-- 				-- can detect victors.
-- 				bj_meleeDefeated[playerIndex] = true
-- 			end
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	-- Now that the defeated flags are set, check if there are any victors
-- 	victoriousPlayers = MeleeCheckForVictors()

-- 	-- Defeat all defeated players
-- 	ForForce(defeatedPlayers, MeleeDoDefeatEnum)

-- 	-- Give victory to all victorious players
-- 	ForForce(victoriousPlayers, MeleeDoVictoryEnum)

-- 	-- If the game is over we should remove all observers
-- 	if bj_meleeGameOver then
-- 		MeleeRemoveObservers()
-- 	end
-- end

-- --===========================================================================
-- -- Returns a race-specific "build X or be revealed" message.
-- --
-- function BJ.MeleeGetCrippledWarningMessage(whichPlayer)
-- 	local r = GetPlayerRace(whichPlayer)

-- 	if r == RACE_HUMAN then
-- 		return CJ.GetLocalizedString("CRIPPLE_WARNING_HUMAN")
-- 	elseif r == RACE_ORC then
-- 		return CJ.GetLocalizedString("CRIPPLE_WARNING_ORC")
-- 	elseif r == RACE_NIGHTELF then
-- 		return CJ.GetLocalizedString("CRIPPLE_WARNING_NIGHTELF")
-- 	elseif r == RACE_UNDEAD then
-- 		return CJ.GetLocalizedString("CRIPPLE_WARNING_UNDEAD")
-- 	else
-- 		-- Unrecognized Race
-- 		return ""
-- 	end
-- end

-- --===========================================================================
-- -- Returns a race-specific "build X" label for cripple timers.
-- --
-- function BJ.MeleeGetCrippledTimerMessage(whichPlayer)
-- 	local r = GetPlayerRace(whichPlayer)

-- 	if r == RACE_HUMAN then
-- 		return CJ.GetLocalizedString("CRIPPLE_TIMER_HUMAN")
-- 	elseif r == RACE_ORC then
-- 		return CJ.GetLocalizedString("CRIPPLE_TIMER_ORC")
-- 	elseif r == RACE_NIGHTELF then
-- 		return CJ.GetLocalizedString("CRIPPLE_TIMER_NIGHTELF")
-- 	elseif r == RACE_UNDEAD then
-- 		return CJ.GetLocalizedString("CRIPPLE_TIMER_UNDEAD")
-- 	else
-- 		-- Unrecognized Race
-- 		return ""
-- 	end
-- end

-- --===========================================================================
-- -- Returns a race-specific "build X" label for cripple timers.
-- --
-- function BJ.MeleeGetCrippledRevealedMessage(whichPlayer)
-- 	return (CJ.GetLocalizedString("CRIPPLE_REVEALING_PREFIX") or "") .. (GetPlayerName(whichPlayer) or "") .. (CJ.GetLocalizedString("CRIPPLE_REVEALING_POSTFIX") or "")
-- end

-- --===========================================================================
-- function BJ.MeleeExposePlayer(whichPlayer, expose)
-- 	local playerIndex
-- 	local indexPlayer
-- 	local toExposeTo = CJ.CreateForce()

-- 	CripplePlayer(whichPlayer, toExposeTo, false)

-- 	bj_playerIsExposed[CJ.GetPlayerId(whichPlayer)] = expose
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		if not PlayersAreCoAllied(whichPlayer, indexPlayer) then
-- 			CJ.ForceAddPlayer(toExposeTo, indexPlayer)
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	CripplePlayer(whichPlayer, toExposeTo, expose)
-- 	DestroyForce(toExposeTo)
-- end

-- --===========================================================================
-- function BJ.MeleeExposeAllPlayers()
-- 	local playerIndex
-- 	local indexPlayer
-- 	local playerIndex2
-- 	local indexPlayer2
-- 	local toExposeTo = CJ.CreateForce()

-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)

-- 		ForceClear(toExposeTo)
-- 		CripplePlayer(indexPlayer, toExposeTo, false)

-- 		playerIndex2 = 0
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			indexPlayer2 = CJ.Player(playerIndex2)

-- 			if playerIndex ~= playerIndex2 then
-- 				if not PlayersAreCoAllied(indexPlayer, indexPlayer2) then
-- 					CJ.ForceAddPlayer(toExposeTo, indexPlayer2)
-- 				end
-- 			end

-- 			playerIndex2 = playerIndex2 + 1
-- 			if playerIndex2 == BJ.bj_MAX_PLAYERS then break end
-- 		end

-- 		CripplePlayer(indexPlayer, toExposeTo, true)

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	DestroyForce(toExposeTo)
-- end

-- --===========================================================================
-- function BJ.MeleeCrippledPlayerTimeout()
-- 	local expiredTimer = GetExpiredTimer()
-- 	local playerIndex
-- 	local exposedPlayer

-- 	-- Determine which player's timer expired.
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		if bj_crippledTimer[playerIndex] == expiredTimer then
-- 			if true then break end
-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- 	if playerIndex == BJ.bj_MAX_PLAYERS then
-- 		return
-- 	end
-- 	exposedPlayer = CJ.Player(playerIndex)

-- 	if CJ.GetLocalPlayer() == exposedPlayer then
-- 		-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 		-- Hide the timer window for this player.
-- 		TimerDialogDisplay(bj_crippledTimerWindows[playerIndex], false)
-- 	end

-- 	-- Display a text message to all players, explaining the exposure.
-- 	DisplayTimedTextToPlayer(CJ.GetLocalPlayer(), 0, 0, bj_MELEE_CRIPPLE_MSG_DURATION, MeleeGetCrippledRevealedMessage(exposedPlayer))

-- 	-- Expose the player.
-- 	MeleeExposePlayer(exposedPlayer, true)
-- end

-- --===========================================================================
-- function BJ.MeleePlayerIsCrippled(whichPlayer)
-- 	local allyStructures = MeleeGetAllyStructureCount(whichPlayer)
-- 	local allyKeyStructures = MeleeGetAllyKeyStructureCount(whichPlayer)

-- 	-- Dead teams are not considered to be crippled.
-- 	return allyStructures > 0 and allyKeyStructures <= 0
-- end

-- --===========================================================================
-- -- Test each player to determine if anyone has become crippled.
-- --
-- function BJ.MeleeCheckForCrippledPlayers()
-- 	local playerIndex
-- 	local indexPlayer
-- 	local crippledPlayers = CJ.CreateForce()
-- 	local isNowCrippled
-- 	local indexRace

-- 	-- The "finish soon" exposure of all players overrides any "crippled" exposure
-- 	if bj_finishSoonAllExposed then
-- 		return
-- 	end

-- 	-- Check each player to see if he or she has been crippled or uncrippled.
-- 	playerIndex = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(playerIndex)
-- 		isNowCrippled = MeleePlayerIsCrippled(indexPlayer)

-- 		if not bj_playerIsCrippled[playerIndex] and isNowCrippled then

-- 			-- CJ.Player became crippled; start their cripple timer.
-- 			bj_playerIsCrippled[playerIndex] = true
-- 			CJ.TimerStart(bj_crippledTimer[playerIndex], bj_MELEE_CRIPPLE_TIMEOUT, false, MeleeCrippledPlayerTimeout)

-- 			if CJ.GetLocalPlayer() == indexPlayer then
-- 				-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 				-- Show the timer window.
-- 				TimerDialogDisplay(bj_crippledTimerWindows[playerIndex], true)

-- 				-- Display a warning message.
-- 				DisplayTimedTextToPlayer(indexPlayer, 0, 0, bj_MELEE_CRIPPLE_MSG_DURATION, MeleeGetCrippledWarningMessage(indexPlayer))
-- 			end

-- 		elseif bj_playerIsCrippled[playerIndex] and not isNowCrippled then

-- 			-- CJ.Player became uncrippled; stop their cripple timer.
-- 			bj_playerIsCrippled[playerIndex] = false
-- 			CJ.PauseTimer(bj_crippledTimer[playerIndex])

-- 			if CJ.GetLocalPlayer() == indexPlayer then
-- 				-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 				-- Hide the timer window for this player.
-- 				TimerDialogDisplay(bj_crippledTimerWindows[playerIndex], false)

-- 				-- Display a confirmation message if the player's team is still alive.
-- 				if MeleeGetAllyStructureCount(indexPlayer) > 0 then
-- 					if bj_playerIsExposed[playerIndex] then
-- 						DisplayTimedTextToPlayer(indexPlayer, 0, 0, bj_MELEE_CRIPPLE_MSG_DURATION, CJ.GetLocalizedString("CRIPPLE_UNREVEALED"))
-- 					else
-- 						DisplayTimedTextToPlayer(indexPlayer, 0, 0, bj_MELEE_CRIPPLE_MSG_DURATION, CJ.GetLocalizedString("CRIPPLE_UNCRIPPLED"))
-- 					end
-- 				end
-- 			end

-- 			-- If the player granted shared vision, deny that vision now.
-- 			MeleeExposePlayer(indexPlayer, false)

-- 		end

-- 		playerIndex = playerIndex + 1
-- 		if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --===========================================================================
-- -- Determine if the lost unit should result in any defeats or victories.
-- --
-- function BJ.MeleeCheckLostUnit(lostUnit)
-- 	local lostUnitOwner = CJ.GetOwningPlayer(lostUnit)

-- 	-- We only need to check for mortality if this was the last building.
-- 	if GetPlayerStructureCount(lostUnitOwner, true) <= 0 then
-- 		MeleeCheckForLosersAndVictors()
-- 	end

-- 	-- Check if the lost unit has crippled or uncrippled the player.
-- 	-- (A team with 0 units is dead, and thus considered uncrippled.)
-- 	MeleeCheckForCrippledPlayers()
-- end

-- --===========================================================================
-- -- Determine if the gained unit should result in any defeats, victories,
-- -- or cripple-status changes.
-- --
-- function BJ.MeleeCheckAddedUnit(addedUnit)
-- 	local addedUnitOwner = CJ.GetOwningPlayer(addedUnit)

-- 	-- If the player was crippled, this unit may have uncrippled him/her.
-- 	if bj_playerIsCrippled[CJ.GetPlayerId(addedUnitOwner)] then
-- 		MeleeCheckForCrippledPlayers()
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerActionConstructCancel()
-- 	MeleeCheckLostUnit(GetCancelledStructure())
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerActionUnitDeath()
-- 	if CJ.IsUnitType(GetDyingUnit(), CJ.UNIT_TYPE_STRUCTURE) then
-- 		MeleeCheckLostUnit(GetDyingUnit())
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerActionUnitConstructionStart()
-- 	MeleeCheckAddedUnit(GetConstructingStructure())
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerActionPlayerDefeated()
-- 	local thePlayer = GetTriggerPlayer()
-- 	CachePlayerHeroData(thePlayer)

-- 	if MeleeGetAllyCount(thePlayer) > 0 then
-- 		-- If at least one ally is still alive and kicking, share units with
-- 		-- them and proceed with death.
-- 		ShareEverythingWithTeam(thePlayer)
-- 		if not bj_meleeDefeated[CJ.GetPlayerId(thePlayer)] then
-- 			MeleeDoDefeat(thePlayer)
-- 		end
-- 	else
-- 		-- If no living allies remain, swap all units and buildings over to
-- 		-- neutral_passive and proceed with death.
-- 		MakeUnitsPassiveForTeam(thePlayer)
-- 		if not bj_meleeDefeated[CJ.GetPlayerId(thePlayer)] then
-- 			MeleeDoDefeat(thePlayer)
-- 		end
-- 	end
-- 	MeleeCheckForLosersAndVictors()
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerActionPlayerLeft()
-- 	local thePlayer = GetTriggerPlayer()

-- 	-- Just show game over for observers when they leave
-- 	if IsPlayerObserver(thePlayer) then
-- 		RemovePlayerPreserveUnitsBJ(thePlayer, CJ.PLAYER_GAME_RESULT_NEUTRAL, false)
-- 		return
-- 	end

-- 	CachePlayerHeroData(thePlayer)

-- 	-- This is the same as defeat except the player generates the message 
-- 	-- "player left the game" as opposed to "player was defeated".

-- 	if MeleeGetAllyCount(thePlayer) > 0 then
-- 		-- If at least one ally is still alive and kicking, share units with
-- 		-- them and proceed with death.
-- 		ShareEverythingWithTeam(thePlayer)
-- 		MeleeDoLeave(thePlayer)
-- 	else
-- 		-- If no living allies remain, swap all units and buildings over to
-- 		-- neutral_passive and proceed with death.
-- 		MakeUnitsPassiveForTeam(thePlayer)
-- 		MeleeDoLeave(thePlayer)
-- 	end
-- 	MeleeCheckForLosersAndVictors()
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerActionAllianceChange()
-- 	MeleeCheckForLosersAndVictors()
-- 	MeleeCheckForCrippledPlayers()
-- end

-- --===========================================================================
-- function BJ.MeleeTriggerTournamentFinishSoon()
-- 	-- Note: We may get this trigger multiple times
-- 	local playerIndex
-- 	local indexPlayer
-- 	local timeRemaining = GetTournamentFinishSoonTimeRemaining()

-- 	if not bj_finishSoonAllExposed then
-- 		bj_finishSoonAllExposed = true

-- 		-- Reset all crippled players and their timers, and hide the local crippled timer dialog
-- 		playerIndex = 0
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			indexPlayer = CJ.Player(playerIndex)
-- 			if bj_playerIsCrippled[playerIndex] then
-- 				-- Uncripple the player
-- 				bj_playerIsCrippled[playerIndex] = false
-- 				CJ.PauseTimer(bj_crippledTimer[playerIndex])

-- 				if CJ.GetLocalPlayer() == indexPlayer then
-- 					-- Use only local code (no net traffic) within this block to avoid desyncs.

-- 					-- Hide the timer window.
-- 					TimerDialogDisplay(bj_crippledTimerWindows[playerIndex], false)
-- 				end

-- 			end
-- 			playerIndex = playerIndex + 1
-- 			if playerIndex == BJ.bj_MAX_PLAYERS then break end
-- 		end

-- 		-- Expose all players
-- 		MeleeExposeAllPlayers()
-- 	end

-- 	-- Show the "finish soon" timer dialog and set the real time remaining
-- 	TimerDialogDisplay(bj_finishSoonTimerDialog, true)
-- 	TimerDialogSetRealTimeRemaining(bj_finishSoonTimerDialog, timeRemaining)
-- end

-- --===========================================================================
-- function BJ.MeleeWasUserPlayer(whichPlayer)
-- 	local slotState

-- 	if CJ.GetPlayerController(whichPlayer) ~= CJ.MAP_CONTROL_USER then
-- 		return false
-- 	end

-- 	slotState = CJ.GetPlayerSlotState(whichPlayer)

-- 	return slotState == CJ.PLAYER_SLOT_STATE_PLAYING or slotState == PLAYER_SLOT_STATE_LEFT
-- end

-- --===========================================================================
-- function BJ.MeleeTournamentFinishNowRuleA(multiplier)
-- 	local playerScore = _array_(0)
-- 	local teamScore = _array_(0)
-- 	local teamForce = _array_()
-- 	local teamCount
-- 	local index
-- 	local indexPlayer
-- 	local index2
-- 	local indexPlayer2
-- 	local bestTeam
-- 	local bestScore
-- 	local draw

-- 	-- Compute individual player scores
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)
-- 		if MeleeWasUserPlayer(indexPlayer) then
-- 			playerScore[index] = GetTournamentScore(indexPlayer)
-- 			if playerScore[index] <= 0 then
-- 				playerScore[index] = 1
-- 			end
-- 		else
-- 			playerScore[index] = 0
-- 		end
-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	-- Compute team scores and team forces
-- 	teamCount = 0
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		if playerScore[index] ~= 0 then
-- 			indexPlayer = CJ.Player(index)

-- 			teamScore[teamCount] = 0
-- 			teamForce[teamCount] = CJ.CreateForce()

-- 			index2 = index
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				if playerScore[index2] ~= 0 then
-- 					indexPlayer2 = CJ.Player(index2)

-- 					if PlayersAreCoAllied(indexPlayer, indexPlayer2) then
-- 						teamScore[teamCount] = teamScore[teamCount] + playerScore[index2]
-- 						CJ.ForceAddPlayer(teamForce[teamCount], indexPlayer2)
-- 						playerScore[index2] = 0
-- 					end
-- 				end

-- 				index2 = index2 + 1
-- 				if index2 == BJ.bj_MAX_PLAYERS then break end
-- 			end

-- 			teamCount = teamCount + 1
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	-- The game is now over
-- 	bj_meleeGameOver = true

-- 	-- There should always be at least one team, but continue to work if not
-- 	if teamCount ~= 0 then

-- 		-- Find best team score
-- 		bestTeam = -1
-- 		bestScore = -1
-- 		index = 0
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			if teamScore[index] > bestScore then
-- 				bestTeam = index
-- 				bestScore = teamScore[index]
-- 			end

-- 			index = index + 1
-- 			if index == teamCount then break end
-- 		end

-- 		-- Check whether the best team's score is 'multiplier' times better than
-- 		-- every other team. In the case of multiplier == 1 and exactly equal team
-- 		-- scores, the first team (which was randomly chosen by the server) will win.
-- 		draw = false
-- 		index = 0
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			if index ~= bestTeam then
-- 				if bestScore < multiplier * teamScore[index] then
-- 					draw = true
-- 				end
-- 			end

-- 			index = index + 1
-- 			if index == teamCount then break end
-- 		end

-- 		if draw then
-- 			-- Give draw to all players on all teams
-- 			index = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				ForForce(teamForce[index], MeleeDoDrawEnum)

-- 				index = index + 1
-- 				if index == teamCount then break end
-- 			end
-- 		else
-- 			-- Give defeat to all players on teams other than the best team
-- 			index = 0
-- 			for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 				if index ~= bestTeam then
-- 					ForForce(teamForce[index], MeleeDoDefeatEnum)
-- 				end

-- 				index = index + 1
-- 				if index == teamCount then break end
-- 			end

-- 			-- Give victory to all players on the best team
-- 			ForForce(teamForce[bestTeam], MeleeDoVictoryEnum)
-- 		end
-- 	end

-- end

-- --===========================================================================
-- function BJ.MeleeTriggerTournamentFinishNow()
-- 	local rule = GetTournamentFinishNowRule()

-- 	-- If the game is already over, do nothing
-- 	if bj_meleeGameOver then
-- 		return
-- 	end

-- 	if rule == 1 then
-- 		-- Finals games
-- 		MeleeTournamentFinishNowRuleA(1)
-- 	else
-- 		-- Preliminary games
-- 		MeleeTournamentFinishNowRuleA(3)
-- 	end

-- 	-- Since the game is over we should remove all observers
-- 	MeleeRemoveObservers()

-- end

-- --===========================================================================
-- function BJ.MeleeInitVictoryDefeat()
-- 	local trig
-- 	local index
-- 	local indexPlayer

-- 	-- Create a timer window for the "finish soon" timeout period, it has no timer
-- 	-- because it is driven by real time (outside of the game state to avoid desyncs)
-- 	bj_finishSoonTimerDialog = CreateTimerDialog(nil)

-- 	-- Set a trigger to fire when we receive a "finish soon" game event
-- 	trig = CJ.CreateTrigger()
-- 	TriggerRegisterGameEvent(trig, EVENT_GAME_TOURNAMENT_FINISH_SOON)
-- 	CJ.TriggerAddAction(trig, MeleeTriggerTournamentFinishSoon)

-- 	-- Set a trigger to fire when we receive a "finish now" game event
-- 	trig = CJ.CreateTrigger()
-- 	TriggerRegisterGameEvent(trig, EVENT_GAME_TOURNAMENT_FINISH_NOW)
-- 	CJ.TriggerAddAction(trig, MeleeTriggerTournamentFinishNow)

-- 	-- Set up each player's mortality code.
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		indexPlayer = CJ.Player(index)

-- 		-- Make sure this player slot is playing.
-- 		if CJ.GetPlayerSlotState(indexPlayer) == CJ.PLAYER_SLOT_STATE_PLAYING then
-- 			bj_meleeDefeated[index] = false
-- 			bj_meleeVictoried[index] = false

-- 			-- Create a timer and timer window in case the player is crippled.
-- 			bj_playerIsCrippled[index] = false
-- 			bj_playerIsExposed[index] = false
-- 			bj_crippledTimer[index] = CJ.CreateTimer()
-- 			bj_crippledTimerWindows[index] = CreateTimerDialog(bj_crippledTimer[index])
-- 			TimerDialogSetTitle(bj_crippledTimerWindows[index], MeleeGetCrippledTimerMessage(indexPlayer))

-- 			-- Set a trigger to fire whenever a building is cancelled for this player.
-- 			trig = CJ.CreateTrigger()
-- 			CJ.TriggerRegisterPlayerUnitEvent(trig, indexPlayer, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL, nil)
-- 			CJ.TriggerAddAction(trig, MeleeTriggerActionConstructCancel)

-- 			-- Set a trigger to fire whenever a unit dies for this player.
-- 			trig = CJ.CreateTrigger()
-- 			CJ.TriggerRegisterPlayerUnitEvent(trig, indexPlayer, EVENT_PLAYER_UNIT_DEATH, nil)
-- 			CJ.TriggerAddAction(trig, MeleeTriggerActionUnitDeath)

-- 			-- Set a trigger to fire whenever a unit begins construction for this player
-- 			trig = CJ.CreateTrigger()
-- 			CJ.TriggerRegisterPlayerUnitEvent(trig, indexPlayer, EVENT_PLAYER_UNIT_CONSTRUCT_START, nil)
-- 			CJ.TriggerAddAction(trig, MeleeTriggerActionUnitConstructionStart)

-- 			-- Set a trigger to fire whenever this player defeats-out
-- 			trig = CJ.CreateTrigger()
-- 			CJ.TriggerRegisterPlayerEvent(trig, indexPlayer, CJ.EVENT_PLAYER_DEFEAT)
-- 			CJ.TriggerAddAction(trig, MeleeTriggerActionPlayerDefeated)

-- 			-- Set a trigger to fire whenever this player leaves
-- 			trig = CJ.CreateTrigger()
-- 			CJ.TriggerRegisterPlayerEvent(trig, indexPlayer, CJ.EVENT_PLAYER_LEAVE)
-- 			CJ.TriggerAddAction(trig, MeleeTriggerActionPlayerLeft)

-- 			-- Set a trigger to fire whenever this player changes his/her alliances.
-- 			trig = CJ.CreateTrigger()
-- 			TriggerRegisterPlayerAllianceChange(trig, indexPlayer, CJ.ALLIANCE_PASSIVE)
-- 			TriggerRegisterPlayerStateEvent(trig, indexPlayer, PLAYER_STATE_ALLIED_VICTORY, CJ.EQUAL, 1)
-- 			CJ.TriggerAddAction(trig, MeleeTriggerActionAllianceChange)
-- 		else
-- 			bj_meleeDefeated[index] = true
-- 			bj_meleeVictoried[index] = false

-- 			-- Handle leave events for observers
-- 			if IsPlayerObserver(indexPlayer) then
-- 				-- Set a trigger to fire whenever this player leaves
-- 				trig = CJ.CreateTrigger()
-- 				CJ.TriggerRegisterPlayerEvent(trig, indexPlayer, CJ.EVENT_PLAYER_LEAVE)
-- 				CJ.TriggerAddAction(trig, MeleeTriggerActionPlayerLeft)
-- 			end
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end

-- 	-- Test for victory / defeat at startup, in case the user has already won / lost.
-- 	-- Allow for a short time to pass first, so that the map can finish loading.
-- 	CJ.TimerStart(CJ.CreateTimer(), 2.0, false, MeleeTriggerActionAllianceChange)
-- end

-- --***************************************************************************
-- --*
-- --*  CJ.Player Slot Availability
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.CheckInitPlayerSlotAvailability()
-- 	local index

-- 	if not bj_slotControlReady then
-- 		index = 0
-- 		for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 			bj_slotControlUsed[index] = false
-- 			bj_slotControl[index] = CJ.MAP_CONTROL_USER
-- 			index = index + 1
-- 			if index == BJ.bj_MAX_PLAYERS then break end
-- 		end
-- 		bj_slotControlReady = true
-- 	end
-- end

-- --===========================================================================
-- function BJ.SetPlayerSlotAvailable(whichPlayer, control)
-- 	local playerIndex = CJ.GetPlayerId(whichPlayer)

-- 	CheckInitPlayerSlotAvailability()
-- 	bj_slotControlUsed[playerIndex] = true
-- 	bj_slotControl[playerIndex] = control
-- end

-- --***************************************************************************
-- --*
-- --*  Generic Template CJ.Player-slot Initialization
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.TeamInitPlayerSlots(teamCount)
-- 	local index
-- 	local indexPlayer
-- 	local team

-- 	SetTeams(teamCount)

-- 	CheckInitPlayerSlotAvailability()
-- 	index = 0
-- 	team = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		if bj_slotControlUsed[index] then
-- 			indexPlayer = CJ.Player(index)
-- 			SetPlayerTeam(indexPlayer, team)
-- 			team = team + 1
-- 			if team >= teamCount then
-- 				team = 0
-- 			end
-- 		end

-- 		index = index + 1
-- 		if index == BJ.bj_MAX_PLAYERS then break end
-- 	end
-- end

-- --===========================================================================
-- function BJ.MeleeInitPlayerSlots()
-- 	TeamInitPlayerSlots(BJ.bj_MAX_PLAYERS)
-- end

-- --===========================================================================
-- function BJ.FFAInitPlayerSlots()
-- 	TeamInitPlayerSlots(BJ.bj_MAX_PLAYERS)
-- end

-- --===========================================================================
-- function BJ.OneOnOneInitPlayerSlots()
-- 	-- Limit the game to 2 players.
-- 	SetTeams(2)
-- 	SetPlayers(2)
-- 	TeamInitPlayerSlots(2)
-- end

-- --===========================================================================
-- function BJ.InitGenericPlayerSlots()
-- 	local gType = GetGameTypeSelected()

-- 	if gType == GAME_TYPE_MELEE then
-- 		MeleeInitPlayerSlots()
-- 	elseif gType == GAME_TYPE_FFA then
-- 		FFAInitPlayerSlots()
-- 	elseif gType == GAME_TYPE_USE_MAP_SETTINGS then
-- 	-- Do nothing; the map-specific script handles this.
-- 	elseif gType == GAME_TYPE_ONE_ON_ONE then
-- 		OneOnOneInitPlayerSlots()
-- 	elseif gType == GAME_TYPE_TWO_TEAM_PLAY then
-- 		TeamInitPlayerSlots(2)
-- 	elseif gType == GAME_TYPE_THREE_TEAM_PLAY then
-- 		TeamInitPlayerSlots(3)
-- 	elseif gType == GAME_TYPE_FOUR_TEAM_PLAY then
-- 		TeamInitPlayerSlots(4)
-- 	else
-- 	-- Unrecognized Game Type
-- 	end
-- end

-- ***************************************************************************
-- *
-- *  Blizzard.j Initialization
-- *
-- ***************************************************************************

-- ===========================================================================
function BJ.SetDNCSoundsDawn()
    if BJ.bj_useDawnDuskSounds then CJ.StartSound(BJ.bj_dawnSound) end
end

-- ===========================================================================
function BJ.SetDNCSoundsDusk()
    if BJ.bj_useDawnDuskSounds then CJ.StartSound(BJ.bj_duskSound) end
end

-- ===========================================================================
function BJ.SetDNCSoundsDay()
    local ToD = BJ.GetTimeOfDay()

    if ToD >= BJ.bj_TOD_DAWN and ToD < BJ.bj_TOD_DUSK and not BJ.bj_dncIsDaytime then
        BJ.bj_dncIsDaytime = true

        -- change ambient sounds
        CJ.StopSound(BJ.bj_nightAmbientSound, false, true)
        CJ.StartSound(BJ.bj_dayAmbientSound)
    end
end

-- ===========================================================================
function BJ.SetDNCSoundsNight()
    local ToD = BJ.GetTimeOfDay()

    if (ToD < BJ.bj_TOD_DAWN or ToD >= BJ.bj_TOD_DUSK) and BJ.bj_dncIsDaytime then
        BJ.bj_dncIsDaytime = false

        -- change ambient sounds
        CJ.StopSound(BJ.bj_dayAmbientSound, false, true)
        CJ.StartSound(BJ.bj_nightAmbientSound)
    end
end

-- ===========================================================================
function BJ.InitDNCSounds()
    -- Create sounds to be played at dawn and dusk.
    BJ.bj_dawnSound = CJ.CreateSoundFromLabel("RoosterSound", false, false,
                                              false, 10000, 10000)
    BJ.bj_duskSound = CJ.CreateSoundFromLabel("WolfSound", false, false, false,
                                              10000, 10000)

    -- Set up triggers to respond to dawn and dusk.
    BJ.bj_dncSoundsDawn = CJ.CreateTrigger()
    CJ.TriggerRegisterGameStateEvent(BJ.bj_dncSoundsDawn,
                                     CJ.GAME_STATE_TIME_OF_DAY, CJ.EQUAL,
                                     BJ.bj_TOD_DAWN)
    CJ.TriggerAddAction(BJ.bj_dncSoundsDawn, BJ.SetDNCSoundsDawn)

    BJ.bj_dncSoundsDusk = CJ.CreateTrigger()
    CJ.TriggerRegisterGameStateEvent(BJ.bj_dncSoundsDusk,
                                     CJ.GAME_STATE_TIME_OF_DAY, CJ.EQUAL,
                                     BJ.bj_TOD_DUSK)
    CJ.TriggerAddAction(BJ.bj_dncSoundsDusk, BJ.SetDNCSoundsDusk)

    -- Set up triggers to respond to changes from day to night or vice-versa.
    BJ.bj_dncSoundsDay = CJ.CreateTrigger()
    CJ.TriggerRegisterGameStateEvent(BJ.bj_dncSoundsDay,
                                     CJ.GAME_STATE_TIME_OF_DAY,
                                     CJ.GREATER_THAN_OR_EQUAL, BJ.bj_TOD_DAWN)
    CJ.TriggerRegisterGameStateEvent(BJ.bj_dncSoundsDay,
                                     CJ.GAME_STATE_TIME_OF_DAY, CJ.LESS_THAN,
                                     BJ.bj_TOD_DUSK)
    CJ.TriggerAddAction(BJ.bj_dncSoundsDay, BJ.SetDNCSoundsDay)

    BJ.bj_dncSoundsNight = CJ.CreateTrigger()
    CJ.TriggerRegisterGameStateEvent(BJ.bj_dncSoundsNight,
                                     CJ.GAME_STATE_TIME_OF_DAY, CJ.LESS_THAN,
                                     BJ.bj_TOD_DAWN)
    CJ.TriggerRegisterGameStateEvent(BJ.bj_dncSoundsNight,
                                     CJ.GAME_STATE_TIME_OF_DAY,
                                     CJ.GREATER_THAN_OR_EQUAL, BJ.bj_TOD_DUSK)
    CJ.TriggerAddAction(BJ.bj_dncSoundsNight, BJ.SetDNCSoundsNight)
end

-- ===========================================================================
function BJ.InitBlizzardGlobals()
    local index
    local userControlledPlayers
    local v

    -- Init filter function BJ.vars
    BJ.filterIssueHauntOrderAtLocBJ = CJ.Filter(BJ.IssueHauntOrderAtLocBJFilter)
    BJ.filterEnumDestructablesInCircleBJ = CJ.Filter(
                                               BJ.EnumDestructablesInCircleBJFilter)
    BJ.filterGetUnitsInRectOfPlayer = CJ.Filter(BJ.GetUnitsInRectOfPlayerFilter)
    BJ.filterGetUnitsOfTypeIdAll = CJ.Filter(BJ.GetUnitsOfTypeIdAllFilter)
    BJ.filterGetUnitsOfPlayerAndTypeId = CJ.Filter(
                                             BJ.GetUnitsOfPlayerAndTypeIdFilter)
    BJ.filterMeleeTrainedUnitIsHeroBJ = CJ.Filter(
                                            BJ.MeleeTrainedUnitIsHeroBJFilter)
    BJ.filterLivingPlayerUnitsOfTypeId = CJ.Filter(
                                             BJ.LivingPlayerUnitsOfTypeIdFilter)

    -- Init force presets
    index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if index == BJ.bj_MAX_PLAYER_SLOTS then break end
        BJ.bj_FORCE_PLAYER[index] = CJ.CreateForce()
        CJ.ForceAddPlayer(BJ.bj_FORCE_PLAYER[index], CJ.Player(index))
        index = index + 1
    end

    BJ.bj_FORCE_ALL_PLAYERS = CJ.CreateForce()
    CJ.ForceEnumPlayers(BJ.bj_FORCE_ALL_PLAYERS, nil)

    -- Init Cinematic Mode history
    BJ.bj_cineModePriorSpeed = CJ.GetGameSpeed()
    BJ.bj_cineModePriorFogSetting = CJ.IsFogEnabled()
    BJ.bj_cineModePriorMaskSetting = CJ.IsFogMaskEnabled()

    -- Init Trigger Queue
    index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if index >= BJ.bj_MAX_QUEUED_TRIGGERS then break end
        BJ.bj_queuedExecTriggers[index] = nil
        BJ.bj_queuedExecUseConds[index] = false
        index = index + 1
    end

    -- Init singleplayer check
    BJ.bj_isSinglePlayer = false
    userControlledPlayers = 0
    index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if index >= BJ.bj_MAX_PLAYERS then break end
        if CJ.GetPlayerController(CJ.Player(index)) == CJ.MAP_CONTROL_USER and
            CJ.GetPlayerSlotState(CJ.Player(index)) ==
            CJ.PLAYER_SLOT_STATE_PLAYING then
            userControlledPlayers = userControlledPlayers + 1
        end
        index = index + 1
    end
    BJ.bj_isSinglePlayer = userControlledPlayers == 1

    -- Init sounds
    -- set bj_pingMinimapSound = CJ.CreateSoundFromLabel("AutoCastButtonClick", false, false, false, 10000, 10000)
    BJ.bj_rescueSound = CJ.CreateSoundFromLabel("Rescue", false, false, false,
                                                10000, 10000)
    BJ.bj_questDiscoveredSound = CJ.CreateSoundFromLabel("QuestNew", false,
                                                         false, false, 10000,
                                                         10000)
    BJ.bj_questUpdatedSound = CJ.CreateSoundFromLabel("QuestUpdate", false,
                                                      false, false, 10000, 10000)
    BJ.bj_questCompletedSound = CJ.CreateSoundFromLabel("QuestCompleted", false,
                                                        false, false, 10000,
                                                        10000)
    BJ.bj_questFailedSound = CJ.CreateSoundFromLabel("QuestFailed", false,
                                                     false, false, 10000, 10000)
    BJ.bj_questHintSound = CJ.CreateSoundFromLabel("Hint", false, false, false,
                                                   10000, 10000)
    BJ.bj_questSecretSound = CJ.CreateSoundFromLabel("SecretFound", false,
                                                     false, false, 10000, 10000)
    BJ.bj_questItemAcquiredSound = CJ.CreateSoundFromLabel("ItemReward", false,
                                                           false, false, 10000,
                                                           10000)
    BJ.bj_questWarningSound = CJ.CreateSoundFromLabel("Warning", false, false,
                                                      false, 10000, 10000)
    BJ.bj_victoryDialogSound = CJ.CreateSoundFromLabel("QuestCompleted", false,
                                                       false, false, 10000,
                                                       10000)
    BJ.bj_defeatDialogSound = CJ.CreateSoundFromLabel("QuestFailed", false,
                                                      false, false, 10000, 10000)

    -- Init corpse creation triggers.
    BJ.DelayedSuspendDecayCreate()

    -- Init version-specific data
    v = CJ.VersionGet()
    if v == CJ.VERSION_REIGN_OF_CHAOS then
        BJ.bj_MELEE_MAX_TWINKED_HEROES = BJ.bj_MELEE_MAX_TWINKED_HEROES_V0
    else
        BJ.bj_MELEE_MAX_TWINKED_HEROES = BJ.bj_MELEE_MAX_TWINKED_HEROES_V1
    end
end

-- ===========================================================================
function BJ.InitQueuedTriggers()
    BJ.bj_queuedExecTimeout = CJ.CreateTrigger()
    CJ.TriggerRegisterTimerExpireEvent(BJ.bj_queuedExecTimeout,
                                       BJ.bj_queuedExecTimeoutTimer)
    CJ.TriggerAddAction(BJ.bj_queuedExecTimeout, BJ.QueuedTriggerDoneBJ)
end

-- ===========================================================================
function BJ.InitMapRects()
    BJ.bj_mapInitialPlayableArea = CJ.Rect(
                                       CJ.GetCameraBoundMinX() -
                                           CJ.GetCameraMargin(
                                               CJ.CAMERA_MARGIN_LEFT),
                                       CJ.GetCameraBoundMinY() -
                                           CJ.GetCameraMargin(
                                               CJ.CAMERA_MARGIN_BOTTOM),
                                       CJ.GetCameraBoundMaxX() +
                                           CJ.GetCameraMargin(
                                               CJ.CAMERA_MARGIN_RIGHT),
                                       CJ.GetCameraBoundMaxY() +
                                           CJ.GetCameraMargin(
                                               CJ.CAMERA_MARGIN_TOP))
    BJ.bj_mapInitialCameraBounds = BJ.GetCurrentCameraBoundsMapRectBJ()
end

-- ===========================================================================
function BJ.InitSummonableCaps()
    local index

    index = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        -- upgraded units
        -- Note: Only do this if the corresponding upgrade is not yet researched
        -- Barrage - Siege Engines
        if not CJ.GetPlayerTechResearched(CJ.Player(index), 1382576756, true) then
            CJ.SetPlayerTechMaxAllowed(CJ.Player(index), 1752331380, 0)
        end

        -- Berserker Upgrade - Troll Berserkers
        if not CJ.GetPlayerTechResearched(CJ.Player(index), 1383031403, true) then
            CJ.SetPlayerTechMaxAllowed(CJ.Player(index), 1869898347, 0)
        end

        -- max skeletons per player
        CJ.SetPlayerTechMaxAllowed(CJ.Player(index), 1970498405,
                                   BJ.bj_MAX_SKELETONS)

        index = index + 1
        if index == BJ.bj_MAX_PLAYERS then break end
    end
end

-- --===========================================================================
-- -- Update the per-class stock limits.
-- --
-- function BJ.UpdateStockAvailability(whichItem)
-- 	local iType = GetItemType(whichItem)
-- 	local iLevel = GetItemLevel(whichItem)

-- 	-- Update allowed type/level combinations.
-- 	if iType == CJ.ITEM_TYPE_PERMANENT then
-- 		BJ.bj_stockAllowedPermanent[iLevel] = true
-- 	elseif iType == CJ.ITEM_TYPE_CHARGED then
-- 		BJ.bj_stockAllowedCharged[iLevel] = true
-- 	elseif iType == CJ.ITEM_TYPE_ARTIFACT then
-- 		BJ.bj_stockAllowedArtifact[iLevel] = true
-- 	else
-- 	-- Not interested in this item type - ignore the item.
-- 	end
-- end

-- ===========================================================================
-- Find a sellable item of the given type and level, and then add it.
--
function BJ.UpdateEachStockBuildingEnum()
    local iteration = 0
    local pickedItemId

    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        pickedItemId = CJ.ChooseRandomItemEx(BJ.bj_stockPickedItemType,
                                             BJ.bj_stockPickedItemLevel)
        if CJ.IsItemIdSellable(pickedItemId) then break end

        -- If we get hung up on an entire class/level combo of unsellable
        -- items, or a very unlucky series of random numbers, give up.
        iteration = iteration + 1
        if iteration > BJ.bj_STOCK_MAX_ITERATIONS then return end
    end
    CJ.AddItemToStock(CJ.GetEnumUnit(), pickedItemId, 1, 1)
end

-- ===========================================================================
function BJ.UpdateEachStockBuilding(iType, iLevel)
    local g

    BJ.bj_stockPickedItemType = iType
    BJ.bj_stockPickedItemLevel = iLevel

    g = CJ.CreateGroup()
    CJ.GroupEnumUnitsOfType(g, "marketplace", nil)
    CJ.ForGroup(g, BJ.UpdateEachStockBuildingEnum)
    CJ.DestroyGroup(g)
end

-- ===========================================================================
-- Update stock inventory.
--
function BJ.PerformStockUpdates()
    local pickedItemId
    local pickedItemType
    local pickedItemLevel = 0
    local allowedCombinations = 0
    local iLevel

    -- Give each type/level combination a chance of being picked.
    iLevel = 1
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        if BJ.bj_stockAllowedPermanent[iLevel] then
            allowedCombinations = allowedCombinations + 1
            if CJ.GetRandomInt(1, allowedCombinations) == 1 then
                pickedItemType = CJ.ITEM_TYPE_PERMANENT
                pickedItemLevel = iLevel
            end
        end
        if BJ.bj_stockAllowedCharged[iLevel] then
            allowedCombinations = allowedCombinations + 1
            if CJ.GetRandomInt(1, allowedCombinations) == 1 then
                pickedItemType = CJ.ITEM_TYPE_CHARGED
                pickedItemLevel = iLevel
            end
        end
        if BJ.bj_stockAllowedArtifact[iLevel] then
            allowedCombinations = allowedCombinations + 1
            if CJ.GetRandomInt(1, allowedCombinations) == 1 then
                pickedItemType = CJ.ITEM_TYPE_ARTIFACT
                pickedItemLevel = iLevel
            end
        end

        iLevel = iLevel + 1
        if iLevel > BJ.bj_MAX_ITEM_LEVEL then break end
    end

    -- Make sure we found a valid item type to add.
    if allowedCombinations == 0 then return end

    BJ.UpdateEachStockBuilding(pickedItemType, pickedItemLevel)
end

-- ===========================================================================
-- Perform the first update, and then arrange future updates.
--
function BJ.StartStockUpdates()
    BJ.PerformStockUpdates()
    CJ.TimerStart(BJ.bj_stockUpdateTimer, BJ.bj_STOCK_RESTOCK_INTERVAL, true,
                  BJ.PerformStockUpdates)
end

-- ===========================================================================
function BJ.RemovePurchasedItem()
    CJ.RemoveItemFromStock(CJ.GetSellingUnit(),
                           CJ.GetItemTypeId(CJ.GetSoldItem()))
end

-- ===========================================================================
function BJ.InitNeutralBuildings()
    local iLevel

    -- Chart of allowed stock items.
    iLevel = 0
    for index = 0, BJ.bj_MAX_PLAYER_SLOTS - 1 do
        BJ.bj_stockAllowedPermanent[iLevel] = false
        BJ.bj_stockAllowedCharged[iLevel] = false
        BJ.bj_stockAllowedArtifact[iLevel] = false
        iLevel = iLevel + 1
        if iLevel > BJ.bj_MAX_ITEM_LEVEL then break end
    end

    -- Limit stock inventory slots.
    CJ.SetAllItemTypeSlots(BJ.bj_MAX_STOCK_ITEM_SLOTS)
    CJ.SetAllUnitTypeSlots(BJ.bj_MAX_STOCK_UNIT_SLOTS)

    -- Arrange the first update.
    BJ.bj_stockUpdateTimer = CJ.CreateTimer()
    CJ.TimerStart(BJ.bj_stockUpdateTimer, BJ.bj_STOCK_RESTOCK_INITIAL_DELAY,
                  false, BJ.StartStockUpdates)

    -- Set up a trigger to fire whenever an item is sold.
    BJ.bj_stockItemPurchased = CJ.CreateTrigger()
    CJ.TriggerRegisterPlayerUnitEvent(BJ.bj_stockItemPurchased,
                                      CJ.Player(CJ.PLAYER_NEUTRAL_PASSIVE),
                                      CJ.EVENT_PLAYER_UNIT_SELL_ITEM, nil)
    CJ.TriggerAddAction(BJ.bj_stockItemPurchased, BJ.RemovePurchasedItem)
end

-- ===========================================================================
function BJ.MarkGameStarted()
    BJ.bj_gameStarted = true
    CJ.DestroyTimer(BJ.bj_gameStartedTimer)
end

-- ===========================================================================
function BJ.DetectGameStarted()
    BJ.bj_gameStartedTimer = CJ.CreateTimer()
    CJ.TimerStart(BJ.bj_gameStartedTimer, BJ.bj_GAME_STARTED_THRESHOLD, false,
                  BJ.MarkGameStarted)
end

-- ===========================================================================
function BJ.InitBlizzard()
	BJ.InitVariables()
    -- Set up the Neutral Victim player slot, to torture the abandoned units
    -- of defeated players.  Since some triggers expect this player slot to
    -- exist, this is performed for all maps.
    BJ.ConfigureNeutralVictim()

    BJ.InitBlizzardGlobals()
    BJ.InitQueuedTriggers()
    BJ.InitRescuableBehaviorBJ()
    BJ.InitDNCSounds()
    BJ.InitMapRects()
    BJ.InitSummonableCaps()
    BJ.InitNeutralBuildings()
    BJ.DetectGameStarted()
end

-- --***************************************************************************
-- --*
-- --*  Random distribution
-- --*
-- --*  Used to select a random object from a given distribution of chances
-- --*
-- --*  - RandomDistReset clears the distribution list
-- --*
-- --*  - RandomDistAddItem adds a new object to the distribution list
-- --*    with a given identifier and an integer chance to be chosen
-- --*
-- --*  - RandomDistChoose will use the current distribution list to choose
-- --*    one of the objects randomly based on the chance distribution
-- --*  
-- --*  Note that the chances are effectively normalized by their sum,
-- --*  so only the relative values of each chance are important
-- --*
-- --***************************************************************************

-- --===========================================================================
-- function BJ.RandomDistReset()
-- 	bj_randDistCount = 0
-- end

-- --===========================================================================
-- function BJ.RandomDistAddItem(inID, inChance)
-- 	bj_randDistID[bj_randDistCount] = inID
-- 	bj_randDistChance[bj_randDistCount] = inChance
-- 	bj_randDistCount = bj_randDistCount + 1
-- end

-- --===========================================================================
-- function BJ.RandomDistChoose()
-- 	local sum = 0
-- 	local chance = 0
-- 	local index
-- 	local foundID = -1
-- 	local done

-- 	-- No items?
-- 	if bj_randDistCount == 0 then
-- 		return -1
-- 	end

-- 	-- Find sum of all chances
-- 	index = 0
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		sum = sum + bj_randDistChance[index]

-- 		index = index + 1
-- 		if index == bj_randDistCount then break end
-- 	end

-- 	-- Choose random number within the total range
-- 	chance = CJ.GetRandomInt(1, sum)

-- 	-- Find ID which corresponds to this chance
-- 	index = 0
-- 	sum = 0
-- 	done = false
-- 	for index = 0, BJ.bj_MAX_PLAYER_SLOTS-1 do
-- 		sum = sum + bj_randDistChance[index]

-- 		if chance <= sum then
-- 			foundID = bj_randDistID[index]
-- 			done = true
-- 		end

-- 		index = index + 1
-- 		if index == bj_randDistCount then
-- 			done = true
-- 		end

-- 		if done == true then break end
-- 	end

-- 	return foundID
-- end

-- --***************************************************************************
-- --*
-- --*  Drop item
-- --*
-- --*  Makes the given unit drop the given item
-- --*
-- --*  Note: This could potentially cause problems if the unit is standing
-- --*        right on the edge of an unpathable area and happens to drop the
-- --*        item into the unpathable area where nobody can get it...
-- --*
-- --***************************************************************************

-- function BJ.UnitDropItem(inUnit, inItemID)
-- 	local x
-- 	local y
-- 	local radius = 32
-- 	local unitX
-- 	local unitY
-- 	local droppedItem

-- 	if inItemID == -1 then
-- 		return nil
-- 	end

-- 	unitX = CJ.GetUnitX(inUnit)
-- 	unitY = CJ.GetUnitY(inUnit)

-- 	x = CJ.GetRandomReal(unitX - radius, unitX + radius)
-- 	y = CJ.GetRandomReal(unitY - radius, unitY + radius)

-- 	droppedItem = CreateItem(inItemID, x, y)

-- 	SetItemDropID(droppedItem, CJ.GetUnitTypeId(inUnit))
-- 	UpdateStockAvailability(droppedItem)

-- 	return droppedItem
-- end

-- --===========================================================================
-- function BJ.WidgetDropItem(inWidget, inItemID)
-- 	local x
-- 	local y
-- 	local radius = 32
-- 	local widgetX
-- 	local widgetY

-- 	if inItemID == -1 then
-- 		return nil
-- 	end

-- 	widgetX = GetWidgetX(inWidget)
-- 	widgetY = GetWidgetY(inWidget)

-- 	x = CJ.GetRandomReal(widgetX - radius, widgetX + radius)
-- 	y = CJ.GetRandomReal(widgetY - radius, widgetY + radius)

-- 	return CreateItem(inItemID, x, y)
-- end

return BJ

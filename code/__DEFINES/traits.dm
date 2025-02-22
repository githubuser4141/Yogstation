#define SIGNAL_ADDTRAIT(trait_ref) "addtrait [trait_ref]"
#define SIGNAL_REMOVETRAIT(trait_ref) "removetrait [trait_ref]"

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
			SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
				SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			};\
			if (!length(_L[trait])) { \
				_L -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAIT_NOT_FROM(target, trait, sources) \
	do { \
		var/list/_traits_list = target.status_traits; \
		var/list/_sources_list; \
		if (sources && !islist(sources)) { \
			_sources_list = list(sources); \
		} else { \
			_sources_list = sources\
		}; \
		if (_traits_list && _traits_list[trait]) { \
			for (var/_trait_source in _traits_list[trait]) { \
				if (!(_trait_source in _sources_list)) { \
					_traits_list[trait] -= _trait_source \
				} \
			};\
			if (!length(_traits_list[trait])) { \
				_traits_list -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_traits_list)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T), _T); \
					}; \
				};\
			if (!length(_L)) { \
				target.status_traits = null\
			};\
		}\
	} while (0)

#define REMOVE_TRAITS_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] -= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T)); \
					}; \
				};\
			if (!length(_L)) { \
				target.status_traits = null\
			};\
		}\
	} while (0)
#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)

//Remember to update code/datums/traits/ folder if you're adding/removing/renaming traits.

//mob traits
/// Forces the user to stay unconscious.
#define TRAIT_KNOCKEDOUT 		"knockedout"
/// Prevents voluntary movement.
#define TRAIT_IMMOBILIZED 		"immobilized"
/// Prevents voluntary standing or staying up on its own.
#define TRAIT_FLOORED 			"floored"
/// Forces user to stay standing
#define TRAIT_FORCED_STANDING 	"forcedstanding"
/// Prevents usage of manipulation appendages (picking, holding or using items, manipulating storage).
#define TRAIT_HANDS_BLOCKED 	"handsblocked"
/// Inability to access UI hud elements. Turned into a trait from [MOBILITY_UI] to be able to track sources.
#define TRAIT_UI_BLOCKED "uiblocked"
/// Inability to pull things. Turned into a trait from [MOBILITY_PULL] to be able to track sources.
#define TRAIT_PULL_BLOCKED "pullblocked"
/// Abstract condition that prevents movement if being pulled and might be resisted against. Handcuffs and straight jackets, basically.
#define TRAIT_RESTRAINED 		"restrained"
/// In some kind of critical condition. Is able to succumb.
#define TRAIT_CRITICAL_CONDITION "critical-condition"
/// Is frozen in place
#define TRAIT_FROZEN "frozen"
/// trait associated to a stat value or range of
#define STAT_TRAIT 				"stat"
#define TRAIT_INCAPACITATED 	"incapacitated"
#define HANDCUFFED_TRAIT 		"handcuffed"
#define TRAIT_BLIND 			"blind"
#define TRAIT_ECHOLOCATION_RECEIVER "echolocation_receiver"
#define TRAIT_MUTE				"mute"
#define TRAIT_EMOTEMUTE			"emotemute"
#define TRAIT_DEAF				"deaf"
#define TRAIT_NEARSIGHT			"nearsighted"
#define TRAIT_FAT				"fat"
#define TRAIT_HUSK				"husk"
#define TRAIT_BADDNA			"baddna"
#define TRAIT_CLUMSY			"clumsy"
#define TRAIT_DUMB				"dumb"
#define TRAIT_MONKEYLIKE		"monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM			"pacifism"
#define TRAIT_IGNORESLOWDOWN	"ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
#define TRAIT_REDUCED_DAMAGE_SLOWDOWN "reduced_damage_slowdown"
#define TRAIT_RESISTDAMAGESLOWDOWN "resistdamageslowdown"
#define TRAIT_HIGHRESISTDAMAGESLOWDOWN "highresistdamageslowdown"
#define TRAIT_DEATHCOMA			"deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH			"fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_DISFIGURED		"disfigured"
#define TRAIT_XENO_HOST			"xeno_host"	//Tracks whether we're gonna be a baby alien's mummy.
#define TRAIT_STUNIMMUNE		"stun_immunity"
#define TRAIT_SLEEPIMMUNE		"sleep_immunity"
#define TRAIT_IMPACTIMMUNE		"impact_immunity" //protects from the damage of getting launched into a wall hard
#define TRAIT_PUSHIMMUNE		"push_immunity"
#define TRAIT_SHOCKIMMUNE		"shock_immunity"
/// Prevents you from leaving your corpse
#define TRAIT_CORPSELOCKED 		"corpselocked"
#define TRAIT_STABLEHEART		"stable_heart"
#define TRAIT_STABLELIVER		"stable_liver"
#define TRAIT_RESISTHEAT		"resist_heat"
#define TRAIT_RESISTHEATHANDS	"resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD		"resist_cold"
#define TRAIT_RESISTHIGHPRESSURE	"resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE	"resist_low_pressure"
#define TRAIT_BOMBIMMUNE		"bomb_immunity"
#define TRAIT_RADIMMUNE			"rad_immunity"
#define TRAIT_EMPPROOF_SELF		"emp_immunity_self" //for the specific "thing" itself
#define TRAIT_EMPPROOF_CONTENTS "emp_immunity_contents" //for anything the "thing" is carrying, but not itself
#define TRAIT_GENELESS  		"geneless"
#define TRAIT_VIRUSIMMUNE		"virus_immunity"
#define TRAIT_PIERCEIMMUNE		"pierce_immunity"
#define TRAIT_NODISMEMBER		"dismember_immunity"
#define TRAIT_SAFEWELD		"safe_welding" //prevents blinding from welding without giving actual flash immunity
#define TRAIT_NOFIRE			"nonflammable"
#define TRAIT_NOGUNS			"no_guns"
#define TRAIT_NO_STUN_WEAPONS	"no_stun_weapons" //prevents use of commonly available instant or near instant stun weapons
#define TRAIT_NOINTERACT		"no_interact" //Not allowed to touch anything (even with TK) or use things in hand
#define TRAIT_NOHUNGER			"no_hunger"
#define TRAIT_POWERHUNGRY		"power_hungry" // uses electricity instead of food
#define TRAIT_EASYDISMEMBER		"easy_dismember"
#define TRAIT_LIMBATTACHMENT 	"limb_attach"
#define TRAIT_NOLIMBDISABLE		"no_limb_disable"
#define TRAIT_EASILY_WOUNDED		"easy_limb_wound"
#define TRAIT_HARDLY_WOUNDED		"hard_limb_wound"
#define TRAIT_TOXINLOVER		"toxinlover"
#define TRAIT_TOXIMMUNE         "toxin_immune"
#define TRAIT_NOBREATH			"no_breath"
/// This mob is antimagic, and immune to spells / cannot cast spells
#define TRAIT_ANTIMAGIC "anti_magic"
/// This allows a person who has antimagic to cast spells without getting blocked
#define TRAIT_ANTIMAGIC_NO_SELFBLOCK "anti_magic_no_selfblock"
/// This mob recently blocked magic with some form of antimagic
#define TRAIT_RECENTLY_BLOCKED_MAGIC "recently_blocked_magic"
#define TRAIT_HOLY				"holy"
#define TRAIT_DEPRESSION		"depression"
#define TRAIT_JOLLY				"jolly"
#define TRAIT_NOCRITDAMAGE		"no_crit"
#define TRAIT_NOSLIPICE			"noslip_ice"
#define TRAIT_NOSLIPWATER		"noslip_water"
#define TRAIT_NOSLIPALL			"noslip_all"
#define TRAIT_NODEATH			"nodeath"
#define TRAIT_NOHARDCRIT		"nohardcrit"
#define TRAIT_NOSOFTCRIT		"nosoftcrit"
#define TRAIT_MINDSHIELD		"mindshield"
#define TRAIT_DISSECTED			"dissected"
#define TRAIT_SIXTHSENSE		"sixth_sense" //I can hear dead people
#define TRAIT_FEARLESS			"fearless"
#define TRAIT_PARALYSIS_L_ARM	"para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM	"para-r-arm"
#define TRAIT_PARALYSIS_L_LEG	"para-l-leg"
#define TRAIT_PARALYSIS_R_LEG	"para-r-leg"
#define TRAIT_CANNOT_OPEN_PRESENTS "cannot-open-presents"
#define TRAIT_PRESENT_VISION    "present-vision"
#define TRAIT_DISK_VERIFIER     "disk-verifier"
#define TRAIT_NOMOBSWAP         "no-mob-swap"
#define TRAIT_XRAY_VISION       "xray_vision"
#define TRAIT_THERMAL_VISION    "thermal_vision"
#define TRAIT_INFRARED_VISION	"infrared_vision"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON           "surgeon"
#define	TRAIT_STRONG_GRABBER	"strong_grabber"
#define	TRAIT_CALCIUM_HEALER	"calcium_healer"
#define	TRAIT_MAGIC_CHOKE		"magic_choke"
#define TRAIT_SOOTHED_THROAT    "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_PSYCH				"psych-diagnosis"
#define TRAIT_ALWAYS_CLEAN      "always-clean"
#define TRAIT_BOOZE_SLIDER      "booze-slider"
#define TRAIT_QUICK_CARRY		"quick-carry"
#define TRAIT_QUICKER_CARRY		"quicker-carry"
#define TRAIT_QUICKEST_CARRY	"quickest-carry"
#define TRAIT_STRONG_GRIP		"strong-grip"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_UNSTABLE			"unstable"
#define TRAIT_OIL_FRIED			"oil_fried"
#define TRAIT_SHELTERED			"sheltered"
#define TRAIT_RANDOM_ACCENT		"random_accent"
#define TRAIT_MEDICALIGNORE     "medical_ignore"
#define TRAIT_PASSTABLE			"passtable"
#define TRAIT_SLIME_EMPATHY		"slime-empathy"
#define TRAIT_ACIDBLOOD         "acid_blood"
#define TRAIT_PRESERVED_ORGANS	"preserved_organs"
#define TRAIT_SKINNY			"skinny"  //For those with a slightly thinner torso sprite
#define TRAIT_SURGERY_PREPARED	"surgery_prepared"
#define TRAIT_NO_PASSIVE_COOLING "no-passive-cooling"
#define TRAIT_NO_PASSIVE_HEATING "no-passive-heating"
#define TRAIT_BLOODY_MESS		"bloody_mess" //from heparin, makes open bleeding wounds rapidly spill more blood
#define TRAIT_BLOODY_MESS_LITE	"bloody_mess_lite" //weak heparin, otherwise the same
#define TRAIT_COAGULATING		"coagulating" //from coagulant reagents, this doesn't affect the bleeding itself but does affect the bleed warning messages
#define TRAIT_NOPULSE           "nopulse" // Your heart doesn't beat
#define TRAIT_MASQUERADE        "masquerade" // Falsifies Health analyzer blood levels
#define TRAIT_NOCLONE			"noclone" // No cloning
#define TRAIT_NODEFIB			"nodefib" // No defibbing
#define TRAIT_COLDBLOODED       "coldblooded" // Your body is literal room temperature. Does not make you immune to the temp
#define TRAIT_EAT_MORE			"eat_more" //You get hungry three times as fast
#define TRAIT_BOTTOMLESS_STOMACH "bottomless_stomach" // Can never be full
#define TRAIT_MESONS			"mesons"
#define TRAIT_MAGBOOTS			"magboots"
#define TRAIT_BADMAIL			"badmail"	//Your mail is going to be worse than average
#define TRAIT_SHORT_TELOMERES	"short_telomeres" //You cannot be CLOONED
#define TRAIT_LONG_TELOMERES	"long_telomeres" //You get CLOONED faster!!!
///You become a Marine that can eat crayons!!!
#define TRAIT_MARINE  "marine"
/// makes your footsteps completely silent
#define TRAIT_SILENT_FOOTSTEPS "silent_footsteps"
/// Immune to being afflicted by time stop (spell)
#define TRAIT_TIME_STOP_IMMUNE "time_stop_immune"
/// This mob has no soul
#define TRAIT_NO_SOUL "no_soul"
/// Whether a spider's consumed this mob
#define TRAIT_SPIDER_CONSUMED "spider_consumed"
/// Whether we're sneaking, from the alien sneak ability.
/// Maybe worth generalizing into a general "is sneaky" / "is stealth" trait in the future.
#define TRAIT_ALIEN_SNEAK "sneaking_alien"
/// This mob is phased out of reality from magic, either a jaunt or rod form
#define TRAIT_MAGICALLY_PHASED "magically_phased"
///This mob can't use vehicles
#define TRAIT_NOVEHICLE	"no_vehicle"
/// BALD!!!
#define TRAIT_BALD "bald"
/// You can't see color!
#define TRAIT_COLORBLIND "color_blind"

/// This person is crying
#define TRAIT_CRYING "crying"
/// This human wants to see the color of their glasses, for some reason
#define TRAIT_SEE_GLASS_COLORS "see_glass_colors"

//non-mob traits
/// Used for limb-based paralysis, where replacing the limb will fix it.
#define TRAIT_PARALYSIS				"paralysis"
/// Used for limbs.
#define TRAIT_DISABLED_BY_WOUND		"disabled-by-wound"

// item traits
#define TRAIT_NODROP            "nodrop"
#define TRAIT_T_RAY_VISIBLE     "t-ray-visible" // Visible on t-ray scanners if the atom/var/level == 1
/// Properly wielded two handed item
#define TRAIT_WIELDED "wielded"
/// The items needs two hands to be carried
#define TRAIT_NEEDS_TWO_HANDS "needstwohands"
#define TRAIT_NO_TELEPORT		"no-teleport" //you just can't
#define TRAIT_NO_STORAGE		"no-storage" //you cannot put this in any container, backpack, box etc

#define TRAIT_ALCOHOL_TOLERANCE	"alcohol_tolerance"
#define TRAIT_AGEUSIA			"ageusia"
#define TRAIT_HEAVY_SLEEPER		"heavy_sleeper"
#define TRAIT_NIGHT_VISION		"night_vision"
#define TRAIT_LIGHT_STEP "light_step"
#define TRAIT_SPIRITUAL			"spiritual"
#define TRAIT_VORACIOUS			"voracious"
#define TRAIT_SELF_AWARE		"self_aware"
#define TRAIT_FREERUNNING		"freerunning"
#define TRAIT_SKITTISH			"skittish"
#define TRAIT_POOR_AIM			"poor_aim"
#define TRAIT_PROSOPAGNOSIA		"prosopagnosia"
#define TRAIT_DRUNK_HEALING		"drunk_healing"
#define TRAIT_TAGGER			"tagger"
#define TRAIT_PHOTOGRAPHER		"photographer"
#define TRAIT_MUSICIAN			"musician"
#define TRAIT_LIGHT_DRINKER		"light_drinker"
#define TRAIT_EMPATH			"empath"
#define TRAIT_FRIENDLY			"friendly"
#define TRAIT_ALLERGIC			"allergic"
#define TRAIT_KLEPTOMANIAC		"kleptomaniac"
#define TRAIT_EAT_LESS			"eat_less"
#define TRAIT_CRAFTY			"crafty"
#define TRAIT_ANOREXIC			"anorexic"
#define TRAIT_SHIFTY_EYES		"shifty_eyes"
#define TRAIT_ANXIOUS			"anxious"
#define TRAIT_SEE_REAGENTS		"see_reagents"
#define TRAIT_STARGAZED			"stargazed"

// common trait sources
#define TRAIT_GENERIC "generic"
#define UNCONSCIOUS_TRAIT "unconscious"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define OBESITY "obesity"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CULT_TRAIT "cult"
#define LICH_TRAIT "lich"
/// The item is magically cursed
#define CURSED_ITEM_TRAIT(item_type) "cursed_item_[item_type]"
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define PSEUDOCIDER_TRAIT "pseudocider_trait"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"
#define STATION_TRAIT "station-trait"
#define ATTACHMENT_TRAIT "attachment-trait"
#define GLASSES_TRAIT "glasses"
/// A trait given by a specific status effect (not sure why we need both but whatever!)
#define TRAIT_STATUS_EFFECT(effect_id) "[effect_id]-trait"
/// trait associated to being held in a chokehold
#define CHOKEHOLD_TRAIT "chokehold"
#define CRYO_TRAIT "cryo_trait"
/// Trait applied by element
#define ELEMENT_TRAIT(source) "element_trait_[source]"
/// Trait from [/datum/element/rust]. Its rusty and should be applying a special overlay to denote this.
#define TRAIT_RUSTY "rust_trait"

// unique trait sources, still defines
#define CLONING_POD_TRAIT "cloning-pod"
#define STATUE_MUTE "statue"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define CULT_EYES "cult_eyes"
#define TRAIT_SANTA "santa"
#define SCRYING_ORB "scrying-orb"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define NUKEOP_TRAIT "nuke-op"
#define DEATHSQUAD_TRAIT "deathsquad"
#define MEGAFAUNA_TRAIT "megafauna"
#define CLOWN_NUKE_TRAIT "clown-nuke"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define REVERSE_BEAR_TRAP_TRAIT "reverse-bear-trap"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HIS_GRACE_TRAIT "his-grace"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define HOT_POTATO_TRAIT "hot-potato"
#define SABRE_SUICIDE_TRAIT "sabre-suicide"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define SHAMEBRERO_TRAIT "shamebrero"
#define CHRONOSUIT_TRAIT "chronosuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define NINJA_SUIT_TRAIT "ninja-suit"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define HIVEMIND_ONE_MIND_TRAIT "one_mind"
#define VR_ZONE_TRAIT "vr_zone_trait"
#define GUARDIAN_TRAIT "guardian_trait"
#define STARGAZER_TRAIT "stargazer"
#define RANDOM_BLACKOUTS "random_blackouts"
#define MADE_UNCLONEABLE "made-uncloneable"
#define PULLED_WHILE_SOFTCRIT_TRAIT "pulled-while-softcrit"
/// Source trait for Bloodsuckers-related traits
#define BLOODSUCKER_TRAIT "bloodsucker_trait"
/// Source trait for Monster Hunter-related traits
#define HUNTER_TRAIT "monsterhunter_trait"
/// Source trait during a Frenzy
#define FRENZY_TRAIT "frenzy_trait"
/// Source trait while Feeding
#define FEED_TRAIT "feed_trait"
#define HORROR_TRAIT "horror"
#define HOLDER_TRAIT "holder_trait"
#define SINFULDEMON_TRAIT "sinfuldemon"
#define CHANGESTING_TRAIT "changesting"
#define POSIBRAIN_TRAIT "positrait"
#define WRIST_STRAP_TRAIT "wrist_strap"
#define ECHOLOCATION_TRAIT "echolocation_trait"
#define GRIMOIRE_TRAIT "grimoire_trait"

///Traits given by station traits
#define STATION_TRAIT_BANANIUM_SHIPMENTS "station_trait_bananium_shipments"
#define STATION_TRAIT_CARP_INFESTATION "station_trait_carp_infestation"
#define STATION_TRAIT_PREMIUM_INTERNALS "station_trait_premium_internals"
#define STATION_TRAIT_RANDOM_ARRIVALS "station_trait_random_arrivals"
#define STATION_TRAIT_FILLED_MAINT "station_trait_filled_maint"
#define STATION_TRAIT_EMPTY_MAINT "station_trait_empty_maint"
#define STATION_TRAIT_PDA_GLITCHED "station_trait_pda_glitched"
#define STATION_TRAIT_MOONSCORCH "station_trait_moonscorch"

//important_recursive_contents traits
/*
 * Used for movables that need to be updated, via COMSIG_ENTER_AREA and COMSIG_EXIT_AREA, when transitioning areas.
 * Use [/atom/movable/proc/become_area_sensitive(trait_source)] to properly enable it. How you remove it isn't as important.
 */
#define TRAIT_AREA_SENSITIVE "area-sensitive"
///every hearing sensitive atom has this trait
#define TRAIT_HEARING_SENSITIVE "hearing_sensitive"
///every object that is currently the active storage of some client mob has this trait
#define TRAIT_ACTIVE_STORAGE "active_storage"

/// Climbable trait, given and taken by the climbable element when added or removed. Exists to be easily checked via HAS_TRAIT().
#define TRAIT_CLIMBABLE "trait_climbable"

///Organ traits
#define TRAIT_BALLMER_SCIENTIST "ballmer_scientist"

///storm immunity traits
#define TRAIT_LAVA_IMMUNE "lava_immune" //Used by lava turfs and The Floor Is Lava.
#define TRAIT_ASHSTORM_IMMUNE "ashstorm_immune"
#define TRAIT_SNOWSTORM_IMMUNE "snowstorm_immune"
#define TRAIT_RADSTORM_IMMUNE "radstorm_immune"
#define TRAIT_VOIDSTORM_IMMUNE "voidstorm_immune"
#define TRAIT_WEATHER_IMMUNE "weather_immune" //Immune to ALL weather effects.

///Movement type traits for movables. See elements/movetype_handler.dm
#define TRAIT_MOVE_GROUND "move_ground"
#define TRAIT_MOVE_FLYING "move_flying"
#define TRAIT_MOVE_VENTCRAWLING "move_ventcrawling"
#define TRAIT_MOVE_FLOATING "move_floating"
#define TRAIT_MOVE_PHASING "move_phasing"
/// Disables the floating animation. See above.
#define TRAIT_NO_FLOATING_ANIM "no-floating-animation"
/// Used to prevent multiple floating blades from triggering over the same target
#define TRAIT_BEING_BLADE_SHIELDED "being_blade_shielded"
/// things with this trait are treated as having no access in /obj/proc/check_access(obj/item)
#define TRAIT_ALWAYS_NO_ACCESS "alwaysnoaccess"
///Trait for dryable items
#define TRAIT_DRYABLE "trait_dryable"
///Trait for dried items
#define TRAIT_DRIED "trait_dried"

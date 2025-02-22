#define ELECTRICITY_TO_NUTRIMENT_FACTOR 0.22 //100 power unit to 22 preternis charge, they can suck an apc dry if hungry enough and the apc isn't upgraded

#define PRETERNIS_NV_OFF 2 //numbers of tile they can see
#define PRETERNIS_NV_ON 8

#define BODYPART_ANY -1 //use this when healing with something that needs a specefied bodypart type for all

#define REGEN_BLOOD_REQUIREMENT 40 // The amount of "blood" that a slimeperson consumes when regenerating a single limb.

#define DARKSPAWN_DIM_LIGHT 0.2 //light of this intensity suppresses healing and causes very slow burn damage
#define DARKSPAWN_BRIGHT_LIGHT 0.3 //light of this intensity causes rapid burn damage

 #define DARKSPAWN_DARK_HEAL 5 //how much damage of each type (with fire damage half rate) is healed in the dark
#define DARKSPAWN_LIGHT_BURN 7 //how much damage the darkspawn receives per tick in lit areas

#define MONKIFY_BLOOD_COEFFICIENT (BLOOD_VOLUME_MONKEY/BLOOD_VOLUME_GENERIC) //the ratio of monkey to human blood volume so a 100% blood volume monkey will not instantly die when you turn it into a human with ~58% blood volume

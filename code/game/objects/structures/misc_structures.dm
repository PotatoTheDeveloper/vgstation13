/obj/structure/headpole
	name = "pole"
	icon = 'icons/obj/structures.dmi'
	icon_state = "pole"
	desc = "How did this get here?"
	density = 0
	anchored = 1
	var/obj/item/weapon/spear/spear = null
	var/obj/item/weapon/organ/head/head = null
	var/obj/item/weapon/organ/head/display_head = null

/obj/structure/headpole/New(atom/A, var/obj/item/weapon/organ/head/H)
	..(A)
	if(istype(H))
		head = H
		name = "[H.name]"
		if(H.origin_body)
			desc = "The severed head of [H.origin_body.real_name], crudely shoved onto the tip of a spear."
		else
			desc = "A severed head, crudely shoved onto the tip of a spear."
		display_head = new (src)
		display_head.dir = SOUTH
		display_head.icon = H.icon
		display_head.icon_state = H.icon_state
		display_head.color = H.color
		display_head.overlays = H.overlays
		display_head.underlays = H.underlays
		overlays += display_head.appearance

/obj/structure/headpole/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W, /obj/item/weapon/crowbar))
		to_chat(user, "You pry \the [head] off \the [spear].")
		if(head)
			head.forceMove(get_turf(src))
			head = null
		if(spear)
			spear.forceMove(get_turf(src))
			spear = null
		else
			new /obj/item/weapon/spear(get_turf(src))
		qdel(src)

/obj/structure/headpole/Destroy()
	if(head)
		qdel(head)
		head = null
	if(spear)
		qdel(spear)
		spear = null
	if(display_head)
		qdel(display_head)
		display_head = null
	..()

/obj/structure/headpole/with_head/New(atom/A)
	var/obj/item/weapon/organ/head/H = new (src)
	H.name = "severed head"
	spear = new (src)
	..(A, H)
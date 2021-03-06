class('WeaponList');

require('WeaponClass');

function WeaponList:__init()
	self._weapons		= {};

	local weapon = nil
	-- shotguns
	weapon = Weapon('USAS-12', '', {'ExtendedMag', 'Frag'}, 20, 150, 15, 3, 0.4, 0.4, 'Shotgun', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('saiga20', '', {'Kobra', 'Silencer', 'Frag'}, 20, 150, 15, 3, 0.4, 0.4, 'Shotgun', false, 'Weapons/SAIGA20K/U_SAIGA_20K')
	table.insert(self._weapons, weapon);

	weapon = Weapon('Jackhammer', 'XP1', {'Kobra', 'TargetPointer', 'Frag'}, 20, 150, 15, 3, 3, 0.6, 'Shotgun', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('DAO-12', '', {'Kobra', 'TargetPointer', 'Frag'}, 20, 150, 15, 3, 3, 0.6, 'Shotgun', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('SPAS12', 'XP2', {'Kobra', 'Frag'}, 37.5, 150, 15, 2, 0.4, 0.4, 'Shotgun', false)
	table.insert(self._weapons, weapon);

	-- others
	--assault
	weapon = Weapon('M416', '', {'Kobra', 'HeavyBarrel'}, 25, 580, 15, 10, 0.4, 0.4, 'Assault', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('AEK971', '', {'Kobra', 'HeavyBarrel'}, 25, 580, 15, 10, 0.4, 0.4, 'Assault', false)
	table.insert(self._weapons, weapon);

	--engi
	weapon = Weapon('ASVal', '', {'Kobra', 'ExtendedMag'}, 18, 333, 9.81, 10, 0.4, 0.4, 'Carabine', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('M4A1', '', {'Kobra', 'Silencer'}, 25, 580, 15, 10, 0.4, 0.4, 'Carabine', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('SCAR-H', '', {'Kobra', 'Silencer'}, 30, 420, 15, 10, 0.4, 0.4, 'Carabine', false)
	table.insert(self._weapons, weapon);

	--support
	weapon = Weapon('M249', '', {'Eotech', 'Bipod'}, 25, 620, 15, 20, 2.0, 0.6, 'LMG', true)
	table.insert(self._weapons, weapon);

	weapon = Weapon('M240', '', {'Eotech', 'Bipod'}, 34, 610, 15, 20, 2.0, 0.6, 'LMG', true)
	table.insert(self._weapons, weapon);

	-- recon
	weapon = Weapon('L96', 'XP1', {'6xScope', 'StraightPull'}, 80, 540, 9.81, 3, 0.4, 0.4, 'Sniper', true)
	table.insert(self._weapons, weapon);

	weapon = Weapon('M98B', '', {'Ballistic_Scope', 'StraightPull'}, 95, 650, 9.81, 3, 0.4, 0.4, 'Sniper', true, 'Weapons/Model98B/U_M98B')
	table.insert(self._weapons, weapon);

	weapon = Weapon('SKS', '', {'Rifle_Scope', 'Target_Pointer'}, 43, 440, 15, 3, 0.4, 0.4, 'Sniper', true)
	table.insert(self._weapons, weapon);

	-- pistols
	weapon = Weapon('M1911_Lit', '', {}, 34, 300, 15, 4, 0.2, 0.2, 'Pistol', false, 'Weapons/M1911/U_M1911_Lit')
	table.insert(self._weapons, weapon);

	weapon = Weapon('M1911_Silenced', '', {}, 34, 300, 15, 4, 0.2, 0.2, 'Pistol', false, 'Weapons/M1911/U_M1911_Silenced')
	table.insert(self._weapons, weapon);

	weapon = Weapon('M1911_Tactical', '', {}, 34, 300, 15, 4, 0.2, 0.2, 'Pistol', false, 'Weapons/M1911/U_M1911_Tactical')
	table.insert(self._weapons, weapon);

	weapon = Weapon('MP412Rex', '', {}, 50, 300, 15, 2, 0.2, 0.2, 'Pistol', false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('Taurus44', '', {}, 60, 460, 15, 2, 0.2, 0.2, 'Pistol', false)
	table.insert(self._weapons, weapon);

	-- knifes
	weapon = Weapon('Razor', '', {}, 70, 0, 0, 0, 1, 0, 'Knife', false, 'Weapons/XP2_Knife_RazorBlade/U_Knife_Razor')
	table.insert(self._weapons, weapon);

	weapon = Weapon('Knife', '', {}, 50, 0, 0, 0, 1, 0, 'Knife', false)
	table.insert(self._weapons, weapon);
end

function WeaponList:getWeapon(name)
	local retWeapon = nil;
	for _, weapon in pairs(self._weapons) do
		if weapon.name == name then
			retWeapon = weapon;
			break;
		end
	end
	return retWeapon;
end


if (g_WeaponList == nil) then
	g_WeaponList = WeaponList();
end

return g_WeaponList;
class('WeaponList');

require('WeaponClass');

function WeaponList:__init()
	self._weapons		= {};

	local weapon = nil
	weapon = Weapon('USAS-12', '', {'ExtendedMag', 'Frag'}, 33, 150, 3, 0.4, 0.4, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('saiga20', '', {'Kobra', 'Silencer', 'Frag'}, 33, 150, 3, 0.4, 0.4, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('Jackhammer', 'XP1', {'Kobra', 'TargetPointer', 'Frag'}, 33, 150, 3, 3, 0.6, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('SPAS12', 'XP2', {'Kobra', 'Frag'}, 33, 150, 3, 0.4, 0.4, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('M416', '', {'Kobra', 'HeavyBarrel'}, 25, 600, 12, 0.4, 0.4, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('AEK971', '', {'Kobra', 'HeavyBarrel'}, 25, 600, 12, 0.4, 0.4, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('ASVal', '', {'Kobra', 'ExtendedMag'}, 18, 600, 10, 0.4, 0.4, false)
	table.insert(self._weapons, weapon);

	weapon = Weapon('M249', '', {'Eotech', 'Bipod'}, 25, 600, 20, 0.4, 0.4, true)
	table.insert(self._weapons, weapon);

	weapon = Weapon('L96', 'XP1', {'6xScope', 'StraightPull'}, 80, 600, 4, 0.4, 0.4, true)
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
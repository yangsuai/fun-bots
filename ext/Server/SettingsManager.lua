class('SettingsManager');

require('__shared/ArrayMap');
require('__shared/Config');
require('Database');

function SettingsManager:__init()
	-- Create Config-Trace
	Database:createTable('FB_Config_Trace', {
		DatabaseField.ID,
		DatabaseField.Text,
		DatabaseField.Text,
		DatabaseField.Time
	}, {
		'ID',
		'Key',
		'Value',
		'Time'
	});

	-- Create Settings
	Database:createTable('FB_Settings', {
		DatabaseField.ID,
		DatabaseField.Text,
		DatabaseField.Text,
		DatabaseField.Time
	}, {
		'ID',
		'Key',
		'Value',
		'Time'
	});
end

function SettingsManager:onLoad()
	-- Fix nil values on config
	if Config.language == nil then
		Config.language = DatabaseField.NULL;
	end
	
	if Config.settingsPassword == nil then
		Config.settingsPassword = DatabaseField.NULL;
	end
	
	-- get Values from Config.lua
	for name, value in pairs(Config) do		
		-- Check SQL if Config.lua has changed
		local single = Database:single('SELECT * FROM `FB_Config_Trace` WHERE `Key`=\'' .. name .. '\' LIMIT 1');
	
		-- If not exists, create
		if single == nil then
			print('SettingsManager: ADD (' .. name .. ' = ' .. tostring(value) .. ')');
			
			Database:insert('FB_Config_Trace', {
				ID		= DatabaseField.NULL,
				Key		= name,
				Value	= value,
				Time	= Database:now()
			});

		-- If exists update Settings, if newer
		else
			local old = single.Value;
			
			if old == nil then
				old = DatabaseField.NULL;
			end
			
			-- @ToDo check Time / Timestamp, if newer
			if tostring(value) == tostring(old) then
				print('SettingsManager: SKIP (' .. name .. ' = ' .. tostring(value) .. ', NOT MODIFIED)');
			else
				print('SettingsManager: UPDATE (' .. name .. ' = ' .. tostring(value) .. ', Old = ' .. tostring(old) .. ')');
				
				-- if changed, update SETTINGS SQL
				Database:update('FB_Config_Trace', {
					Key		= name,
					Value	= value,
					Time	= Database:now()
				}, 'Key');
			end
		end
	end
    
	print('Start migrating of Settings/Config...');
	
	-- Load Settings
	local settings = Database:fetch([[SELECT
											`Settings`.`Key`,
											CASE WHEN
												`Config`.`ID` IS NULL
											THEN
												`Settings`.`Value`
											ELSE
												`Config`.`Value`
											END `Value`,
											COALESCE(`Config`.`Time`, `Settings`.`Time`) `Time`
										FROM
											`FB_Settings` `Settings`
										LEFT JOIN
											`FB_Config_Trace` `Config`
										ON
											`Config`.`Key` = `Settings`.`Key`
										AND
											`Config`.`Time` > `Settings`.`Time`;]]);

	for name, value in pairs(settings) do
		print('Updating Config Variable: ' .. tostring(value.Key) .. ' = ' .. tostring(value.Value) .. ' (' .. tostring(value.Time) .. ')');
		Config[value.Key] = value.Value;
	end
	
	-- revert Fix nil values on config
	if Config.language == DatabaseField.NULL then
		Config.language = nil;
	end
	
	if Config.settingsPassword == DatabaseField.NULL then
		Config.settingsPassword = nil;
	end
end

function SettingsManager:update(name, value, temporary)
	if temporary ~= true then
		if value == nil then
			value = DatabaseField.NULL;
		end
		
		local single = Database:single('SELECT * FROM `FB_Settings` WHERE `Key`=\'' .. name .. '\' LIMIT 1');
	
		-- If not exists, create
		if single == nil then
			Database:insert('FB_Settings', {
				ID		= DatabaseField.NULL,
				Key		= name,
				Value	= value,
				Time	= Database:now()
			});
		else
			Database:update('FB_Settings', {
				Key		= name,
				Value	= value,
				Time	= Database:now()
			}, 'Key');
		end
		if value == DatabaseField.NULL then
			value = nil;
		end
	end
		
	Config[name] = value;
end

-- Singleton.
if g_Settings == nil then
	g_Settings = SettingsManager();
end

return g_Settings;
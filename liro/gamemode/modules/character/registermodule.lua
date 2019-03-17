-- Define module information
-- All module data must be set correctly, skipping keys will result in a error
-- Module data is in JSON format

-- Please also note; for linux users module(s) and/or uppercase file name paths will cause issues, same with spaces/tabs.

-- Must be set (case sensitive)
-- If 'folderName' is not set, Liro will completely fail to load!
local folderName = "character"
local moduleData = '{"folderName": "' .. folderName .. '", "loadPriority": 5,"author": "VeXan","description": "Handles character functions.","website": "na","version": "1.0", "blacklistedFiles": [], "networkStrings": [], "loadPrefixes": {"server": "sv_", "client": "cl_", "shared": "sh_"}}'

-- Register the module - Do not touch
hook.Run("liro.registerModule", moduleData)

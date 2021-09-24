#include <sourcemod>
#include <basecomm>

#pragma semicolon 1
#pragma newdecls required

#define LoopClientsCustom(%1) for (int %1 = 1; %1 <= MaxClients; %1++) if (IsClientInGame(%1) && GagGor[%1])

public Plugin myinfo = 
{
	name = "Gaglı Oyuncuları Görme", 
	author = "ByDexter", 
	description = "", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

bool GagGor[65] = { false, ... };

public void OnPluginStart()
{
	RegConsoleCmd("sm_gaggor", Command_Gaggor, "");
}

public Action Command_Gaggor(int client, int args)
{
	if (CheckCommandAccess(client, "sm_gag", ADMFLAG_ROOT))
	{
		GagGor[client] = !GagGor[client];
		ReplyToCommand(client, "[SM] %s", GagGor[client] ? "Artık cezalıların yazdığını \x04görebiliyorsun":"Artık cezalıların yazdığını \x07göremiyorsun");
		return Plugin_Handled;
	}
	else
	{
		ReplyToCommand(client, "[SM] Bu komuta erişiminiz yok.");
		return Plugin_Handled;
	}
}

public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs)
{
	if (BaseComm_IsClientGagged(client))
	{
		LoopClientsCustom(i)
		{
			PrintToChat(i, "\x07[CEZALI] \x10%N\x01: %s", client, sArgs);
		}
	}
} 
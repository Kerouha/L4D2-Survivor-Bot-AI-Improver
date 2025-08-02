#pragma semicolon 1
#pragma newdecls required

enum
{
	CMD_NONE	= 0,
	CMD_LOOK	= 1,
	CMD_CANCEL	= 2,
	CMD_DUCK	= 3,
	CMD_USE		= 4,
	CMD_HEAL	= 5,
	CMD_TOTAL	= 6
}

//static bool g_bInitVocCmds = false;
static StringMap g_hVocCmds;

void InitVocCmds(bool &bInit)
{
	g_hVocCmds = CreateTrie();
	g_hVocCmds.SetValue("smartlook"				, CMD_LOOK );
	g_hVocCmds.SetValue("playerno"				, CMD_CANCEL );
	g_hVocCmds.SetValue("playerduck"			, CMD_DUCK );
	g_hVocCmds.SetValue("playeralertgiveitem"	, CMD_USE );
	g_hVocCmds.SetValue("askforhealth2"			, CMD_HEAL );
	bInit = true;
}

public Action OnVocalize(int client, const char[] command, int args)
{
	static char sVocalize[128], sArg[16];
	static int iCommand;
	
	if (client == 0 || args == 0)
		return Plugin_Continue;
	
	sArg[0] = EOS;
	GetCmdArg(1, sVocalize, sizeof(sVocalize));
	for (int i = 0; i < sizeof(sVocalize); i++)
		sVocalize[i] = CharToLower(sVocalize[i]);
	if (args > 1) GetCmdArg(2, sArg, sizeof(sArg));
	//PrintToChat(client, "%s %s %s", command, sVocalize, sArg);
	
	if (!strcmp(sArg, "auto") || !g_hVocCmds.GetValue(sVocalize, iCommand))
		return Plugin_Continue;
	
	switch (iCommand)
	{
		//case CMD_LOOK: CmdLook(client);
		case CMD_CANCEL: CmdCancel(client);
		case CMD_DUCK: CmdDuck(client);
		case CMD_HEAL: CmdHeal(client);
	}
	
	return Plugin_Continue;
}
/*
void CmdLook(int iClient)
{
	static int iTarget;
	//PrintToChat(iClient, "CmdLook");
	iTarget = GetClientAimTarget(iClient);
	if (iTarget > 0)
		PrintToChat(iClient, "CmdLook: #%d %N", iTarget, iTarget);
}
*/
void CmdCancel(int iClient)
{
	//static char sReason[128], sClientName[64];
	static int iTarget;
	
	if (!g_bExtensionActions) return;
	
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && GetClientTeam(i) == 2 && IsFakeClient(i) && IsPlayerAlive(i))
		{
			BehaviorAction hHealAct = ActionsManager.LookupEntityActionById(i, g_ActionID[SURV_HEAL_FRIEND]);
			// BehaviorAction hHealAct = ActionsManager.GetAction(i, "SurvivorHealFriend");
			if (hHealAct != INVALID_ACTION)
			{
				iTarget = (hHealAct.Get(0x34) & 0xFFF);
				if (IsValidClient(iTarget) && iClient == iTarget)
				{
					g_iClientState[iClient] |= STATE_NOHEAL;
					hHealAct.OnUpdatePost = OnHealAction;
				}
			}
		}
	}
}

void CmdHeal(int iClient)
{
	g_iClientState[iClient] &= ~STATE_NOHEAL;
}

void CmdDuck(int iClient)
{
	static int iTarget;
	
	iTarget = GetClientAimTarget(iClient);
	if (iTarget > 0)
		g_iClientState[iClient] |= STATE_DUCKING;
}
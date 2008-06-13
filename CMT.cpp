// CMT.cpp : Defines the entry point for the console application.
//
#include "stdafx.h"
#include "SDL.h"
#include "SDL_TTF.h"
#include "hch\CVideoHandler.h"
#include "SDL_mixer.h"
#include "hch\CBuildingHandler.h"
#include "SDL_Extensions.h"
#include "SDL_framerate.h"
#include <cmath>
#include <stdio.h>
#include <string.h>
#include <string>
#include <assert.h>
#include <vector>
#include "zlib.h"
#include <cmath>
#include <ctime>
#include "hch\CArtHandler.h"
#include "hch\CHeroHandler.h"
#include "hch\CCreatureHandler.h"
#include "hch\CAbilityHandler.h"
#include "hch\CSpellHandler.h"
#include "hch\CBuildingHandler.h"
#include "hch\CObjectHandler.h"
#include "CGameInfo.h"
#include "hch\CMusicHandler.h"
#include "hch\CLodHandler.h"
#include "hch\CDefHandler.h"
#include "hch\CSndHandler.h"
#include "hch\CTownHandler.h"
#include "hch\CDefObjInfoHandler.h"
#include "hch\CAmbarCendamo.h"
#include "mapHandler.h"
#include "global.h"
#include "CPreGame.h"
#include "hch\CGeneralTextHandler.h"
#include "CConsoleHandler.h"
#include "CCursorHandler.h"
#include "CScreenHandler.h"
#include "CPathfinder.h"
#include "CGameState.h"
#include "CCallback.h"
#include "CPlayerInterface.h"
#include "CLuaHandler.h"
#include "CLua.h"
#include "CAdvmapInterface.h"
#include "CCastleInterface.h"
#include "boost/filesystem/operations.hpp"
#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/replace.hpp>
#include "client\Graphics.h"
#if defined(MSDOS) || defined(OS2) || defined(WIN32) || defined(__CYGWIN__)
#  include <fcntl.h>
#  include <io.h>
#  define SET_BINARY_MODE(file) setmode(fileno(file), O_BINARY)
#else
#  define SET_BINARY_MODE(file)
#endif
#ifdef _DEBUG
#endif
#define CHUNK 16384
const char * NAME = "VCMI \"Altanatse\" 0.7";
DLL_EXPORT void initDLL(CLodHandler *b);
SDL_Color playerColorPalette[256]; //palette to make interface colors good

SDL_Surface * screen, * screen2;
extern SDL_Surface * CSDL_Ext::std32bppSurface;
TTF_Font * TNRB16, *TNR, *GEOR13, *GEORXX, *GEORM, *GEOR16;
void handleCPPObjS(std::map<int,CCPPObjectScript*> * mapa, CCPPObjectScript * script)
{
	std::vector<int> tempv = script->yourObjects();
	for (int i=0;i<tempv.size();i++)
	{
		(*mapa)[tempv[i]]=script;
	}
	CGI->state->cppscripts.insert(script);
}
void initGameState(Mapa * map, CGameInfo * cgi)
{
	cgi->state->day=0;
	/*********creating players entries in gs****************************************/
	for (int i=0; i<cgi->scenarioOps.playerInfos.size();i++)
	{
		std::pair<int,PlayerState> ins(cgi->scenarioOps.playerInfos[i].color,PlayerState());
		ins.second.color=ins.first;
		ins.second.serial=i;
		cgi->state->players.insert(ins);
	}
	/******************RESOURCES****************************************************/
	//TODO: zeby komputer dostawal inaczej niz gracz 
	std::vector<int> startres;
	std::ifstream tis("config/startres.txt");
	int k;
	for (int j=0;j<cgi->scenarioOps.difficulty;j++)
	{
		tis >> k;
		for (int z=0;z<RESOURCE_QUANTITY;z++)
			tis>>k;
	}
	tis >> k;
	for (int i=0;i<RESOURCE_QUANTITY;i++)
	{
		tis >> k;
		startres.push_back(k);
	}
	tis.close();
	for (std::map<int,PlayerState>::iterator i = cgi->state->players.begin(); i!=cgi->state->players.end(); i++)
	{
		(*i).second.resources.resize(RESOURCE_QUANTITY);
		for (int x=0;x<RESOURCE_QUANTITY;x++)
			(*i).second.resources[x] = startres[x];

	}

	/*************************HEROES************************************************/
	for (int i=0; i<map->heroes.size();i++) //heroes instances
	{
		if (map->heroes[i]->getOwner()<0)
			continue;
		CGHeroInstance * vhi = (map->heroes[i]);
		if(!vhi->type)
			vhi->type = cgi->heroh->heroes[vhi->subID];
		//vhi->subID = vhi->type->ID;
		if (vhi->level<1)
		{
			vhi->exp=40+rand()%50;
			vhi->level = 1;
		}
		if (vhi->level>1) ;//TODO dodac um dr, ale potrzebne los
		if ((!vhi->primSkills.size()) || (vhi->primSkills[0]<0))
		{
			if (vhi->primSkills.size()<PRIMARY_SKILLS)
				vhi->primSkills.resize(PRIMARY_SKILLS);
			vhi->primSkills[0] = vhi->type->heroClass->initialAttack;
			vhi->primSkills[1] = vhi->type->heroClass->initialDefence;
			vhi->primSkills[2] = vhi->type->heroClass->initialPower;
			vhi->primSkills[3] = vhi->type->heroClass->initialKnowledge;
		}
		vhi->mana = vhi->primSkills[3]*10;
		if (!vhi->name.length())
		{
			vhi->name = vhi->type->name;
		}
		if (!vhi->biography.length())
		{
			vhi->biography = vhi->type->biography;
		}
		if (vhi->portrait < 0)
			vhi->portrait = vhi->type->ID;

		//initial army
		if (!vhi->army.slots.size()) //standard army
		{
			int pom, pom2=0;
			for(int x=0;x<3;x++)
			{
				pom = (cgi->creh->nameToID[vhi->type->refTypeStack[x]]);
				if(pom>=145 && pom<=149) //war machine
				{
					pom2++;
					switch (pom)
					{
					case 145: //catapult
						vhi->artifWorn[16] = 3;
						break;
					default:
						pom-=145;
						vhi->artifWorn[13+pom] = 4+pom;
						break;
					}
					continue;
				}
				vhi->army.slots[x-pom2].first = &(cgi->creh->creatures[pom]);
				if((pom = (vhi->type->highStack[x]-vhi->type->lowStack[x])) > 0)
					vhi->army.slots[x-pom2].second = (rand()%pom)+vhi->type->lowStack[x];
				else 
					vhi->army.slots[x-pom2].second = +vhi->type->lowStack[x];
			}
		}

		cgi->state->players[vhi->getOwner()].heroes.push_back(vhi);

	}
	/*************************FOG**OF**WAR******************************************/		
	for(std::map<int, PlayerState>::iterator k=cgi->state->players.begin(); k!=cgi->state->players.end(); ++k)
	{
		k->second.fogOfWarMap.resize(map->width, Woff);
		for(int g=-Woff; g<map->width+Woff; ++g)
			k->second.fogOfWarMap[g].resize(map->height, Hoff);

		for(int g=-Woff; g<map->width+Woff; ++g)
			for(int h=-Hoff; h<map->height+Hoff; ++h)
				k->second.fogOfWarMap[g][h].resize(map->twoLevel+1, 0);

		for(int g=-Woff; g<map->width+Woff; ++g)
			for(int h=-Hoff; h<map->height+Hoff; ++h)
				for(int v=0; v<map->twoLevel+1; ++v)
					k->second.fogOfWarMap[g][h][v] = 0;
		for(int xd=0; xd<map->width; ++xd) //revealing part of map around heroes
		{
			for(int yd=0; yd<map->height; ++yd)
			{
				for(int ch=0; ch<k->second.heroes.size(); ++ch)
				{
					int deltaX = (k->second.heroes[ch]->getPosition(false).x-xd)*(k->second.heroes[ch]->getPosition(false).x-xd);
					int deltaY = (k->second.heroes[ch]->getPosition(false).y-yd)*(k->second.heroes[ch]->getPosition(false).y-yd);
					if(deltaX+deltaY<k->second.heroes[ch]->getSightDistance()*k->second.heroes[ch]->getSightDistance())
						k->second.fogOfWarMap[xd][yd][k->second.heroes[ch]->getPosition(false).z] = 1;
				}
			}
		}
	}
	/****************************TOWNS************************************************/
	for (int i=0;i<map->towns.size();i++)
	{
		CGTownInstance * vti =(map->towns[i]);
		if (vti->name.length()==0) // if town hasn't name we draw it
			vti->name=vti->town->names[rand()%vti->town->names.size()];
		if(vti->builtBuildings.find(-50)!=vti->builtBuildings.end()) //give standard set of buildings
		{
			vti->builtBuildings.erase(-50);
			vti->builtBuildings.insert(10);
			vti->builtBuildings.insert(5);
			vti->builtBuildings.insert(30);
			if(rand()%2)
				vti->builtBuildings.insert(31);
		}
		cgi->state->players[vti->getOwner()].towns.push_back(vti);
	}

	for(std::map<int, PlayerState>::iterator k=cgi->state->players.begin(); k!=cgi->state->players.end(); ++k)
	{
		if(k->first==-1 || k->first==255)
			continue;
		for(int xd=0; xd<map->width; ++xd) //revealing part of map around towns
		{
			for(int yd=0; yd<map->height; ++yd)
			{
				for(int ch=0; ch<k->second.towns.size(); ++ch)
				{
					int deltaX = (k->second.towns[ch]->pos.x-xd)*(k->second.towns[ch]->pos.x-xd);
					int deltaY = (k->second.towns[ch]->pos.y-yd)*(k->second.towns[ch]->pos.y-yd);
					if(deltaX+deltaY<k->second.towns[ch]->getSightDistance()*k->second.towns[ch]->getSightDistance())
						k->second.fogOfWarMap[xd][yd][k->second.towns[ch]->pos.z] = 1;
				}
			}
		}

		//init visiting heroes
		for(int l=0; l<k->second.heroes.size();l++)
		{ 
			for(int m=0; m<k->second.towns.size();m++)
			{
				int3 vistile = k->second.towns[m]->pos; vistile.x--; //tile next to the entrance
				if(vistile == k->second.heroes[l]->pos)
				{
					k->second.towns[m]->visitingHero = k->second.heroes[l];
					break;
				}
			}
		}
	}

	/****************************SCRIPTS************************************************/
	std::map<int, std::map<std::string, CObjectScript*> > * skrypty = &cgi->state->objscr; //alias for easier access
	/****************************C++ OBJECT SCRIPTS************************************************/
	std::map<int,CCPPObjectScript*> scripts;
	CScriptCallback * csc = new CScriptCallback();
	csc->gs = cgi->state;
	handleCPPObjS(&scripts,new CVisitableOPH(csc));
	handleCPPObjS(&scripts,new CVisitableOPW(csc));
	handleCPPObjS(&scripts,new CPickable(csc));
	handleCPPObjS(&scripts,new CMines(csc));
	handleCPPObjS(&scripts,new CTownScript(csc));
	handleCPPObjS(&scripts,new CHeroScript(csc));
	handleCPPObjS(&scripts,new CMonsterS(csc));
	handleCPPObjS(&scripts,new CCreatureGen(csc));
	//created map

	/****************************LUA OBJECT SCRIPTS************************************************/
	std::vector<std::string> * lf = CLuaHandler::searchForScripts("scripts/lua/objects"); //files
	for (int i=0; i<lf->size(); i++)
	{
		try
		{
			std::vector<std::string> * temp =  CLuaHandler::functionList((*lf)[i]);
			CLuaObjectScript * objs = new CLuaObjectScript((*lf)[i]);
			CLuaCallback::registerFuncs(objs->is);
			//objs
			for (int j=0; j<temp->size(); j++)
			{
				int obid ; //obj ID
				int dspos = (*temp)[j].find_first_of('_');
				obid = atoi((*temp)[j].substr(dspos+1,(*temp)[j].size()-dspos-1).c_str());
				std::string fname = (*temp)[j].substr(0,dspos);
				if (skrypty->find(obid)==skrypty->end())
					skrypty->insert(std::pair<int, std::map<std::string, CObjectScript*> >(obid,std::map<std::string,CObjectScript*>()));
				(*skrypty)[obid].insert(std::pair<std::string, CObjectScript*>(fname,objs));
			}
			delete temp;
		}HANDLE_EXCEPTION
	}
	/****************************INITIALIZING OBJECT SCRIPTS************************************************/
	std::string temps("newObject");
	for (int i=0; i<map->objects.size(); i++)
	{
		//c++ scripts
		if (scripts.find(map->objects[i]->ID) != scripts.end())
		{
			map->objects[i]->state = scripts[map->objects[i]->ID];
			map->objects[i]->state->newObject(map->objects[i]);
		}
		else 
		{
			map->objects[i]->state = NULL;
		}

		// lua scripts
		if(cgi->state->checkFunc(map->objects[i]->ID,temps))
			(*skrypty)[map->objects[i]->ID][temps]->newObject(map->objects[i]);
	}

	delete lf;
}

int _tmain(int argc, _TCHAR* argv[])
{ 
	//std::ios_base::sync_with_stdio(0);
	//CLuaHandler luatest;
	//luatest.test(); 
	
		//CBIKHandler cb;
		//cb.open("CSECRET.BIK");
	THC timeHandler tmh;
	THC tmh.getDif();
	timeHandler pomtime;pomtime.getDif();
	int xx=0, yy=0, zz=0;
	srand ( time(NULL) );
	std::vector<SDL_Surface*> Sprites;
	if(SDL_Init(SDL_INIT_VIDEO|SDL_INIT_TIMER|SDL_INIT_AUDIO/*|SDL_INIT_EVENTTHREAD*/)==0)
	{
		screen = SDL_SetVideoMode(800,600,24,SDL_SWSURFACE|SDL_DOUBLEBUF/*|SDL_FULLSCREEN*/);
		
		//initializing important global surface
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
		int rmask = 0xff000000;
		int gmask = 0x00ff0000;
		int bmask = 0x0000ff00;
		int amask = 0x000000ff;
#else
		int rmask = 0x000000ff;
		int gmask = 0x0000ff00;
		int bmask = 0x00ff0000;
		int amask = 0xff000000;
#endif
		CSDL_Ext::std32bppSurface = SDL_CreateRGBSurface(SDL_SWSURFACE, 1, 1, 32, rmask, gmask, bmask, amask);

		CPG=NULL;
		TTF_Init();
		atexit(TTF_Quit);
		atexit(SDL_Quit);
		//TNRB = TTF_OpenFont("Fonts\\tnrb.ttf",16);
		TNRB16 = TTF_OpenFont("Fonts\\tnrb.ttf",16);
		//TNR = TTF_OpenFont("Fonts\\tnr.ttf",10);
		GEOR13 = TTF_OpenFont("Fonts\\georgia.ttf",13);
		GEOR16 = TTF_OpenFont("Fonts\\georgia.ttf",16);
		GEORXX = TTF_OpenFont("Fonts\\tnrb.ttf",22);
		GEORM = TTF_OpenFont("Fonts\\georgia.ttf",10);
		CMusicHandler * mush = new CMusicHandler;  //initializing audio
		mush->initMusics();
		//audio initialized 


		//screen2 = SDL_SetVideoMode(800,600,24,SDL_SWSURFACE|SDL_DOUBLEBUF/*|SDL_FULLSCREEN*/);
		//screen = SDL_ConvertSurface(screen2, screen2->format, SDL_SWSURFACE);

		SDL_WM_SetCaption(NAME,""); //set window title
		CGameInfo * cgi = CGI = new CGameInfo; //contains all global informations about game (texts, lodHandlers, map handler itp.)
		cgi->consoleh = new CConsoleHandler;
		cgi->mush = mush;
		cgi->curh = new CCursorHandler; 
		
		THC std::cout<<"Initializing screen, fonts and sound handling: "<<tmh.getDif()<<std::endl;
		CDefHandler::Spriteh = cgi->spriteh = new CLodHandler;
		cgi->spriteh->init(std::string("Data\\H3sprite.lod"));
		BitmapHandler::bitmaph = cgi->bitmaph = new CLodHandler;
		cgi->bitmaph->init(std::string("Data\\H3bitmap.lod"));
		THC std::cout<<"Loading .lod files: "<<tmh.getDif()<<std::endl;
		initDLL(cgi->bitmaph);
		THC std::cout<<"Initializing VCMI_Lib: "<<tmh.getDif()<<std::endl;
		graphics = new Graphics();
		THC std::cout<<"Initializing game graphics: "<<tmh.getDif()<<std::endl;

		boost::filesystem::directory_iterator enddir;
		for (boost::filesystem::directory_iterator dir("Data");dir!=enddir;dir++)
		{
			if(boost::filesystem::is_regular(dir->status()))
			{
				std::string name = dir->path().leaf();
				std::transform(name.begin(), name.end(), name.begin(), (int(*)(int))toupper);
				boost::algorithm::replace_all(name,".BMP",".PCX");
				Entry * e = cgi->bitmaph->entries.znajdz(name);
				if(e)
				{
					e->offset = -1;
					e->realSize = e->size = boost::filesystem::file_size(dir->path());
				}
			}
		}
		if(boost::filesystem::exists("Sprites"))
		{
			for (boost::filesystem::directory_iterator dir("Sprites");dir!=enddir;dir++)
			{
				if(boost::filesystem::is_regular(dir->status()))
				{
					std::string name = dir->path().leaf();
					std::transform(name.begin(), name.end(), name.begin(), (int(*)(int))toupper);
					boost::algorithm::replace_all(name,".BMP",".PCX");
					Entry * e = cgi->spriteh->entries.znajdz(name);
					if(e)
					{
						e->offset = -1;
						e->realSize = e->size = boost::filesystem::file_size(dir->path());
					}
				}
			}
		}
		else
			std::cout<<"Warning: No sprites/ folder!"<<std::endl;
		THC std::cout<<"Scanning Data/ and Sprites/ folders: "<<tmh.getDif()<<std::endl;
		cgi->curh->initCursor();
		cgi->curh->showGraphicCursor();

		cgi->screenh = new CScreenHandler;
		cgi->screenh->initScreen();

		THC std::cout<<"Preparing first handlers: "<<tmh.getDif()<<std::endl;

		//colors initialization
		SDL_Color p;
		p.unused = 0;
		p.r = 0xff; p.g = 0x0; p.b = 0x0; //red
		cgi->playerColors.push_back(p); //red
		p.r = 0x31; p.g = 0x52; p.b = 0xff; //blue
		cgi->playerColors.push_back(p); //blue
		p.r = 0x9c; p.g = 0x73; p.b = 0x52;//tan
		cgi->playerColors.push_back(p);//tan
		p.r = 0x42; p.g = 0x94; p.b = 0x29; //green
		cgi->playerColors.push_back(p); //green
		p.r = 0xff; p.g = 0x84; p.b = 0x0; //orange
		cgi->playerColors.push_back(p); //orange
		p.r = 0x8c; p.g = 0x29; p.b = 0xa5; //purple
		cgi->playerColors.push_back(p); //purple
		p.r = 0x09; p.g = 0x9c; p.b = 0xa5;//teal
		cgi->playerColors.push_back(p);//teal
		p.r = 0xc6; p.g = 0x7b; p.b = 0x8c;//pink
		cgi->playerColors.push_back(p);//pink
		p.r = 0x84; p.g = 0x84; p.b = 0x84;//gray
		cgi->neutralColor = p;//gray
		//colors initialized
		//palette initialization
		std::string pals = cgi->bitmaph->getTextFile("PLAYERS.PAL");
		int startPoint = 24; //beginning byte; used to read
		for(int i=0; i<256; ++i)
		{
			SDL_Color col;
			col.r = pals[startPoint++];
			col.g = pals[startPoint++];
			col.b = pals[startPoint++];
			col.unused = pals[startPoint++];
			playerColorPalette[i] = col;
		}
		//palette initialized
		THC std::cout<<"Preparing players' colours: "<<tmh.getDif()<<std::endl;
		CMessage::init();
		cgi->townh = new CTownHandler;
		cgi->townh->loadNames();
		CAbilityHandler * abilh = new CAbilityHandler;
		abilh->loadAbilities();
		cgi->abilh = abilh;
		CHeroHandler * heroh = new CHeroHandler;
		heroh->loadHeroes();
		heroh->loadPortraits();
		cgi->heroh = heroh;
		cgi->generaltexth = new CGeneralTextHandler;
		cgi->generaltexth->load();
		THC std::cout<<"Preparing more handlers: "<<tmh.getDif()<<std::endl;
		CPreGame * cpg = new CPreGame(); //main menu and submenus
		THC std::cout<<"Initialization CPreGame (together): "<<tmh.getDif()<<std::endl;
		cpg->mush = mush;
		cgi->scenarioOps = cpg->runLoop();
		THC tmh.getDif();

		CArtHandler * arth = new CArtHandler;
		arth->loadArtifacts();
		cgi->arth = arth;
		THC std::cout<<"\tArtifact handler: "<<pomtime.getDif()<<std::endl;

		CCreatureHandler * creh = new CCreatureHandler();
		creh->loadCreatures();
		cgi->creh = creh;
		THC std::cout<<"\tCreature handler: "<<pomtime.getDif()<<std::endl;

		CSpellHandler * spellh = new CSpellHandler;
		spellh->loadSpells();
		cgi->spellh = spellh;		
		THC std::cout<<"\tSpell handler: "<<pomtime.getDif()<<std::endl;

		CBuildingHandler * buildh = new CBuildingHandler;
		buildh->loadBuildings();
		cgi->buildh = buildh;
		THC std::cout<<"\tBuilding handler: "<<pomtime.getDif()<<std::endl;

		CObjectHandler * objh = new CObjectHandler;
		objh->loadObjects();
		cgi->objh = objh;
		THC std::cout<<"\tObject handler: "<<pomtime.getDif()<<std::endl;

		cgi->dobjinfo = new CDefObjInfoHandler;
		cgi->dobjinfo->load();
		THC std::cout<<"\tDef information handler: "<<pomtime.getDif()<<std::endl;

		cgi->state = new CGameState();
		cgi->state->players = std::map<int, PlayerState>();
		THC std::cout<<"\tGamestate: "<<pomtime.getDif()<<std::endl;

		cgi->pathf = new CPathfinder();
		THC std::cout<<"\tPathfinder: "<<pomtime.getDif()<<std::endl;
		cgi->consoleh->cb = new CCallback(cgi->state,-1);
		cgi->consoleh->runConsole();
		THC std::cout<<"\tCallback and console: "<<pomtime.getDif()<<std::endl;
		THC std::cout<<"Handlers initailization (together): "<<tmh.getDif()<<std::endl;

		std::string mapname = cpg->ourScenSel->mapsel.ourMaps[cpg->ourScenSel->mapsel.selected].filename;
		std::cout<<"Opening map file: "<<mapname<<"\t\t"<<std::flush;
		gzFile map = gzopen(mapname.c_str(),"rb");
		std::vector<unsigned char> mapstr; int pom;
		while((pom=gzgetc(map))>=0)
		{
			mapstr.push_back(pom);
		}
		gzclose(map);
		unsigned char *initTable = new unsigned char[mapstr.size()];
		for(int ss=0; ss<mapstr.size(); ++ss)
		{
			initTable[ss] = mapstr[ss];
		}
		std::cout<<"done."<<std::endl;

		CAmbarCendamo * ac = new CAmbarCendamo(initTable);
		THC std::cout<<"Reading file: "<<tmh.getDif()<<std::endl;
		ac->deh3m();
		THC std::cout<<"Detecting file (together): "<<tmh.getDif()<<std::endl;
		CMapHandler * mh = new CMapHandler();
		cgi->mh = mh;
		mh->map = &ac->map;
		THC std::cout<<"Creating mapHandler: "<<tmh.getDif()<<std::endl;
		mh->loadDefs();
		THC std::cout<<"Reading terrain defs: "<<tmh.getDif()<<std::endl;
		mh->init();
		THC std::cout<<"Initializing mapHandler (together): "<<tmh.getDif()<<std::endl;

		initGameState(&ac->map,cgi);
		THC std::cout<<"Initializing GameState (together): "<<tmh.getDif()<<std::endl;
		for (int i=0; i<cgi->scenarioOps.playerInfos.size();i++) //initializing interfaces
		{ 

			if(!cgi->scenarioOps.playerInfos[i].human)
				cgi->playerint.push_back(static_cast<CGameInterface*>(CAIHandler::getNewAI(new CCallback(cgi->state,cgi->scenarioOps.playerInfos[i].color),"EmptyAI.dll")));
			else 
			{
				cgi->state->currentPlayer=cgi->scenarioOps.playerInfos[i].color;
				cgi->playerint.push_back(new CPlayerInterface(cgi->scenarioOps.playerInfos[i].color,i));
				((CPlayerInterface*)(cgi->playerint[i]))->init(new CCallback(cgi->state,cgi->scenarioOps.playerInfos[i].color));
			}
		}
		///claculating FoWs for minimap
		/****************************Minimaps' FoW******************************************/
		for(int g=0; g<cgi->playerint.size(); ++g)
		{
			if(!cgi->playerint[g]->human)
				continue;
			CMinimap & mm = ((CPlayerInterface*)cgi->playerint[g])->adventureInt->minimap;

			int mw = mm.map[0]->w, mh = mm.map[0]->h,
				wo = mw/CGI->mh->sizes.x, ho = mh/CGI->mh->sizes.y;

			for(int d=0; d<cgi->mh->map->twoLevel+1; ++d)
			{
				SDL_Surface * pt = CSDL_Ext::newSurface(mm.pos.w, mm.pos.h, CSDL_Ext::std32bppSurface);

				for (int i=0; i<mw; i++)
				{
					for (int j=0; j<mh; j++)
					{
						int3 pp( ((i*CGI->mh->sizes.x)/mw), ((j*CGI->mh->sizes.y)/mh), d );

						if ( !((CPlayerInterface*)cgi->playerint[g])->cb->isVisible(pp) )
						{
							CSDL_Ext::SDL_PutPixelWithoutRefresh(pt,i,j,0,0,0);
						}
					}
				}
				CSDL_Ext::update(pt);
				mm.FoW.push_back(pt);
			}

		}

		while(1) //main game loop, one execution per turn
		{
			cgi->consoleh->cb->newTurn();
			for (int i=0;i<cgi->playerint.size();i++)
			{
				cgi->state->currentPlayer=cgi->playerint[i]->playerID;
				try
				{
					cgi->playerint[i]->yourTurn();
				}HANDLE_EXCEPTION
			}
		}
	}
	else
	{
		printf("Something was wrong: %s/n", SDL_GetError());
		return -1;
	}
}

#ifndef _sdlbmpfastfont_h_
#define _sdlbmpfastfont_h_
/*

text put structures for SDL


*/

#include "SDL.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define N_ASCII 128

typedef struct{
	
	SDL_Surface *font;
	SDL_Rect fontarea[N_ASCII];
	int width;
	int height;
	int isTransparent;
	
}Cffont;


void CffontFree(Cffont *);
Cffont* CffontInit(char *,int ,int ,int ,int ,int );
Cffont* CffontInitDefault16(char *);
Cffont* CffontInitDefault32(char *);
void CffontSetup(Cffont *);
int CffontBlit(Cffont *,char *,SDL_Surface *);
int CffontBlitxy(Cffont *,char *,SDL_Surface *,int ,int );
void CffontSetupFromFireworks(Cffont*,int);


#define MAXTEXTLINE 25

typedef struct{
	
	SDL_Surface *screen;//pointer to master screen
	SDL_Surface *lines[MAXTEXTLINE+1];
	Cffont *font;
	//cursor
	int x;
	int y;
	
}CSDLCons;



#endif _sdlbmpfastfont_h

#include "stdafx.h"
#include <iostream>
#include <stdlib.h>
#include <windows.h>
using namespace std;
int wherex()
{
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	if (!GetConsoleScreenBufferInfo(
		GetStdHandle(STD_OUTPUT_HANDLE),
		&csbi
	))
		return -1;
	return csbi.dwCursorPosition.X;
}

int wherey()
{
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	if (!GetConsoleScreenBufferInfo(
		GetStdHandle(STD_OUTPUT_HANDLE),
		&csbi
	))
		return -1;
	return csbi.dwCursorPosition.Y;
}

int main()
{
	LPPOINT point = new tagPOINT;
	
	HANDLE hout = GetStdHandle(STD_OUTPUT_HANDLE);
	PCONSOLE_CURSOR_INFO cursorInfo = new CONSOLE_CURSOR_INFO;

	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			cout << '[' << wherex() << ' ' << wherey() << ']';
		}
		cout << '\n';
	}

	cout << "click anywhere in console window to write - hello world -\n\n\n\n\n\n\n\n\n\n\n\n\n"
		"Press Ctrl+C to Exit";
	
	HANDLE hin = GetStdHandle(STD_INPUT_HANDLE);
	INPUT_RECORD InputRecord;
	DWORD Events;
	COORD coord;
	CONSOLE_CURSOR_INFO cci;
	cci.dwSize = 25;
	cci.bVisible = FALSE;
	SetConsoleCursorInfo(hout, &cci);
	SetConsoleMode(hin, ENABLE_EXTENDED_FLAGS | ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT);


	while (1)
	{

		ReadConsoleInput(hin, &InputRecord, 1, &Events);

		if (InputRecord.EventType == MOUSE_EVENT)
		{
			if (InputRecord.Event.MouseEvent.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED)
			{
				coord.X = InputRecord.Event.MouseEvent.dwMousePosition.X;
				coord.Y = InputRecord.Event.MouseEvent.dwMousePosition.Y;
				SetConsoleCursorPosition(hout, coord);
				SetConsoleTextAttribute(hout, rand() % 7 + 9);
				cout << "*";

			}
		}
		FlushConsoleInputBuffer(hin);
	}
	return 0;
}

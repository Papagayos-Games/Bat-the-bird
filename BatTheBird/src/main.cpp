#include <iostream>
#include "PapagayoEngine.h"

#if (defined _DEBUG) || !(defined _WIN32)
int main() {

#else
#include <Windows.h>
//int WINAPI
//WinMain(HINSTANCE zhInstance, HINSTANCE prevInstance, LPSTR lpCmdLine, int nCmdShow) {
int main() {
	HWND windowHandle = GetConsoleWindow();
	ShowWindow(windowHandle, SW_HIDE);
#endif
#ifdef _DEBUG
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
#endif
	try {
		if (!PapagayoEngine::setupInstance("Bat the Bird"))
			throw std::exception("Couldn't Initialize Papagayo Engine\n");
		PapagayoEngine::getInstance()->init(
			"TaharezLook",
			"TaharezLook.scheme", 
			"DejaVuSans-12.font", 
			"Scenes/scenes.json",
			"Assets/badbunny.mp3",
			"SkyPlaneMat"
		);
	}
	catch (std::exception e) {
		std::cout << e.what() << "\n";
		return -1;
	}
	catch (const std::string & e) {
		std::cout << e << "\n";
		return -1;
	}
	catch (...) {
		std::cout << "EXCEPCION NO CONTROLADA\n";
		return -1;
	}
	try {
		PapagayoEngine::getInstance()->run();
	}
	catch (std::exception e) {
		std::cout << e.what() << "\n";
	}
	catch (const std::string & e) {
		std::cout << e << "\n";
	}
	catch (...) {
		std::cout << "EXCEPCION NO CONTROLADA\n";
	}
	try {
		PapagayoEngine::getInstance()->destroy();
	}
	catch (std::exception e) {
		std::cout << e.what() << "\n";
	}
	catch (const std::string & e) {
		std::cout << e << "\n";
	}
	catch (...) {
		std::cout << "EXCEPCION NO CONTROLADA\n";
	}

	return 0;
}
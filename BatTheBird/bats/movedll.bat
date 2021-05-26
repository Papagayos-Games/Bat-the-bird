@echo off

echo ---------------------------------------------------
echo Moviendo .lib de Papagayo-Engine a bin
echo ---------------------------------------------------

echo moviendo Common lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\Common_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Common.lib ..\bin

echo moviendo Input lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\Input_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Input.lib ..\bin

echo moviendo Graphics lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\Graphics_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Graphics.lib ..\bin

echo moviendo Physics lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\Physics_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Physics.lib ..\bin

echo moviendo Audio lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\Audio_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Audio.lib ..\bin

echo moviendo UI lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\UI_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\UI.lib ..\bin

echo moviendo LUA lib
copy ..\dependencies\Papagayo-Engine\Engine\bin\LUA_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\LUA.lib ..\bin

echo Moviendo PapagayoEngine
copy ..\dependencies\Papagayo-Engine\Engine\bin\PapagayoEngine_d.lib ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\PapagayoEngine.lib ..\bin

echo Moviendo dll y libs adicionales de Debug
copy ..\dependencies\Papagayo-Engine\Engine\bin\SDL2.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\OgreMain_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\OgreRTShaderSystem_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Codec_STBI_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Plugin_ParticleFX_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\RenderSystem_Direct3D11_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\RenderSystem_GL_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\CEGUIBase-0_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\CEGUIOgreRenderer-0_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\freetype_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\pcre_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\libexpat_d.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\lua54.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\zlib.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\fmodL.dll ..\bin

::revisar porque como de momento release no compila no lo he podido probar
echo Moviendo dll y libs adicionales Release
copy ..\dependencies\Papagayo-Engine\Engine\bin\OgreMain.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\OgreRTShaderSystem.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Codec_STBI.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\Plugin_ParticleFX.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\RenderSystem_Direct3D11.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\RenderSystem_GL.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\CEGUIBase-0.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\CEGUIOgreRenderer-0.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\freetype.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\pcre.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\libexpat.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\lua54.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\zlib.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\bin\fmod.dll ..\bin

echo ---------------------------------------------------
echo Moviendo archivos necesarios para generar el instalador
echo ---------------------------------------------------

copy ..\dependencies\Papagayo-Engine\Engine\dependencies\cegui\build\bin\CEGUICoreWindowRendererSet.dll ..\bin
copy ..\dependencies\Papagayo-Engine\Engine\dependencies\cegui\build\bin\CEGUIExpatParser.dll ..\bin

echo ---------------------------------------------------
echo FIN
echo ---------------------------------------------------

PAUSE
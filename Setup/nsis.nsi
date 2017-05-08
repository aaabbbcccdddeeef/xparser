; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���
!include "WordFunc.nsh"
; ��װ�����ʼ���峣��
!define PRODUCT_NAME "XBox"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "My company, Inc."
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\xbox.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "64px.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "Licence.txt"
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!define MUI_FINISHPAGE_RUN "$INSTDIR\xbox.exe"
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "XBoxSetup.exe"
InstallDir "$PROGRAMFILES\XBox"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "XBox"

Section "MainSection" SEC01
DetailPrint "���ڰ�װ������..."
  SetOutPath "$INSTDIR"
  Call KillMainProc
  SetOverwrite ifnewer
  CreateDirectory "$SMPROGRAMS\XBox"
  CreateShortCut "$SMPROGRAMS\XBox\XBox.lnk" "$INSTDIR\xbox.exe"
  CreateShortCut "$DESKTOP\XBox.lnk" "$INSTDIR\xbox.exe"
  File "..\_Build\xbox\xinput1_3.dll"
  File "..\_Build\xbox\xbox.exe"
  File "..\_Build\xbox\views_resources_200_percent.pak"
  File "..\_Build\xbox\ui_resources_200_percent.pak"
  File "..\_Build\xbox\snapshot_blob.bin"
  File "..\_Build\xbox\node.dll"
  File "..\_Build\xbox\natives_blob.bin"
  File "..\_Build\xbox\LICENSES.chromium.html"
  File "..\_Build\xbox\LICENSE.electron.txt"
  File "..\_Build\xbox\libGLESv2.dll"
  File "..\_Build\xbox\libEGL.dll"
  File "..\_Build\xbox\icudtl.dat"
  File "..\_Build\xbox\ffmpeg.dll"
  File "..\_Build\xbox\d3dcompiler_47.dll"
  File "..\_Build\xbox\content_shell.pak"
  File "..\_Build\xbox\content_resources_200_percent.pak"
  File "..\_Build\xbox\blink_image_resources_200_percent.pak"
  SetOutPath "$INSTDIR\\locales"
  File /r "..\_Build\xbox\locales\*.*"
  SetOutPath "$INSTDIR\\\resources"
  File /r "..\_Build\xbox\resources\*.*"
  SetOutPath "$INSTDIR\\\data"
  File /r "..\_Build\xbox\data\*.*"
SectionEnd

Section "XParser" SEC02
  DetailPrint "���ڰ�װ������..."
  SetOutPath "$INSTDIR\XParser"
  File /r "..\_Build\xbox\XParser\*.*"
  CreateShortCut "$DESKTOP\XParser.lnk" "$INSTDIR\XParser\XParser.exe"
  CreateShortCut "$SMPROGRAMS\XBox\XParser.lnk" "$INSTDIR\XParser\XParser.exe"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateShortCut "$SMPROGRAMS\XBox\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\xbox.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\xbox.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Section -SetAccessControl
DetailPrint "��������Ŀ¼Ȩ��..."
AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
SectionEnd

Section -RegService
  Call StopService
  DetailPrint "���ڰ�װ��������..."
  nsExec::Exec "$INSTDIR\XParser\_Install.Start.bat"
SectionEnd

/******************************
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/

Section Uninstall
  Call un.KillMainProc
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\blink_image_resources_200_percent.pak"
  Delete "$INSTDIR\content_resources_200_percent.pak"
  Delete "$INSTDIR\content_shell.pak"
  Delete "$INSTDIR\d3dcompiler_47.dll"
  Delete "$INSTDIR\ffmpeg.dll"
  Delete "$INSTDIR\icudtl.dat"
  Delete "$INSTDIR\libEGL.dll"
  Delete "$INSTDIR\libGLESv2.dll"
  Delete "$INSTDIR\LICENSE.electron.txt"
  Delete "$INSTDIR\LICENSES.chromium.html"
  Delete "$INSTDIR\natives_blob.bin"
  Delete "$INSTDIR\node.dll"
  Delete "$INSTDIR\snapshot_blob.bin"
  Delete "$INSTDIR\ui_resources_200_percent.pak"
  Delete "$INSTDIR\views_resources_200_percent.pak"
  Delete "$INSTDIR\xbox.exe"
  Delete "$INSTDIR\xinput1_3.dll"

  Delete "$SMPROGRAMS\XBox\Uninstall.lnk"
  Delete "$SMPROGRAMS\XBox\XParser.lnk"
  Delete "$DESKTOP\XParser.lnk"
  Delete "$DESKTOP\XBox.lnk"
  Delete "$SMPROGRAMS\XBox\XBox.lnk"

	Call un.StopService
	 
  RMDir "$SMPROGRAMS\XBox"

  RMDir /r "$INSTDIR\XParser"
  RMDir /r "$INSTDIR\\locales"
  RMDir /r "$INSTDIR\\\resources"
  RMDir /r "$INSTDIR\\\data"
  
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#
Function .onInit
    nsisos::osversion
    ${If} $0 < 6
        MessageBox MB_OK "ֻ֧��Windows 7 ������ϵͳ"
        Abort
    ${EndIf}
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
FunctionEnd

Function KillMainProc
    FindProcDLL::FindProc "xbox.exe"
    Sleep 500
    Pop $R0
    ${If} $R0 != 0
    	KillProcDLL::KillProc "xbox.exe"
    ${EndIf}
FunctionEnd

Function StopService
  SimpleSC::ExistsService "XParserService"
  Pop $0
  ${If} $0 != 0
      DetailPrint "����ֹͣ��������..."
      SimpleSC::StopService "XParserService"

      DetailPrint "�����Ƴ���������..."
      SimpleSC::RemoveService "XParserService"
  ${EndIf}
FunctionEnd

Function un.KillMainProc
 FindProcDLL::FindProc "xbox.exe"
    Sleep 500
    Pop $R0
    ${If} $R0 != 0
    	KillProcDLL::KillProc "xbox.exe"
    ${EndIf}
FunctionEnd

Function un.StopService
  SimpleSC::ExistsService "XParserService"
  Pop $0
  ${If} $0 != 0
      DetailPrint "����ֹͣ��������..."
      SimpleSC::StopService "XParserService"

      DetailPrint "�����Ƴ���������..."
      SimpleSC::RemoveService "XParserService"
  ${EndIf}
FunctionEnd
